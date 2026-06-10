import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';
import '../../goals/providers/goal_providers.dart';
import '../../habits/providers/habit_providers.dart';
import '../../tasks/providers/task_providers.dart';
import '../../timer/providers/timer_providers.dart';

const _uuid = Uuid();

// ── KPI Providers ─────────────────────────────────────────────

final activeKpisProvider = StreamProvider<List<Kpi>>((ref) {
  return ref.watch(databaseProvider).watchActiveKpis();
});

final kpiLogsProvider =
    StreamProvider.family<List<KpiLog>, String>((ref, kpiId) {
  return ref.watch(databaseProvider).watchKpiLogs(kpiId);
});

final latestKpiLogProvider =
    FutureProvider.family<KpiLog?, String>((ref, kpiId) {
  return ref.watch(databaseProvider).getLatestKpiLog(kpiId);
});

class KpiNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> addKpi({
    required String title,
    required String unit,
    required String emoji,
    required String direction,
    double? targetValue,
  }) async {
    final db = ref.read(databaseProvider);
    await db.insertKpi(KpisCompanion.insert(
      id: _uuid.v4(),
      title: title,
      unit: unit,
      emoji: Value(emoji),
      direction: Value(direction),
      targetValue: Value(targetValue),
    ));
  }

  Future<void> updateKpi({
    required String id,
    required String title,
    required String unit,
    required String emoji,
    required String direction,
    double? targetValue,
  }) async {
    final db = ref.read(databaseProvider);
    await db.updateKpi(KpisCompanion(
      id: Value(id),
      title: Value(title),
      unit: Value(unit),
      emoji: Value(emoji),
      direction: Value(direction),
      targetValue: Value(targetValue),
    ));
  }

  Future<void> archiveKpi(String id) async {
    await ref.read(databaseProvider).archiveKpi(id);
  }

  Future<void> logValue({
    required String kpiId,
    required double value,
    String? notes,
    DateTime? date,
  }) async {
    final db = ref.read(databaseProvider);
    await db.insertKpiLog(KpiLogsCompanion.insert(
      id: _uuid.v4(),
      kpiId: kpiId,
      value: value,
      date: date ?? DateTime.now(),
      notes: Value(notes),
    ));
  }

  Future<void> deleteKpiLog(String id) async {
    await ref.read(databaseProvider).deleteKpiLog(id);
  }
}

final kpiNotifierProvider =
    AsyncNotifierProvider<KpiNotifier, void>(KpiNotifier.new);

// ── Score Providers ───────────────────────────────────────────

final weekTimeLogsProvider = StreamProvider<List<TimeLog>>((ref) {
  return ref.watch(databaseProvider).watchWeekTimeLogs();
});

/// Daily Score: Task 30% + Habit 30% + Goal 20% + Time 20%
final dailyScoreProvider = Provider<double>((ref) {
  final tasks = ref.watch(todayTasksProvider).valueOrNull ?? [];
  final habits = ref.watch(activeHabitsProvider).valueOrNull ?? [];
  final todayDone = ref.watch(todayDoneSetProvider);
  final timeLogs = ref.watch(todayTimeLogsProvider).valueOrNull ?? [];
  final allGoals = ref.watch(allLongGoalsProvider).valueOrNull ?? [];
  final activeGoals = allGoals.where((g) => g.status == 'active').toList();

  // Task completion (30%)
  final taskDone = tasks.where((t) => t.status == 'done').length;
  final taskScore = tasks.isEmpty ? 0.5 : taskDone / tasks.length;

  // Habit completion (30%)
  final habitScore =
      habits.isEmpty ? 0.5 : todayDone.length / habits.length;

  // Goal existence (20%)
  final goalScore = activeGoals.isEmpty ? 0.0 : 0.5;

  // Time tracking (20%)
  final timeScore = timeLogs.isEmpty ? 0.0 : 1.0;

  final raw = (taskScore * 0.30) +
      (habitScore * 0.30) +
      (goalScore * 0.20) +
      (timeScore * 0.20);
  return (raw * 100).clamp(0.0, 100.0);
});

/// Focus Score: Task 25% + Habit 20% + Goal 20% + DeepWork 20% + Planning 15%
final focusScoreProvider = Provider<double>((ref) {
  final tasks = ref.watch(todayTasksProvider).valueOrNull ?? [];
  final habits = ref.watch(activeHabitsProvider).valueOrNull ?? [];
  final todayDone = ref.watch(todayDoneSetProvider);
  final timeLogs = ref.watch(todayTimeLogsProvider).valueOrNull ?? [];
  final allGoals = ref.watch(allLongGoalsProvider).valueOrNull ?? [];
  final activeGoals = allGoals.where((g) => g.status == 'active').toList();
  final allTasks = ref.watch(allTasksProvider).valueOrNull ?? [];

  // Task completion (25%)
  final taskDone = tasks.where((t) => t.status == 'done').length;
  final taskScore = tasks.isEmpty ? 0.5 : taskDone / tasks.length;

  // Habit completion (20%)
  final habitScore =
      habits.isEmpty ? 0.5 : todayDone.length / habits.length;

  // Goal existence (20%)
  final goalScore = activeGoals.isEmpty ? 0.0 : 0.5;

  // Deep work (20%) — target: 2 hours
  final deepSecs = timeLogs
      .where((t) => t.category == 'deep_work')
      .fold(0, (s, t) => s + t.durationSeconds);
  final deepWorkScore = (deepSecs / 7200.0).clamp(0.0, 1.0);

  // Planning consistency (15%) — has future tasks planned?
  final tomorrow = DateTime.now().add(const Duration(days: 1));
  final hasFuture =
      allTasks.any((t) => t.status == 'pending' && t.dueDate.isAfter(tomorrow));
  final planningScore = hasFuture ? 1.0 : 0.0;

  final raw = (taskScore * 0.25) +
      (habitScore * 0.20) +
      (goalScore * 0.20) +
      (deepWorkScore * 0.20) +
      (planningScore * 0.15);
  return (raw * 100).clamp(0.0, 100.0);
});

/// Life Balance Score: based on timer category diversity + habits + finance
final lifeBalanceScoreProvider = Provider<double>((ref) {
  final weekLogs = ref.watch(weekTimeLogsProvider).valueOrNull ?? [];
  final habits = ref.watch(activeHabitsProvider).valueOrNull ?? [];
  final todayDone = ref.watch(todayDoneSetProvider);

  // 6 meaningful life zones based on timer categories (50%)
  const zones = [
    'deep_work',
    'learning',
    'exercise',
    'personal',
    'family',
    'recovery',
  ];
  final usedCategories = weekLogs.map((l) => l.category).toSet();
  final zonesCovered = zones.where((z) => usedCategories.contains(z)).length;
  final diversityScore = zones.isEmpty ? 0.0 : zonesCovered / zones.length;

  // Habit consistency today (50%)
  final habitScore =
      habits.isEmpty ? 0.5 : todayDone.length / habits.length;

  final raw = (diversityScore * 0.50) + (habitScore * 0.50);
  return (raw * 100).clamp(0.0, 100.0);
});
