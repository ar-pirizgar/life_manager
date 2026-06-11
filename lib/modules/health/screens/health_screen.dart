import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/health_providers.dart';
import '../widgets/add_health_log_sheet.dart';
import '../widgets/health_log_tile.dart';
import '../widgets/health_target_sheet.dart';
import 'health_log_detail_screen.dart';

class HealthScreen extends ConsumerWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.healthTitle),
          bottom: const TabBar(
            tabs: [
              Tab(text: AppStrings.healthDashboardTab),
              Tab(text: AppStrings.healthHistoryTab),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _DashboardTab(),
            _HistoryTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showAddHealthLogSheet(context),
          tooltip: AppStrings.addHealthLog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

// ── Dashboard Tab ─────────────────────────────────────────────

class _DashboardTab extends ConsumerWidget {
  const _DashboardTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestAsync = ref.watch(latestHealthLogProvider);
    final firstAsync = ref.watch(firstHealthLogProvider);
    final targetAsync = ref.watch(healthTargetProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(latestHealthLogProvider);
        ref.invalidate(firstHealthLogProvider);
        ref.invalidate(healthTargetProvider);
        ref.invalidate(healthChartLogsProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        child: latestAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('خطا: $e')),
          data: (latest) {
            if (latest == null) {
              return _emptyDashboard(context);
            }
            final first = firstAsync.valueOrNull;
            final target = targetAsync.valueOrNull;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _CurrentStatusCard(log: latest),
                const SizedBox(height: 16),
                if (first != null && first.id != latest.id) ...[
                  _ProgressCard(first: first, latest: latest),
                  const SizedBox(height: 16),
                ],
                if (target != null) ...[
                  _TargetCard(target: target, latest: latest),
                  const SizedBox(height: 16),
                ],
                const _WeightChartCard(),
                const SizedBox(height: 16),
                _TargetButton(target: target),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _emptyDashboard(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        const SizedBox(height: 60),
        Icon(Icons.monitor_heart_outlined, size: 64, color: colors.primary),
        const SizedBox(height: 16),
        Text(
          AppStrings.noHealthLogs,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.noHealthLogsHint,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: colors.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        OutlinedButton.icon(
          onPressed: () =>
              showAddHealthLogSheet(context),
          icon: const Icon(Icons.add),
          label: const Text(AppStrings.addHealthLog),
        ),
      ],
    );
  }
}

class _CurrentStatusCard extends StatelessWidget {
  const _CurrentStatusCard({required this.log});

  final HealthLog log;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppStrings.currentStatus,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colors.primary,
                  ),
                ),
                const Spacer(),
                Text(
                  JalaliHelper.full(log.date),
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (log.weight != null || log.waistCm != null || log.bodyFatPct != null)
              Row(
                children: [
                  if (log.weight != null)
                    Expanded(
                      child: _StatCell(
                        icon: Icons.monitor_weight_outlined,
                        label: 'وزن',
                        value: log.weight!.toStringAsFixed(1),
                        unit: AppStrings.weightUnit,
                      ),
                    ),
                  if (log.waistCm != null)
                    Expanded(
                      child: _StatCell(
                        icon: Icons.straighten_outlined,
                        label: 'دور کمر',
                        value: log.waistCm!.toStringAsFixed(1),
                        unit: AppStrings.waistUnit,
                      ),
                    ),
                  if (log.bodyFatPct != null)
                    Expanded(
                      child: _StatCell(
                        icon: Icons.percent,
                        label: 'چربی',
                        value: log.bodyFatPct!.toStringAsFixed(1),
                        unit: AppStrings.bodyFatUnit,
                      ),
                    ),
                ],
              ),
            if (log.energyLevel != null || log.sleepQuality != null) ...[
              const SizedBox(height: 10),
              const Divider(height: 1),
              const SizedBox(height: 10),
              Row(
                children: [
                  if (log.energyLevel != null)
                    Expanded(
                      child: _StatCell(
                        icon: Icons.bolt_outlined,
                        label: 'انرژی',
                        value: '${log.energyLevel}',
                        unit: AppStrings.outOf10,
                      ),
                    ),
                  if (log.sleepQuality != null)
                    Expanded(
                      child: _StatCell(
                        icon: Icons.bedtime_outlined,
                        label: 'خواب',
                        value: '${log.sleepQuality}',
                        unit: AppStrings.outOf10,
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
  });

  final IconData icon;
  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        Icon(icon, size: 20, color: colors.primary),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: colors.onSurfaceVariant),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          unit,
          style: TextStyle(fontSize: 11, color: colors.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.first, required this.latest});

  final HealthLog first;
  final HealthLog latest;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final rows = <Widget>[];

    void addRow(String label, double? start, double? current, String unit) {
      if (start == null || current == null) return;
      final change = current - start;
      final isLower = change < 0;
      rows.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Text(label, style: const TextStyle(fontSize: 13))),
            Expanded(
              child: Text(
                '${start.toStringAsFixed(1)} $unit',
                style: TextStyle(
                    fontSize: 12, color: colors.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                '${current.toStringAsFixed(1)} $unit',
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                '${isLower ? '' : '+'}${change.toStringAsFixed(1)} $unit',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isLower ? const Color(0xFF22C55E) : colors.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ));
    }

    addRow('وزن', first.weight, latest.weight, AppStrings.weightUnit);
    addRow('دور کمر', first.waistCm, latest.waistCm, AppStrings.waistUnit);
    addRow('درصد چربی', first.bodyFatPct, latest.bodyFatPct,
        AppStrings.bodyFatUnit);

    if (rows.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.progressVsStart,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: colors.primary),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  child: Text(
                    AppStrings.startMetric,
                    style: TextStyle(
                        fontSize: 11, color: colors.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    AppStrings.currentMetric,
                    style: TextStyle(
                        fontSize: 11, color: colors.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    AppStrings.changeMetric,
                    style: TextStyle(
                        fontSize: 11, color: colors.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const Divider(height: 12),
            ...rows,
          ],
        ),
      ),
    );
  }
}

class _TargetCard extends StatelessWidget {
  const _TargetCard({required this.target, required this.latest});

  final HealthTarget target;
  final HealthLog latest;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final rows = <Widget>[];

    void addRow(String label, double? current, double? goal, String unit) {
      if (goal == null) return;
      final remaining = current != null ? goal - current : null;
      rows.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Text(label, style: const TextStyle(fontSize: 13))),
            Expanded(
              child: Text(
                current != null
                    ? '${current.toStringAsFixed(1)} $unit'
                    : '—',
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                '${goal.toStringAsFixed(1)} $unit',
                style: TextStyle(
                    fontSize: 12, color: colors.primary),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                remaining != null
                    ? '${remaining >= 0 ? '+' : ''}${remaining.toStringAsFixed(1)} $unit'
                    : '—',
                style: TextStyle(
                  fontSize: 12,
                  color: remaining != null && remaining <= 0
                      ? const Color(0xFF22C55E)
                      : colors.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ));
    }

    addRow('وزن', latest.weight, target.targetWeight, AppStrings.weightUnit);
    addRow('دور کمر', latest.waistCm, target.targetWaistCm, AppStrings.waistUnit);
    addRow('درصد چربی', latest.bodyFatPct, target.targetBodyFatPct,
        AppStrings.bodyFatUnit);

    if (rows.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppStrings.healthTargetsTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: colors.primary),
                ),
                if (target.targetDate != null) ...[
                  const Spacer(),
                  Text(
                    JalaliHelper.full(target.targetDate!),
                    style: TextStyle(
                        fontSize: 11, color: colors.onSurfaceVariant),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  child: Text('فعلی',
                      style: TextStyle(
                          fontSize: 11, color: colors.onSurfaceVariant),
                      textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text('هدف',
                      style: TextStyle(
                          fontSize: 11, color: colors.onSurfaceVariant),
                      textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text('مانده',
                      style: TextStyle(
                          fontSize: 11, color: colors.onSurfaceVariant),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
            const Divider(height: 12),
            ...rows,
          ],
        ),
      ),
    );
  }
}

class _WeightChartCard extends ConsumerWidget {
  const _WeightChartCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartAsync = ref.watch(healthChartLogsProvider(56));

    return chartAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (logs) {
        final withWeight = logs.where((l) => l.weight != null).toList();
        if (withWeight.length < 2) return const SizedBox.shrink();

        final colors = Theme.of(context).colorScheme;
        final firstDate = withWeight.first.date;
        final spots = withWeight.map((l) {
          final x = l.date.difference(firstDate).inDays.toDouble();
          return FlSpot(x, l.weight!);
        }).toList();

        final minY =
            withWeight.map((l) => l.weight!).reduce((a, b) => a < b ? a : b);
        final maxY =
            withWeight.map((l) => l.weight!).reduce((a, b) => a > b ? a : b);
        final padding = (maxY - minY) < 2 ? 2.0 : (maxY - minY) * 0.2;

        return Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.weightTrend,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: colors.primary),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 140,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: padding > 0 ? padding : 1,
                        getDrawingHorizontalLine: (_) => FlLine(
                          color: colors.outlineVariant,
                          strokeWidth: 0.5,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 44,
                            getTitlesWidget: (value, meta) => Text(
                              value.toStringAsFixed(1),
                              style: TextStyle(
                                  fontSize: 10,
                                  color: colors.onSurfaceVariant),
                            ),
                          ),
                        ),
                        bottomTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                      minY: minY - padding,
                      maxY: maxY + padding,
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          color: colors.primary,
                          barWidth: 2.5,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, bar, index) =>
                                FlDotCirclePainter(
                              radius: 3.5,
                              color: colors.primary,
                              strokeWidth: 0,
                              strokeColor: Colors.transparent,
                            ),
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            color: colors.primary.withValues(alpha: 0.08),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${withWeight.length} ثبت — ۸ هفته اخیر',
                  style: TextStyle(
                      fontSize: 11, color: colors.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TargetButton extends ConsumerWidget {
  const _TargetButton({required this.target});

  final HealthTarget? target;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton.icon(
      onPressed: () => showHealthTargetSheet(context, existing: target),
      icon: Icon(target == null ? Icons.flag_outlined : Icons.edit_outlined),
      label: Text(
          target == null ? AppStrings.setTargets : AppStrings.editTargets),
    );
  }
}

// ── History Tab ───────────────────────────────────────────────

class _HistoryTab extends ConsumerWidget {
  const _HistoryTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(allHealthLogsProvider);

    return logsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('خطا: $e')),
      data: (logs) {
        if (logs.isEmpty) {
          return _emptyState(context);
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 100),
          itemCount: logs.length,
          itemBuilder: (_, i) {
            final log = logs[i];
            return HealthLogTile(
              log: log,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProviderScope(
                    child: HealthLogDetailScreen(log: log),
                  ),
                ),
              ),
              onDelete: () => ref
                  .read(healthNotifierProvider.notifier)
                  .deleteLog(log.id),
            );
          },
        );
      },
    );
  }
}

Widget _emptyState(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.monitor_heart_outlined,
          size: 64,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: 16),
        Text(
          AppStrings.noHealthLogs,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.noHealthLogsHint,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
