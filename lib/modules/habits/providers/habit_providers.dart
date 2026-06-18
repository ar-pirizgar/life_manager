import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';

// ─── Enums ────────────────────────────────────────────────────

enum HabitTimeOfDay {
  any('any', 'هر زمان'),
  morning('morning', 'صبح'),
  afternoon('afternoon', 'بعد از ظهر'),
  evening('evening', 'شب');

  const HabitTimeOfDay(this.key, this.label);
  final String key;
  final String label;
  static HabitTimeOfDay fromKey(String key) =>
      HabitTimeOfDay.values.firstWhere(
        (e) => e.key == key,
        orElse: () => HabitTimeOfDay.any,
      );
}

// ─── Metrics Model ────────────────────────────────────────────

class HabitMetrics {
  const HabitMetrics({
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.successRate = 0.0,
    this.last7Days = const [],
  });

  final int currentStreak;
  final int bestStreak;
  final double successRate; // 0.0–1.0
  final List<bool> last7Days; // index 0 = 6 days ago, 6 = today
}

HabitMetrics computeMetrics(List<HabitLog> logs, DateTime createdAt) {
  final today = _day(DateTime.now());

  final doneDates = <DateTime>{};
  for (final l in logs) {
    if (l.status == 'done') doneDates.add(_day(l.date));
  }

  // Current streak: count backwards from today (or yesterday if today empty)
  int currentStreak = 0;
  DateTime cursor = doneDates.contains(today)
      ? today
      : today.subtract(const Duration(days: 1));
  while (doneDates.contains(cursor)) {
    currentStreak++;
    cursor = cursor.subtract(const Duration(days: 1));
  }

  // Best streak
  int bestStreak = 0;
  if (doneDates.isNotEmpty) {
    final sorted = doneDates.toList()..sort();
    int run = 1;
    bestStreak = 1;
    for (int i = 1; i < sorted.length; i++) {
      final diff = sorted[i].difference(sorted[i - 1]).inDays;
      if (diff == 1) {
        run++;
        if (run > bestStreak) bestStreak = run;
      } else if (diff > 1) {
        run = 1;
      }
    }
  }

  // Success rate: completed / total days since creation
  final createdDay = _day(createdAt);
  final totalDays = today.difference(createdDay).inDays + 1;
  final successRate =
      totalDays <= 0 ? 0.0 : (doneDates.length / totalDays).clamp(0.0, 1.0);

  // Last 7 days (index 0 = 6 days ago, index 6 = today)
  final last7Days = List.generate(
    7,
    (i) => doneDates.contains(today.subtract(Duration(days: 6 - i))),
  );

  return HabitMetrics(
    currentStreak: currentStreak,
    bestStreak: bestStreak,
    successRate: successRate,
    last7Days: last7Days,
  );
}

DateTime _day(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

// ─── Providers ────────────────────────────────────────────────

final activeHabitsProvider = StreamProvider<List<Habit>>((ref) {
  // keepAlive prevents disposal when no widget is watching (e.g. between
  // navigations), eliminating the loading flash and any transient error state
  // on re-entry to the Habits screen.
  ref.keepAlive();
  return ref.watch(databaseProvider).watchActiveHabits();
});

final todayHabitLogsProvider = StreamProvider<List<HabitLog>>((ref) {
  ref.keepAlive();
  return ref.watch(databaseProvider).watchTodayHabitLogs();
});

final todayDoneSetProvider = Provider<Set<String>>((ref) {
  final logs = ref.watch(todayHabitLogsProvider).valueOrNull ?? [];
  return {for (final l in logs) if (l.status == 'done') l.habitId};
});

final todayProgressProvider = Provider<(int, int)>((ref) {
  final habits = ref.watch(activeHabitsProvider).valueOrNull ?? [];
  final done = ref.watch(todayDoneSetProvider).length;
  return (done, habits.length);
});

final habitLogsProvider =
    StreamProvider.family<List<HabitLog>, String>((ref, habitId) {
  return ref.watch(databaseProvider).watchHabitLogs(habitId);
});
