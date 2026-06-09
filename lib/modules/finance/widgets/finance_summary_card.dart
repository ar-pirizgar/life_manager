import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/utils/jalali_helper.dart';
import '../providers/finance_providers.dart';

class FinanceSummaryCard extends ConsumerWidget {
  const FinanceSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(monthSummaryProvider);
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              JalaliHelper.monthYear(DateTime.now()),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatCell(
                    label: 'درآمد',
                    value: fmtAmount(summary.income),
                    color: const Color(0xFF22C55E),
                  ),
                ),
                Container(width: 1, height: 40, color: colors.outlineVariant),
                Expanded(
                  child: _StatCell(
                    label: 'هزینه',
                    value: fmtAmount(summary.expense),
                    color: const Color(0xFFEF4444),
                  ),
                ),
                Container(width: 1, height: 40, color: colors.outlineVariant),
                Expanded(
                  child: _StatCell(
                    label: 'مانده',
                    value: fmtAmount(summary.balance),
                    color: summary.balance >= 0
                        ? colors.primary
                        : const Color(0xFFEF4444),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
