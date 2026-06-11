import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';

const _uuid = Uuid();

// ── Providers ─────────────────────────────────────────────────

final allHealthLogsProvider = StreamProvider<List<HealthLog>>((ref) {
  return ref.watch(databaseProvider).watchAllHealthLogs();
});

final latestHealthLogProvider = FutureProvider<HealthLog?>((ref) {
  ref.watch(allHealthLogsProvider);
  return ref.read(databaseProvider).getLatestHealthLog();
});

final firstHealthLogProvider = FutureProvider<HealthLog?>((ref) {
  ref.watch(allHealthLogsProvider);
  return ref.read(databaseProvider).getFirstHealthLog();
});

final healthTargetProvider = FutureProvider<HealthTarget?>((ref) {
  return ref.watch(databaseProvider).getHealthTarget();
});

final healthChartLogsProvider =
    FutureProvider.family<List<HealthLog>, int>((ref, days) {
  ref.watch(allHealthLogsProvider);
  return ref.read(databaseProvider).getHealthLogsForChart(days);
});

// ── Notifier ──────────────────────────────────────────────────

class HealthNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> addLog({
    required DateTime date,
    double? weight,
    double? waistCm,
    double? bodyFatPct,
    int? energyLevel,
    int? sleepQuality,
    String? notes,
  }) async {
    final db = ref.read(databaseProvider);
    await db.insertHealthLog(HealthLogsCompanion.insert(
      id: _uuid.v4(),
      date: date,
      weight: Value(weight),
      waistCm: Value(waistCm),
      bodyFatPct: Value(bodyFatPct),
      energyLevel: Value(energyLevel),
      sleepQuality: Value(sleepQuality),
      notes: Value(notes),
    ));
    ref.invalidate(latestHealthLogProvider);
    ref.invalidate(firstHealthLogProvider);
    ref.invalidate(healthChartLogsProvider);
  }

  Future<void> updateLog({
    required String id,
    required DateTime date,
    double? weight,
    double? waistCm,
    double? bodyFatPct,
    int? energyLevel,
    int? sleepQuality,
    String? notes,
  }) async {
    final db = ref.read(databaseProvider);
    await db.updateHealthLog(HealthLogsCompanion(
      id: Value(id),
      date: Value(date),
      weight: Value(weight),
      waistCm: Value(waistCm),
      bodyFatPct: Value(bodyFatPct),
      energyLevel: Value(energyLevel),
      sleepQuality: Value(sleepQuality),
      notes: Value(notes),
      updatedAt: Value(DateTime.now()),
    ));
    ref.invalidate(latestHealthLogProvider);
    ref.invalidate(firstHealthLogProvider);
    ref.invalidate(healthChartLogsProvider);
  }

  Future<void> deleteLog(String id) async {
    await ref.read(databaseProvider).deleteHealthLog(id);
    ref.invalidate(latestHealthLogProvider);
    ref.invalidate(firstHealthLogProvider);
    ref.invalidate(healthChartLogsProvider);
  }

  Future<void> saveTarget({
    double? targetWeight,
    double? targetWaistCm,
    double? targetBodyFatPct,
    DateTime? targetDate,
  }) async {
    final db = ref.read(databaseProvider);
    await db.upsertHealthTarget(HealthTargetsCompanion(
      id: Value(_uuid.v4()),
      targetWeight: Value(targetWeight),
      targetWaistCm: Value(targetWaistCm),
      targetBodyFatPct: Value(targetBodyFatPct),
      targetDate: Value(targetDate),
      updatedAt: Value(DateTime.now()),
    ));
    ref.invalidate(healthTargetProvider);
  }
}

final healthNotifierProvider =
    AsyncNotifierProvider<HealthNotifier, void>(HealthNotifier.new);
