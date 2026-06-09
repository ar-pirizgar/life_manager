import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';

enum TimerCategory {
  deepWork('deep_work', 'کار عمیق'),
  shallowWork('shallow_work', 'کار سطحی'),
  learning('learning', 'یادگیری'),
  exercise('exercise', 'ورزش'),
  personal('personal', 'شخصی'),
  family('family', 'خانواده'),
  recovery('recovery', 'بازیابی'),
  misc('misc', 'متفرقه');

  const TimerCategory(this.key, this.label);

  final String key;
  final String label;

  static TimerCategory fromKey(String key) => TimerCategory.values.firstWhere(
        (e) => e.key == key,
        orElse: () => TimerCategory.misc,
      );
}

enum TimerStatus { idle, running, paused }

class TimerState {
  const TimerState({
    this.status = TimerStatus.idle,
    this.category = TimerCategory.deepWork,
    this.elapsed = Duration.zero,
    this.startedAt,
  });

  final TimerStatus status;
  final TimerCategory category;
  final Duration elapsed;
  final DateTime? startedAt;

  TimerState copyWith({
    TimerStatus? status,
    TimerCategory? category,
    Duration? elapsed,
    DateTime? startedAt,
  }) =>
      TimerState(
        status: status ?? this.status,
        category: category ?? this.category,
        elapsed: elapsed ?? this.elapsed,
        startedAt: startedAt ?? this.startedAt,
      );
}

class TimerNotifier extends Notifier<TimerState> {
  Timer? _ticker;
  final _stopwatch = Stopwatch();

  @override
  TimerState build() {
    ref.onDispose(() {
      _ticker?.cancel();
      _stopwatch.stop();
    });
    return const TimerState();
  }

  void setCategory(TimerCategory category) {
    if (state.status != TimerStatus.idle) return;
    state = state.copyWith(category: category);
  }

  void start() {
    if (state.status == TimerStatus.running) return;
    final startedAt = state.startedAt ?? DateTime.now();
    _stopwatch.start();
    state = state.copyWith(status: TimerStatus.running, startedAt: startedAt);
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      state = state.copyWith(elapsed: _stopwatch.elapsed);
    });
  }

  void pause() {
    if (state.status != TimerStatus.running) return;
    _stopwatch.stop();
    _ticker?.cancel();
    _ticker = null;
    state = state.copyWith(
      status: TimerStatus.paused,
      elapsed: _stopwatch.elapsed,
    );
  }

  Future<void> stop() async {
    if (state.status == TimerStatus.idle) return;
    _stopwatch.stop();
    _ticker?.cancel();
    _ticker = null;

    final elapsed = _stopwatch.elapsed;
    final startedAt = state.startedAt ?? DateTime.now();

    if (elapsed.inSeconds >= 5) {
      final db = ref.read(databaseProvider);
      await db.insertTimeLog(
        TimeLogsCompanion(
          id: Value(const Uuid().v4()),
          category: Value(state.category.key),
          durationSeconds: Value(elapsed.inSeconds),
          startedAt: Value(startedAt),
          endedAt: Value(DateTime.now()),
        ),
      );
    }

    _stopwatch.reset();
    state = const TimerState();
  }

  void discard() {
    _stopwatch.stop();
    _stopwatch.reset();
    _ticker?.cancel();
    _ticker = null;
    state = const TimerState();
  }
}

final timerNotifierProvider =
    NotifierProvider<TimerNotifier, TimerState>(TimerNotifier.new);

final todayTimeLogsProvider = StreamProvider<List<TimeLog>>((ref) {
  return ref.watch(databaseProvider).watchTodayTimeLogs();
});

final todayTotalSecondsProvider = Provider<int>((ref) {
  return ref.watch(todayTimeLogsProvider).when(
        data: (logs) => logs.fold(0, (sum, l) => sum + l.durationSeconds),
        loading: () => 0,
        error: (_, __) => 0,
      );
});
