import 'package:flutter/material.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database.dart';
import '../../../shared/utils/jalali_helper.dart';

class HealthLogTile extends StatelessWidget {
  const HealthLogTile({
    super.key,
    required this.log,
    required this.onTap,
    required this.onDelete,
  });

  final HealthLog log;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final chips = _buildChips(log);

    return Dismissible(
      key: ValueKey(log.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: colors.error,
        child: Icon(Icons.delete_outline, color: colors.onError),
      ),
      onDismissed: (_) => onDelete(),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          onTap: onTap,
          title: Text(
            JalaliHelper.full(log.date),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: chips.isEmpty
              ? null
              : Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: chips,
                  ),
                ),
          trailing: Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
        ),
      ),
    );
  }

  List<Widget> _buildChips(HealthLog log) {
    final chips = <Widget>[];
    if (log.weight != null) {
      chips.add(_MetricChip(
        label: '${log.weight!.toStringAsFixed(1)} ${AppStrings.weightUnit}',
        icon: Icons.monitor_weight_outlined,
      ));
    }
    if (log.waistCm != null) {
      chips.add(_MetricChip(
        label: '${log.waistCm!.toStringAsFixed(1)} ${AppStrings.waistUnit}',
        icon: Icons.straighten_outlined,
      ));
    }
    if (log.bodyFatPct != null) {
      chips.add(_MetricChip(
        label: '${log.bodyFatPct!.toStringAsFixed(1)}${AppStrings.bodyFatUnit}',
        icon: Icons.percent,
      ));
    }
    if (log.energyLevel != null) {
      chips.add(_MetricChip(
        label: 'انرژی ${log.energyLevel}/۱۰',
        icon: Icons.bolt_outlined,
      ));
    }
    if (log.sleepQuality != null) {
      chips.add(_MetricChip(
        label: 'خواب ${log.sleepQuality}/۱۰',
        icon: Icons.bedtime_outlined,
      ));
    }
    return chips;
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: colors.onPrimaryContainer),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: colors.onPrimaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
