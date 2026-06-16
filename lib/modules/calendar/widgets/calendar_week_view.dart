import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/calendar_providers.dart';
import '../utils/calendar_date_utils.dart';

class CalendarWeekView extends ConsumerWidget {
  const CalendarWeekView({
    super.key,
    required this.anchorDate,
    required this.selectedDate,
    required this.isJalali,
    required this.onDaySelected,
  });

  final DateTime anchorDate;
  final DateTime selectedDate;
  final bool isJalali;
  final ValueChanged<DateTime> onDaySelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final days = CalendarDateUtils.daysInWeek(anchorDate, isJalali: isJalali);
    final range = DateRange(days.first, days.last);
    final tasksAsync = ref.watch(calendarTasksProvider(range));
    final today = DateTime.now();

    final countsByDay = <int, int>{};
    tasksAsync.whenData((tasks) {
      for (final t in tasks) {
        final key = DateTime(t.dueDate.year, t.dueDate.month, t.dueDate.day)
            .millisecondsSinceEpoch;
        countsByDay[key] = (countsByDay[key] ?? 0) + 1;
      }
    });

    return Row(
      children: days.map((day) {
        final isToday = CalendarDateUtils.isSameDay(day, today);
        final isSelected = CalendarDateUtils.isSameDay(day, selectedDate);
        final count = countsByDay[day.millisecondsSinceEpoch] ?? 0;
        return Expanded(
          child: _DayCell(
            day: day,
            isJalali: isJalali,
            isToday: isToday,
            isSelected: isSelected,
            dotCount: CalendarDateUtils.dotCountFor(count),
            onTap: () => onDaySelected(day),
          ),
        );
      }).toList(),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.isJalali,
    required this.isToday,
    required this.isSelected,
    required this.dotCount,
    required this.onTap,
  });

  final DateTime day;
  final bool isJalali;
  final bool isToday;
  final bool isSelected;
  final int dotCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final dayNumber =
        isJalali ? JalaliHelper.full(day).split(' ').first : '${day.day}';
    final weekDayLabel = isJalali
        ? JalaliHelper.weekDay(day).substring(0, 1)
        : _gregorianWeekDayShort(day.weekday);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primary
              : isToday
                  ? colors.primary.withValues(alpha: 0.15)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              weekDayLabel,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isSelected
                        ? Colors.white
                        : colors.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              dayNumber,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Colors.white
                        : isToday
                            ? colors.primary
                            : colors.onSurface,
                  ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 6,
              child: dotCount == 0
                  ? null
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        dotCount,
                        (_) => Container(
                          width: 5,
                          height: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _dotColor(dotCount, isSelected),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Color _dotColor(int dotCount, bool isSelected) {
    if (isSelected) return Colors.white;
    return switch (dotCount) {
      1 => AppColors.success,
      2 => AppColors.priorityMedium,
      _ => AppColors.priorityHigh,
    };
  }
}

String _gregorianWeekDayShort(int weekday) {
  const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return labels[weekday - 1];
}
