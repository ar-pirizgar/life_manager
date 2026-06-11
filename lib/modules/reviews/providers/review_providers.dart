import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';

const _uuid = Uuid();

// ── Models ────────────────────────────────────────────────────

class WeekStats {
  const WeekStats({
    required this.completedTasks,
    required this.totalTasks,
    required this.totalHabits,
    required this.doneHabitLogs,
    required this.totalMinutes,
    required this.deepWorkMinutes,
    required this.income,
    required this.expense,
    required this.activeGoals,
    required this.completedGoals,
  });

  final int completedTasks;
  final int totalTasks;
  final int totalHabits;
  final int doneHabitLogs;
  final int totalMinutes;
  final int deepWorkMinutes;
  final double income;
  final double expense;
  final int activeGoals;
  final int completedGoals;

  double get habitSuccessRate {
    final possible = totalHabits * 7;
    if (possible == 0) return 0.0;
    return (doneHabitLogs / possible).clamp(0.0, 1.0);
  }
}

class GoalHealthInfo {
  const GoalHealthInfo({
    required this.goal,
    required this.health,
    required this.totalShort,
    required this.completedShort,
  });

  final LongGoal goal;
  final String health; // on_track | at_risk | off_track
  final int totalShort;
  final int completedShort;
}

// ── Week helpers ──────────────────────────────────────────────

/// شنبه اول هفته شمسی جاری را برمی‌گرداند.
DateTime weekStartOf(DateTime date) {
  final d = DateTime(date.year, date.month, date.day);
  // Dart: Mon=1 ... Sat=6, Sun=7
  // days since last Saturday: (weekday - 6 + 7) % 7
  final diff = (d.weekday - 6 + 7) % 7;
  return d.subtract(Duration(days: diff));
}

// ── Saved review providers ────────────────────────────────────

final allWeeklyReviewsProvider = StreamProvider<List<WeeklyReview>>((ref) {
  return ref.watch(databaseProvider).watchAllWeeklyReviews();
});

final allMonthlyReflectionsProvider =
    StreamProvider<List<MonthlyReflection>>((ref) {
  return ref.watch(databaseProvider).watchAllMonthlyReflections();
});

// ── Stats computation ─────────────────────────────────────────

final weekStatsProvider =
    FutureProvider.family<WeekStats, DateTime>((ref, weekStart) async {
  final db = ref.watch(databaseProvider);
  final weekEnd = weekStart.add(const Duration(days: 7));

  final results = await Future.wait([
    db.getTasksInRange(weekStart, weekEnd),
    db.getHabitLogsInRange(weekStart, weekEnd),
    db.getTimeLogsInRange(weekStart, weekEnd),
    db.getTransactionsInRange(weekStart, weekEnd),
    db.watchActiveHabits().first,
    db.getAllLongGoals(),
  ]);

  final taskList = results[0] as List<Task>;
  final habitLogList = results[1] as List<HabitLog>;
  final timeLogList = results[2] as List<TimeLog>;
  final txList = results[3] as List<Transaction>;
  final habitList = results[4] as List<Habit>;
  final goalList = results[5] as List<LongGoal>;

  final completedTasks = taskList.where((t) => t.status == 'done').length;
  final doneHabitLogs =
      habitLogList.where((l) => l.status == 'done').length;
  final totalMinutes = timeLogList.fold<int>(
    0,
    (s, t) => s + (t.durationSeconds ~/ 60),
  );
  final deepWorkMinutes = timeLogList
      .where((t) => t.category == 'deep_work')
      .fold<int>(0, (s, t) => s + (t.durationSeconds ~/ 60));
  final income = txList
      .where((t) => t.type == 'income')
      .fold<double>(0, (s, t) => s + t.amount);
  final expense = txList
      .where((t) => t.type == 'expense')
      .fold<double>(0, (s, t) => s + t.amount);
  final activeGoals =
      goalList.where((g) => g.status == 'active').length;
  final completedGoals =
      goalList.where((g) => g.status == 'completed').length;

  return WeekStats(
    completedTasks: completedTasks,
    totalTasks: taskList.length,
    totalHabits: habitList.length,
    doneHabitLogs: doneHabitLogs,
    totalMinutes: totalMinutes,
    deepWorkMinutes: deepWorkMinutes,
    income: income,
    expense: expense,
    activeGoals: activeGoals,
    completedGoals: completedGoals,
  );
});

