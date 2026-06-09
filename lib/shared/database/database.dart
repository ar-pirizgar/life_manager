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

// ============================================================
// تعریف دیتابیس
// ============================================================

@DriftDatabase(tables: [
  LongGoals, ShortGoals, Tasks,
  Transactions, Debts, FinancialGoals,
  Habits, HabitLogs,
  TimeLogs,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'life_manager.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
