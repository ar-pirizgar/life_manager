import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

part 'database.g.dart';

// ============================================================
// جداول دیتابیس
// هر ماژول جداول خودش را اینجا تعریف می‌کند.
// برای اضافه کردن ماژول جدید، فقط جدول جدید را اضافه کنید
// و schemaVersion را افزایش دهید.
// ============================================================

// --- ماژول اهداف ---

class LongGoals extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get deadline => dateTime().nullable()();
  // active | completed | paused
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class ShortGoals extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get longGoalId =>
      text().nullable().references(LongGoals, #id)();
  DateTimeColumn get deadline => dateTime().nullable()();
  // active | completed
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// --- ماژول تسک‌ها ---

class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  // تاریخ انجام تسک
  DateTimeColumn get dueDate => dateTime()();
  // لینک اختیاری به هدف کوتاه‌مدت
  TextColumn get shortGoalId =>
      text().nullable().references(ShortGoals, #id)();
  // برچسب/دسته‌بندی آزاد
  TextColumn get category => text().nullable()();
  TextColumn get notes => text().nullable()();
  // pending | done | cancelled
  TextColumn get status => text().withDefault(const Constant('pending'))();
  // high | medium | low
  TextColumn get priority => text().withDefault(const Constant('medium'))();
  // آیا این تسک به‌صورت خودکار توسط یک عادت ساخته شده؟
  TextColumn get habitId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// --- ماژول مالی ---

class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  RealColumn get amount => real()();
  // expense | income
  TextColumn get type => text()();
  TextColumn get category => text()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Debts extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().nullable()();
  RealColumn get amount => real()();
  TextColumn get person => text()();
  // i_owe | they_owe
  TextColumn get direction => text()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  // active | settled
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class FinancialGoals extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  RealColumn get targetAmount => real()();
  RealColumn get currentAmount =>
      real().withDefault(const Constant<double>(0))();
  DateTimeColumn get deadline => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  // active | completed | cancelled
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// --- ماژول عادت‌ها ---

class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  // emoji for display
  TextColumn get emoji => text().withDefault(const Constant('✅'))();
  // morning | afternoon | evening | any
  TextColumn get timeOfDay => text().withDefault(const Constant('any'))();
  // active | archived
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class HabitLogs extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text().references(Habits, #id)();
  // normalized to start-of-day
  DateTimeColumn get date => dateTime()();
  // done | skipped
  TextColumn get status => text().withDefault(const Constant('done'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// --- ماژول سلامت ---

class HealthLogs extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  RealColumn get weight => real().nullable()();
  RealColumn get waistCm => real().nullable()();
  RealColumn get bodyFatPct => real().nullable()();
  IntColumn get energyLevel => integer().nullable()();
  IntColumn get sleepQuality => integer().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class HealthTargets extends Table {
  TextColumn get id => text()();
  RealColumn get targetWeight => real().nullable()();
  RealColumn get targetWaistCm => real().nullable()();
  RealColumn get targetBodyFatPct => real().nullable()();
  DateTimeColumn get targetDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// --- ماژول مرور و بازتاب ---

class WeeklyReviews extends Table {
  TextColumn get id => text()();
  DateTimeColumn get weekStart => dateTime()();
  IntColumn get completedTasks => integer().withDefault(const Constant(0))();
  IntColumn get totalTasks => integer().withDefault(const Constant(0))();
  RealColumn get habitSuccessRate =>
      real().withDefault(const Constant<double>(0))();
  IntColumn get totalMinutes => integer().withDefault(const Constant(0))();
  IntColumn get deepWorkMinutes => integer().withDefault(const Constant(0))();
  RealColumn get income => real().withDefault(const Constant<double>(0))();
  RealColumn get expense => real().withDefault(const Constant<double>(0))();
  IntColumn get activeGoalsCount => integer().withDefault(const Constant(0))();
  IntColumn get completedGoalsCount =>
      integer().withDefault(const Constant(0))();
  TextColumn get answeredWorked => text().nullable()();
  TextColumn get answeredFailed => text().nullable()();
  TextColumn get answeredLearned => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class MonthlyReflections extends Table {
  TextColumn get id => text()();
  IntColumn get year => integer()();
  IntColumn get month => integer()();
  TextColumn get answeredContinue => text().nullable()();
  TextColumn get answeredStop => text().nullable()();
  TextColumn get answeredStart => text().nullable()();
  TextColumn get answeredProud => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// --- ماژول KPI ---

class Kpis extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get unit => text()();
  TextColumn get emoji => text().withDefault(const Constant('📊'))();
  // higher_better | lower_better
  TextColumn get direction =>
      text().withDefault(const Constant('higher_better'))();
  RealColumn get targetValue => real().nullable()();
  // active | archived
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class KpiLogs extends Table {
  TextColumn get id => text()();
  TextColumn get kpiId => text().references(Kpis, #id)();
  RealColumn get value => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// --- ماژول تایمر ---

class TimeLogs extends Table {
  TextColumn get id => text()();
  // deep_work | shallow_work | learning | exercise | personal | family | recovery | misc
  TextColumn get category => text()();
  TextColumn get taskId => text().nullable()();
  IntColumn get durationSeconds => integer()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// --- ماژول اقساط ---

class InstallmentLoans extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  // bank_loan | installment_purchase | credit_card | personal_debt | other
  TextColumn get type => text()();
  RealColumn get totalAmount => real()();
  RealColumn get installmentAmount => real()();
  IntColumn get totalInstallments => integer()();
  IntColumn get paidInstallments => integer().withDefault(const Constant(0))();
  IntColumn get dueDayOfMonth => integer()();
  IntColumn get reminderDayOfMonth => integer()();
  DateTimeColumn get startDate => dateTime()();
  // active | completed | cancelled
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class LoanInstallments extends Table {
  TextColumn get id => text()();
  TextColumn get loanId => text().references(InstallmentLoans, #id)();
  IntColumn get installmentNumber => integer()();
  IntColumn get month => integer()();
  IntColumn get year => integer()();
  RealColumn get amount => real()();
  DateTimeColumn get dueDate => dateTime()();
  DateTimeColumn get reminderDate => dateTime()();
  // pending | paid | overdue
  TextColumn get status => text().withDefault(const Constant('pending'))();
  DateTimeColumn get paidAt => dateTime().nullable()();
  TextColumn get taskId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// ============================================================
// تعریف دیتابیس
// ============================================================

@DriftDatabase(tables: [
  LongGoals, ShortGoals, Tasks,
  Transactions, Debts, FinancialGoals,
  Habits, HabitLogs,
  TimeLogs,
  Kpis, KpiLogs,
  WeeklyReviews, MonthlyReflections,
  HealthLogs, HealthTargets,
  InstallmentLoans, LoanInstallments,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(tasks, tasks.priority);
          }
          if (from < 3) {
            await m.createTable(timeLogs);
          }
          if (from < 4) {
            await m.createTable(transactions);
            await m.createTable(debts);
            await m.createTable(financialGoals);
          }
          if (from < 5) {
            await m.createTable(habits);
            await m.createTable(habitLogs);
          }
          if (from < 6) {
            await m.addColumn(tasks, tasks.description);
          }
          if (from < 7) {
            await m.createTable(kpis);
            await m.createTable(kpiLogs);
          }
          if (from < 8) {
            await m.createTable(weeklyReviews);
            await m.createTable(monthlyReflections);
          }
          if (from < 9) {
            await m.createTable(healthLogs);
            await m.createTable(healthTargets);
          }
          if (from < 10) {
            await m.createTable(installmentLoans);
            await m.createTable(loanInstallments);
          }
        },
      );

  // ── Habits ───────────────────────────────────────────────────

  Stream<List<Habit>> watchActiveHabits() =>
      (select(habits)
            ..where((h) => h.status.equals('active'))
            ..orderBy([(h) => OrderingTerm.asc(h.createdAt)]))
          .watch();

  Stream<List<HabitLog>> watchTodayHabitLogs() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));
    return (select(habitLogs)
          ..where((l) =>
              l.date.isBiggerOrEqualValue(start) &
              l.date.isSmallerThanValue(end)))
        .watch();
  }

  Stream<List<HabitLog>> watchHabitLogs(String habitId,
      {int days = 90}) {
    final since = DateTime.now().subtract(Duration(days: days));
    return (select(habitLogs)
          ..where((l) =>
              l.habitId.equals(habitId) &
              l.date.isBiggerOrEqualValue(since))
          ..orderBy([(l) => OrderingTerm.asc(l.date)]))
        .watch();
  }

  Future<void> toggleHabitLog(String habitId, DateTime date) {
    final dateOnly = DateTime(date.year, date.month, date.day);
    final nextDay = dateOnly.add(const Duration(days: 1));
    return transaction(() async {
      final existing = await (select(habitLogs)
            ..where((l) =>
                l.habitId.equals(habitId) &
                l.date.isBiggerOrEqualValue(dateOnly) &
                l.date.isSmallerThanValue(nextDay)))
          .getSingleOrNull();
      if (existing != null) {
        await (delete(habitLogs)
              ..where((l) => l.id.equals(existing.id)))
            .go();
      } else {
        await into(habitLogs).insert(HabitLogsCompanion(
          id: Value(const Uuid().v4()),
          habitId: Value(habitId),
          date: Value(dateOnly),
        ));
      }
    });
  }

  Future<void> archiveHabit(String habitId) =>
      (update(habits)..where((h) => h.id.equals(habitId)))
          .write(const HabitsCompanion(status: Value('archived')));

  Future<void> updateHabit(
    String habitId, {
    required String title,
    required String emoji,
    required String timeOfDay,
  }) =>
      (update(habits)..where((h) => h.id.equals(habitId))).write(
        HabitsCompanion(
          title: Value(title),
          emoji: Value(emoji),
          timeOfDay: Value(timeOfDay),
        ),
      );

  // ── Timer ────────────────────────────────────────────────────

  Stream<List<TimeLog>> watchTodayTimeLogs() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return (select(timeLogs)
          ..where((t) =>
              t.startedAt.isBiggerOrEqualValue(startOfDay) &
              t.startedAt.isSmallerThanValue(endOfDay))
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
        .watch();
  }

  Future<void> insertTimeLog(TimeLogsCompanion entry) =>
      into(timeLogs).insert(entry);

  Stream<List<TimeLog>> watchWeekTimeLogs() {
    final since = DateTime.now().subtract(const Duration(days: 7));
    return (select(timeLogs)
          ..where((t) => t.startedAt.isBiggerOrEqualValue(since))
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
        .watch();
  }

  // ── KPI ──────────────────────────────────────────────────────

  Stream<List<Kpi>> watchActiveKpis() =>
      (select(kpis)
            ..where((k) => k.status.equals('active'))
            ..orderBy([(k) => OrderingTerm.asc(k.createdAt)]))
          .watch();

  Stream<List<KpiLog>> watchKpiLogs(String kpiId) =>
      (select(kpiLogs)
            ..where((l) => l.kpiId.equals(kpiId))
            ..orderBy([(l) => OrderingTerm.desc(l.date)]))
          .watch();

  Future<KpiLog?> getLatestKpiLog(String kpiId) =>
      (select(kpiLogs)
            ..where((l) => l.kpiId.equals(kpiId))
            ..orderBy([(l) => OrderingTerm.desc(l.date)])
            ..limit(1))
          .getSingleOrNull();

  Future<void> insertKpi(KpisCompanion entry) =>
      into(kpis).insert(entry);

  Future<void> updateKpi(KpisCompanion entry) =>
      (update(kpis)..where((k) => k.id.equals(entry.id.value))).write(entry);

  Future<void> archiveKpi(String id) =>
      (update(kpis)..where((k) => k.id.equals(id)))
          .write(const KpisCompanion(status: Value('archived')));

  Future<void> deleteKpi(String id) =>
      (delete(kpis)..where((k) => k.id.equals(id))).go();

  Future<void> insertKpiLog(KpiLogsCompanion entry) =>
      into(kpiLogs).insert(entry);

  Future<void> deleteKpiLog(String id) =>
      (delete(kpiLogs)..where((l) => l.id.equals(id))).go();

  // ── Reviews ──────────────────────────────────────────────────

  Stream<List<WeeklyReview>> watchAllWeeklyReviews() =>
      (select(weeklyReviews)
            ..orderBy([(r) => OrderingTerm.desc(r.weekStart)]))
          .watch();

  Stream<List<MonthlyReflection>> watchAllMonthlyReflections() =>
      (select(monthlyReflections)
            ..orderBy([
              (r) => OrderingTerm.desc(r.year),
              (r) => OrderingTerm.desc(r.month),
            ]))
          .watch();

  Future<WeeklyReview?> getWeeklyReviewForWeek(DateTime weekStart) {
    final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
    final end = start.add(const Duration(days: 1));
    return (select(weeklyReviews)
          ..where((r) =>
              r.weekStart.isBiggerOrEqualValue(start) &
              r.weekStart.isSmallerThanValue(end)))
        .getSingleOrNull();
  }

  Future<MonthlyReflection?> getMonthlyReflection(int year, int month) =>
      (select(monthlyReflections)
            ..where((r) => r.year.equals(year) & r.month.equals(month)))
          .getSingleOrNull();

  Future<List<Task>> getTasksInRange(DateTime start, DateTime end) =>
      (select(tasks)
            ..where((t) =>
                t.dueDate.isBiggerOrEqualValue(start) &
                t.dueDate.isSmallerThanValue(end)))
          .get();

  Future<List<HabitLog>> getHabitLogsInRange(DateTime start, DateTime end) =>
      (select(habitLogs)
            ..where((l) =>
                l.date.isBiggerOrEqualValue(start) &
                l.date.isSmallerThanValue(end)))
          .get();

  Future<List<TimeLog>> getTimeLogsInRange(DateTime start, DateTime end) =>
      (select(timeLogs)
            ..where((t) =>
                t.startedAt.isBiggerOrEqualValue(start) &
                t.startedAt.isSmallerThanValue(end)))
          .get();

  Future<List<Transaction>> getTransactionsInRange(
          DateTime start, DateTime end) =>
      (select(transactions)
            ..where((t) =>
                t.date.isBiggerOrEqualValue(start) &
                t.date.isSmallerThanValue(end)))
          .get();

  Future<List<LongGoal>> getAllLongGoals() =>
      (select(longGoals)..orderBy([(g) => OrderingTerm.desc(g.createdAt)]))
          .get();

  Future<List<ShortGoal>> getAllShortGoals() =>
      (select(shortGoals)..orderBy([(g) => OrderingTerm.desc(g.createdAt)]))
          .get();

  // ── Health ───────────────────────────────────────────────────

  Stream<List<HealthLog>> watchAllHealthLogs() =>
      (select(healthLogs)
            ..orderBy([(l) => OrderingTerm.desc(l.date)]))
          .watch();

  Future<HealthLog?> getLatestHealthLog() =>
      (select(healthLogs)
            ..orderBy([(l) => OrderingTerm.desc(l.date)])
            ..limit(1))
          .getSingleOrNull();

  Future<HealthLog?> getFirstHealthLog() =>
      (select(healthLogs)
            ..orderBy([(l) => OrderingTerm.asc(l.date)])
            ..limit(1))
          .getSingleOrNull();

  Future<List<HealthLog>> getHealthLogsInRange(DateTime start, DateTime end) =>
      (select(healthLogs)
            ..where((l) =>
                l.date.isBiggerOrEqualValue(start) &
                l.date.isSmallerThanValue(end))
            ..orderBy([(l) => OrderingTerm.desc(l.date)]))
          .get();

  Future<List<HealthLog>> getHealthLogsForChart(int days) {
    final since = DateTime.now().subtract(Duration(days: days));
    return (select(healthLogs)
          ..where((l) => l.date.isBiggerOrEqualValue(since))
          ..orderBy([(l) => OrderingTerm.asc(l.date)]))
        .get();
  }

  Future<void> insertHealthLog(HealthLogsCompanion entry) =>
      into(healthLogs).insert(entry);

  Future<void> updateHealthLog(HealthLogsCompanion entry) =>
      (update(healthLogs)..where((l) => l.id.equals(entry.id.value))).write(entry);

  Future<void> deleteHealthLog(String id) =>
      (delete(healthLogs)..where((l) => l.id.equals(id))).go();

  Future<HealthTarget?> getHealthTarget() =>
      (select(healthTargets)..limit(1)).getSingleOrNull();

  Future<void> upsertHealthTarget(HealthTargetsCompanion entry) async {
    final existing =
        await (select(healthTargets)..limit(1)).getSingleOrNull();
    if (existing != null) {
      await (update(healthTargets)..where((t) => t.id.equals(existing.id)))
          .write(entry);
    } else {
      await into(healthTargets).insert(entry);
    }
  }

  // ── Finance ──────────────────────────────────────────────────

  Stream<List<Transaction>> watchCurrentMonthTransactions() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month);
    final end = DateTime(now.year, now.month + 1);
    return (select(transactions)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(start) &
              t.date.isSmallerThanValue(end))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();
  }

  Stream<List<Transaction>> watchAllTransactions() =>
      (select(transactions)
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();

  Stream<List<Debt>> watchActiveDebts() =>
      (select(debts)
            ..where((d) => d.status.equals('active'))
            ..orderBy([(d) => OrderingTerm.desc(d.createdAt)]))
          .watch();

  Stream<List<FinancialGoal>> watchFinancialGoals() =>
      (select(financialGoals)
            ..where((g) => g.status.equals('active'))
            ..orderBy([(g) => OrderingTerm.desc(g.createdAt)]))
          .watch();

  // ── Installment Loans ─────────────────────────────────────────

  Stream<List<InstallmentLoan>> watchActiveLoans() =>
      (select(installmentLoans)
            ..where((l) => l.status.equals('active'))
            ..orderBy([(l) => OrderingTerm.desc(l.createdAt)]))
          .watch();

  Stream<InstallmentLoan?> watchLoanById(String id) =>
      (select(installmentLoans)..where((l) => l.id.equals(id)))
          .watchSingleOrNull();

  Future<InstallmentLoan?> getLoanById(String id) =>
      (select(installmentLoans)..where((l) => l.id.equals(id)))
          .getSingleOrNull();

  Stream<List<LoanInstallment>> watchLoanInstallments(String loanId) =>
      (select(loanInstallments)
            ..where((i) => i.loanId.equals(loanId))
            ..orderBy([(i) => OrderingTerm.desc(i.installmentNumber)]))
          .watch();

  Future<List<LoanInstallment>> getLoanInstallments(String loanId) =>
      (select(loanInstallments)
            ..where((i) => i.loanId.equals(loanId))
            ..orderBy([(i) => OrderingTerm.asc(i.installmentNumber)]))
          .get();

  Stream<List<LoanInstallment>> watchAllPendingInstallments() =>
      (select(loanInstallments)
            ..where((i) =>
                i.status.equals('pending') | i.status.equals('overdue')))
          .watch();

  Future<List<LoanInstallment>> getPendingInstallments() =>
      (select(loanInstallments)
            ..where((i) => i.status.equals('pending')))
          .get();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'life_manager.sqlite'));
    return NativeDatabase(file);
  });
}
