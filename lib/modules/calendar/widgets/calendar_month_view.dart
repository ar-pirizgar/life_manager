import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/calendar_providers.dart';
import '../utils/calendar_date_utils.dart';

class CalendarMonthView extends ConsumerWidget {
  const CalendarMonthView({
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
    final days =
        CalendarDateUtils.daysInMonthGrid(anchorDate, isJalali: isJalali);
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

    final weekDayHeaders = isJalali
        ? const ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج']
        : const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Column(
      children: [
        Row(
          children: weekDayHeaders
              .map((label) => Expanded(
                    child: Center(
                      child: Text(
                        label,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 4),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: days.map((day) {
            final isToday = CalendarDateUtils.isSameDay(day, today);
            final isSelected = CalendarDateUtils.isSameDay(day, selectedDate);
            final isCurrentMonth = CalendarDateUtils.isSameMonth(
                day, anchorDate,
                isJalali: isJalali);
            final count = countsByDay[day.millisecondsSinceEpoch] ?? 0;
            return _MonthDayCell(
              day: day,
              isJalali: isJalali,
              isToday: isToday,
              isSelected: isSelected,
              isCurrentMonth: isCurrentMonth,
              dotCount: CalendarDateUtils.dotCountFor(count),
              onTap: () => onDaySelected(day),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _MonthDayCell extends StatelessWidget {
  const _MonthDayCell({
    required this.day,
    required this.isJalali,
    required this.isToday,
    required this.isSelected,
    required this.isCurrentMonth,
    required this.dotCount,
    required this.onTap,
  });

  final DateTime day;
  final bool isJalali;
  final bool isToday;
  final bool isSelected;
  final bool isCurrentMonth;
  final int dotCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final dayNumber =
        isJalali ? JalaliHelper.full(day).split(' ').first : '${day.day}';

    final textColor = isSelected
        ? Colors.white
        : isToday
            ? colors.primary
            : isCurrentMonth
                ? colors.onSurface
                : colors.onSurfaceVariant.withValues(alpha: 0.4);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primary
              : isToday
                  ? colors.primary.withValues(alpha: 0.15)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayNumber,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    color: textColor,
                  ),
            ),
            const SizedBox(height: 2),
            SizedBox(
              height: 5,
              child: dotCount == 0
                  ? null
                  : Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? Colors.white : _dotColor(dotCount),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Color _dotColor(int dotCount) => switch (dotCount) {
        1 => AppColors.success,
        2 => AppColors.priorityMedium,
        _ => AppColors.priorityHigh,
      };
}
