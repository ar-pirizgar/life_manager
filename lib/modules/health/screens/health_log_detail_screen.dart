import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/health_providers.dart';
import '../widgets/edit_health_log_sheet.dart';

class HealthLogDetailScreen extends ConsumerWidget {
  const HealthLogDetailScreen({super.key, required this.log});

  final HealthLog log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppStrings.healthLogDetail,
                style: TextStyle(fontSize: 16)),
            Text(JalaliHelper.full(log.date),
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: AppStrings.edit,
            onPressed: () => showEditHealthLogSheet(context, log),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: AppStrings.delete,
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _MetricSection(
              title: 'معیارهای جسمی',
              rows: [
                if (log.weight != null)
                  _MetricRow(
                    icon: Icons.monitor_weight_outlined,
                    label: 'وزن',
                    value:
                        '${log.weight!.toStringAsFixed(1)} ${AppStrings.weightUnit}',
                  ),
                if (log.waistCm != null)
                  _MetricRow(
                    icon: Icons.straighten_outlined,
                    label: 'دور کمر',
                    value:
                        '${log.waistCm!.toStringAsFixed(1)} ${AppStrings.waistUnit}',
                  ),
                if (log.bodyFatPct != null)
                  _MetricRow(
                    icon: Icons.percent,
                    label: 'درصد چربی',
                    value:
                        '${log.bodyFatPct!.toStringAsFixed(1)}${AppStrings.bodyFatUnit}',
                  ),
              ],
            ),
            if (log.energyLevel != null || log.sleepQuality != null) ...[
              const SizedBox(height: 16),
              _MetricSection(
                title: 'معیارهای ذهنی',
                rows: [
                  if (log.energyLevel != null)
                    _MetricRow(
                      icon: Icons.bolt_outlined,
                      label: AppStrings.energyLabel,
                      value: '${log.energyLevel} ${AppStrings.outOf10}',
                    ),
                  if (log.sleepQuality != null)
                    _MetricRow(
                      icon: Icons.bedtime_outlined,
                      label: AppStrings.sleepLabel,
                      value: '${log.sleepQuality} ${AppStrings.outOf10}',
                    ),
                ],
              ),
            ],
            if (log.notes != null && log.notes!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.notes_outlined,
                              size: 16,
                              color:
                                  Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 6),
                          const Text(AppStrings.healthNotesLabel,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(log.notes!,
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Text(
              'ثبت شده: ${JalaliHelper.full(log.createdAt)}',
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف ثبت'),
        content: const Text('این ثبت حذف شود؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(AppStrings.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await ref.read(healthNotifierProvider.notifier).deleteLog(log.id);
      if (context.mounted) Navigator.of(context).pop();
    }
  }
}

class _MetricSection extends StatelessWidget {
  const _MetricSection({required this.title, required this.rows});

  final String title;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return const SizedBox.shrink();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            ...rows,
          ],
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: colors.primary),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 14)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
