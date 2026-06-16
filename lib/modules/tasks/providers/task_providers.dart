import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';

const _uuid = Uuid();

/// ریپازیتوری تسک‌ها — تمام عملیات دیتابیسی تسک اینجاست.
class TaskRepository {
  TaskRepository(this._db);
  final AppDatabase _db;

  /// افزودن تسک جدید
  Future<void> addTask({
    required String title,
    required DateTime dueDate,
    String? description,
    String? shortGoalId,
    String? category,
    String? notes,
    String priority = 'medium',
  }) async {
    await _db.into(_db.tasks).insert(
          TasksCompanion.insert(
            id: _uuid.v4(),
            title: title,
            description: Value(description),
            dueDate: dueDate,
            shortGoalId: Value(shortGoalId),
            category: Value(category),
            notes: Value(notes),
            priority: Value(priority),
          ),
        );
  }

  /// به‌روزرسانی تسک
  Future<void> updateTask(Task task) async {
    await _db.update(_db.tasks).replace(task);
  }

  /// تغییر وضعیت انجام/عدم انجام
  Future<void> toggleDone(Task task) async {
    final isDone = task.status == 'done';
    await (_db.update(_db.tasks)..where((t) => t.id.equals(task.id))).write(
      TasksCompanion(
        status: Value(isDone ? 'pending' : 'done'),
        completedAt: Value(isDone ? null : DateTime.now()),
      ),
    );
  }

  /// حذف تسک
  Future<void> deleteTask(String id) async {
    await (_db.delete(_db.tasks)..where((t) => t.id.equals(id))).go();
  }

  /// تسک‌های یک روز خاص
  Stream<List<Task>> watchTasksForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return (_db.select(_db.tasks)
          ..where((t) =>
              t.dueDate.isBiggerOrEqualValue(start) &
              t.dueDate.isSmallerThanValue(end))
          ..orderBy([(t) => OrderingTerm(expression: t.status)]))
        .watch();
  }

  /// تسک‌های Inbox — تسک‌هایی که دسته‌بندی و هدف ندارند و هنوز انجام نشده‌اند
  Stream<List<Task>> watchInbox() {
    return (_db.select(_db.tasks)
          ..where((t) =>
              t.category.isNull() &
              t.shortGoalId.isNull() &
              t.status.equals('pending'))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  /// همه تسک‌ها
  Stream<List<Task>> watchAll() {
    return (_db.select(_db.tasks)
          ..orderBy([(t) => OrderingTerm.desc(t.dueDate)]))
        .watch();
  }

  /// تسک‌های یک بازه تاریخی (برای تقویم)
  Stream<List<Task>> watchTasksForDateRange(DateTime start, DateTime end) {
    final rangeStart = DateTime(start.year, start.month, start.day);
    final rangeEnd =
        DateTime(end.year, end.month, end.day).add(const Duration(days: 1));
    return (_db.select(_db.tasks)
          ..where((t) =>
              t.dueDate.isBiggerOrEqualValue(rangeStart) &
              t.dueDate.isSmallerThanValue(rangeEnd) &
              t.status.equals('cancelled').not())
          ..orderBy([(t) => OrderingTerm.asc(t.dueDate)]))
        .watch();
  }
}

/// Provider ریپازیتوری
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return TaskRepository(db);
});

/// تسک‌های امروز
final todayTasksProvider = StreamProvider<List<Task>>((ref) {
  final repo = ref.watch(taskRepositoryProvider);
  return repo.watchTasksForDay(DateTime.now());
});

/// تسک‌های یک روز انتخاب‌شده (با پارامتر)
final tasksForDayProvider =
    StreamProvider.family<List<Task>, DateTime>((ref, day) {
  final repo = ref.watch(taskRepositoryProvider);
  return repo.watchTasksForDay(day);
});

/// تسک‌های Inbox
final inboxTasksProvider = StreamProvider<List<Task>>((ref) {
  final repo = ref.watch(taskRepositoryProvider);
  return repo.watchInbox();
});

/// همه تسک‌ها
final allTasksProvider = StreamProvider<List<Task>>((ref) {
  final repo = ref.watch(taskRepositoryProvider);
  return repo.watchAll();
});
