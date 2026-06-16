import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../../tasks/providers/task_providers.dart';

class CalendarDayTasks extends ConsumerWidget {
  const CalendarDayTasks({super.key, required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksForDayProvider(day));
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Text(
            JalaliHelper.relative(day),
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: colors.onSurfaceVariant),
          ),
        ),
        tasksAsync.when(
          data: (tasks) => tasks.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      AppStrings.calendarNoTasksForDay,
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                  ),
                )
              : Column(
                  children: tasks
                      .map((t) => _ReadOnlyTaskTile(task: t))
                      .toList(),
                ),
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _ReadOnlyTaskTile extends StatelessWidget {
  const _ReadOnlyTaskTile({required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDone = task.status == 'done';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.priorityFor(task.priority),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              task.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    decoration:
                        isDone ? TextDecoration.lineThrough : null,
                    color: isDone
                        ? colors.onSurfaceVariant
                        : colors.onSurface,
                  ),
            ),
          ),
          if (isDone)
            Icon(Icons.check_circle, size: 18, color: colors.primary),
        ],
      ),
    );
  }
}