// ── Goal health (Goal Review Engine) ─────────────────────────

final goalHealthProvider =
    FutureProvider<List<GoalHealthInfo>>((ref) async {
  final db = ref.watch(databaseProvider);
  final longGoals = await db.getAllLongGoals();
  final shortGoals = await db.getAllShortGoals();
  final active = longGoals.where((g) => g.status == 'active').toList();

  return active.map((goal) {
    final related =
        shortGoals.where((s) => s.longGoalId == goal.id).toList();
    final completed =
        related.where((s) => s.status == 'completed').length;
    final total = related.length;
    final health = _computeGoalHealth(goal, total, completed);
    return GoalHealthInfo(
      goal: goal,
      health: health,
      totalShort: total,
      completedShort: completed,
    );
  }).toList();
});

String _computeGoalHealth(LongGoal goal, int total, int completed) {
  final now = DateTime.now();
  final deadline = goal.deadline;
  if (deadline != null && deadline.isBefore(now)) return 'off_track';
  if (deadline != null) {
    final daysLeft = deadline.difference(now).inDays;
    if (daysLeft <= 30) {
      final rate = total == 0 ? 0.0 : completed / total;
      if (rate < 0.5) return 'at_risk';
    }
  }
  return 'on_track';
}

// ── Notifier ──────────────────────────────────────────────────

class ReviewNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> saveWeeklyReview({
    required DateTime weekStart,
    required WeekStats stats,
    String? answeredWorked,
    String? answeredFailed,
    String? answeredLearned,
  }) async {
    final db = ref.read(databaseProvider);
    final existing = await db.getWeeklyReviewForWeek(weekStart);

    if (existing != null) {
      await (db.update(db.weeklyReviews)
            ..where((r) => r.id.equals(existing.id)))
          .write(WeeklyReviewsCompanion(
        completedTasks: Value(stats.completedTasks),
        totalTasks: Value(stats.totalTasks),
        habitSuccessRate: Value(stats.habitSuccessRate),
        totalMinutes: Value(stats.totalMinutes),
        deepWorkMinutes: Value(stats.deepWorkMinutes),
        income: Value(stats.income),
        expense: Value(stats.expense),
        activeGoalsCount: Value(stats.activeGoals),
        completedGoalsCount: Value(stats.completedGoals),
        answeredWorked: Value(answeredWorked),
        answeredFailed: Value(answeredFailed),
        answeredLearned: Value(answeredLearned),
      ));
    } else {
      await db.into(db.weeklyReviews).insert(WeeklyReviewsCompanion.insert(
        id: _uuid.v4(),
        weekStart: weekStart,
        completedTasks: Value(stats.completedTasks),
        totalTasks: Value(stats.totalTasks),
        habitSuccessRate: Value(stats.habitSuccessRate),
        totalMinutes: Value(stats.totalMinutes),
        deepWorkMinutes: Value(stats.deepWorkMinutes),
        income: Value(stats.income),
        expense: Value(stats.expense),
        activeGoalsCount: Value(stats.activeGoals),
        completedGoalsCount: Value(stats.completedGoals),
        answeredWorked: Value(answeredWorked),
        answeredFailed: Value(answeredFailed),
        answeredLearned: Value(answeredLearned),
      ));
    }
  }

  Future<void> saveMonthlyReflection({
    required int year,
    required int month,
    String? answeredContinue,
    String? answeredStop,
    String? answeredStart,
    String? answeredProud,
  }) async {
    final db = ref.read(databaseProvider);
    final existing = await db.getMonthlyReflection(year, month);

    if (existing != null) {
      await (db.update(db.monthlyReflections)
            ..where((r) => r.id.equals(existing.id)))
          .write(MonthlyReflectionsCompanion(
        answeredContinue: Value(answeredContinue),
        answeredStop: Value(answeredStop),
        answeredStart: Value(answeredStart),
        answeredProud: Value(answeredProud),
      ));
    } else {
      await db
          .into(db.monthlyReflections)
          .insert(MonthlyReflectionsCompanion.insert(
        id: _uuid.v4(),
        year: year,
        month: month,
        answeredContinue: Value(answeredContinue),
        answeredStop: Value(answeredStop),
        answeredStart: Value(answeredStart),
        answeredProud: Value(answeredProud),
      ));
    }
  }
}

final reviewNotifierProvider =
    AsyncNotifierProvider<ReviewNotifier, void>(ReviewNotifier.new);
