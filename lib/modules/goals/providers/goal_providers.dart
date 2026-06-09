import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';

const _uuid = Uuid();

class GoalRepository {
  GoalRepository(this._db);
  final AppDatabase _db;

  // ── Long Goals ──────────────────────────────────────────────

  Future<void> addLongGoal({
    required String title,
    String? description,
    DateTime? deadline,
  }) async {
    await _db.into(_db.longGoals).insert(
          LongGoalsCompanion.insert(
            id: _uuid.v4(),
            title: title,
            description: Value(description),
            deadline: Value(deadline),
          ),
        );
  }

  Future<void> updateLongGoal(LongGoal goal) async {
    await _db.update(_db.longGoals).replace(goal);
  }

  Future<void> deleteLongGoal(String id) async {
    await (_db.delete(_db.longGoals)..where((g) => g.id.equals(id))).go();
  }

  Future<void> setLongGoalStatus(String id, String status) async {
    await (_db.update(_db.longGoals)..where((g) => g.id.equals(id))).write(
      LongGoalsCompanion(status: Value(status)),
    );
  }

  Stream<List<LongGoal>> watchAllLongGoals() {
    return (_db.select(_db.longGoals)
          ..orderBy([(g) => OrderingTerm.desc(g.createdAt)]))
        .watch();
  }

  Stream<LongGoal?> watchLongGoal(String id) {
    return (_db.select(_db.longGoals)..where((g) => g.id.equals(id)))
        .watchSingleOrNull();
  }

  // ── Short Goals ─────────────────────────────────────────────

  Future<void> addShortGoal({
    required String title,
    String? longGoalId,
    DateTime? deadline,
  }) async {
    await _db.into(_db.shortGoals).insert(
          ShortGoalsCompanion.insert(
            id: _uuid.v4(),
            title: title,
            longGoalId: Value(longGoalId),
            deadline: Value(deadline),
          ),
        );
  }

  Future<void> updateShortGoal(ShortGoal goal) async {
    await _db.update(_db.shortGoals).replace(goal);
  }

  Future<void> deleteShortGoal(String id) async {
    await (_db.delete(_db.shortGoals)..where((g) => g.id.equals(id))).go();
  }

  Future<void> toggleShortGoalComplete(ShortGoal goal) async {
    final isComplete = goal.status == 'completed';
    await (_db.update(_db.shortGoals)..where((g) => g.id.equals(goal.id)))
        .write(
      ShortGoalsCompanion(status: Value(isComplete ? 'active' : 'completed')),
    );
  }

  Stream<List<ShortGoal>> watchAllShortGoals() {
    return (_db.select(_db.shortGoals)
          ..orderBy([(g) => OrderingTerm.desc(g.createdAt)]))
        .watch();
  }

  Stream<List<ShortGoal>> watchShortGoalsForLong(String longGoalId) {
    return (_db.select(_db.shortGoals)
          ..where((g) => g.longGoalId.equals(longGoalId))
          ..orderBy([(g) => OrderingTerm(expression: g.status)]))
        .watch();
  }
}

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return GoalRepository(db);
});

final allLongGoalsProvider = StreamProvider<List<LongGoal>>((ref) {
  return ref.watch(goalRepositoryProvider).watchAllLongGoals();
});

final allShortGoalsProvider = StreamProvider<List<ShortGoal>>((ref) {
  return ref.watch(goalRepositoryProvider).watchAllShortGoals();
});

final shortGoalsForLongProvider =
    StreamProvider.family<List<ShortGoal>, String>((ref, longGoalId) {
  return ref.watch(goalRepositoryProvider).watchShortGoalsForLong(longGoalId);
});

final longGoalProvider =
    StreamProvider.family<LongGoal?, String>((ref, id) {
  return ref.watch(goalRepositoryProvider).watchLongGoal(id);
});
