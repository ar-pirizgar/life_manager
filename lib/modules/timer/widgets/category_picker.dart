import 'package:flutter/material.dart';

import '../providers/timer_providers.dart';

class CategoryPicker extends StatelessWidget {
  const CategoryPicker({
    super.key,
    required this.selected,
    required this.onSelected,
    this.enabled = true,
  });

  final TimerCategory selected;
  final ValueChanged<TimerCategory> onSelected;
  final bool enabled;

  static const _icons = <TimerCategory, IconData>{
    TimerCategory.deepWork: Icons.psychology_outlined,
    TimerCategory.shallowWork: Icons.work_outline,
    TimerCategory.learning: Icons.menu_book_outlined,
    TimerCategory.exercise: Icons.fitness_center_outlined,
    TimerCategory.personal: Icons.person_outline,
    TimerCategory.family: Icons.people_outline,
    TimerCategory.recovery: Icons.bedtime_outlined,
    TimerCategory.misc: Icons.more_horiz,
  };

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: TimerCategory.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final cat = TimerCategory.values[i];
          final isSelected = cat == selected;
          return FilterChip(
            avatar: Icon(
              _icons[cat] ?? Icons.circle,
              size: 16,
              color: isSelected
                  ? colors.onPrimary
                  : enabled
                      ? colors.onSurfaceVariant
                      : colors.onSurface.withValues(alpha: 0.38),
            ),
            label: Text(cat.label),
            selected: isSelected,
            onSelected: enabled ? (_) => onSelected(cat) : null,
          );
        },
      ),
    );
  }
}
