import 'package:flutter/material.dart';

import '../../../shared/database/database.dart';
import '../../../shared/utils/jalali_helper.dart';

class KpiTile extends StatelessWidget {
  const KpiTile({
    super.key,
    required this.kpi,
    required this.latestLog,
    required this.onLog,
    required this.onEdit,
    required this.onArchive,
  });

  final Kpi kpi;
  final KpiLog? latestLog;
  final VoidCallback onLog;
  final VoidCallback onEdit;
  final VoidCallback onArchive;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final hasTarget = kpi.targetValue != null;
    final progress = hasTarget && latestLog != null
        ? (latestLog!.value / kpi.targetValue!).clamp(0.0, 1.0)
        : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onLog,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(kpi.emoji, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kpi.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        if (latestLog != null)
                          Text(
                            '${JalaliHelper.toFa(_fmtValue(latestLog!.value))} ${kpi.unit}',
                            style: TextStyle(
                              color: colors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        else
                          Text(
                            'هنوز مقداری ثبت نشده',
                            style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, color: colors.onSurfaceVariant),
                    onSelected: (v) {
                      if (v == 'edit') onEdit();
                      if (v == 'archive') onArchive();
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'edit', child: Text('ویرایش')),
                      PopupMenuItem(value: 'archive', child: Text('بایگانی')),
                    ],
                  ),
                ],
              ),
              if (progress != null) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 6,
                          backgroundColor: colors.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _progressColor(progress),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${JalaliHelper.toFa((progress * 100).round().toString())}%',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'هدف: ${JalaliHelper.toFa(_fmtValue(kpi.targetValue!))} ${kpi.unit}',
                  style: TextStyle(fontSize: 11, color: colors.onSurfaceVariant),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _fmtValue(double v) {
    if (v == v.truncateToDouble()) return v.toInt().toString();
    return v.toStringAsFixed(1);
  }

  Color _progressColor(double p) {
    if (p >= 0.7) return const Color(0xFF22C55E);
    if (p >= 0.4) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }
}
