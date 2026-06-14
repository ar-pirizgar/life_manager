import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/habit_providers.dart';
import 'add_habit_sheet.dart';

class HabitCard extends ConsumerWidget {
  const HabitCard({super.key, required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(habitLogsProvider(habit.id));
    final isDone = ref.watch(todayDoneSetProvider).contains(habit.id);

    final metrics = logsAsync.when(
      data: (logs) => computeMetrics(logs, habit.createdAt),
      loading: () => const HabitMetrics(),
      error: (_, __) => const HabitMetrics(),
    );

    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
        child: Row(
          children: [
            // Emoji circle
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone
                    ? colors.primaryContainer
                    : colors.surfaceContainerHighest,
              ),
              alignment: Alignment.center,
              child: Text(
                habit.emoji,
                style: const TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          habit.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            decoration: isDone
                                ? TextDecoration.lineThrough
                                : null,
                            color: isDone
                                ? colors.onSurfaceVariant
                                : colors.onSurface,
                          ),
                        ),
                      ),
                      _PopupMenu(habit: habit),
                    ],
                  ),
                  const SizedBox(height: 6),
                  _SevenDayDots(last7Days: metrics.last7Days),
                  const SizedBox(height: 6),
                  _MetricsRow(metrics: metrics),
                ],
              ),
            ),
            const SizedBox(width: 4),
            // Toggle button
            _ToggleButton(
              isDone: isDone,
              onTap: () => ref
                  .read(databaseProvider)
                  .toggleHabitLog(habit.id, DateTime.now()),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── 7-Day Dots ───────────────────────────────────────────────

class _SevenDayDots extends StatelessWidget {
  const _SevenDayDots({required this.last7Days});

  final List<bool> last7Days;

  static String _dayLabel(int daysAgo) {
    final d = DateTime.now().subtract(Duration(days: daysAgo));
    const labels = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];
    final j = _jalaliWeekDay(d);
    return labels[j];
  }

  static int _jalaliWeekDay(DateTime d) {
    // weekday: 1=Monday…7=Sunday. Jalali: Shanbe=index0
    const map = {1: 2, 2: 3, 3: 4, 4: 5, 5: 6, 6: 0, 7: 1};
    return map[d.weekday] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    if (last7Days.isEmpty) return const SizedBox.shrink();

    return Row(
      children: List.generate(7, (i) {
        final daysAgo = 6 - i;
        final done = i < last7Days.length && last7Days[i];
        return Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: done
                      ? colors.primary
                      : colors.surfaceContainerHighest,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _dayLabel(daysAgo),
                style: TextStyle(
                  fontSize: 9,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// ─── Metrics Row ──────────────────────────────────────────────

class _MetricsRow extends StatelessWidget {
  const _MetricsRow({required this.metrics});

  final HabitMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final pct = (metrics.successRate * 100).round();

    return Row(
      children: [
        Icon(Icons.local_fire_department,
            size: 14, color: metrics.currentStreak > 0
                ? const Color(0xFFF59E0B)
                : colors.onSurfaceVariant),
        const SizedBox(width: 2),
        Text(
          JalaliHelper.toFa(metrics.currentStreak),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: metrics.currentStreak > 0
                ? const Color(0xFFF59E0B)
                : colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 10),
        Icon(Icons.bar_chart, size: 14, color: colors.onSurfaceVariant),
        const SizedBox(width: 2),
        Text(
          '${JalaliHelper.toFa(pct)}٪',
          style: TextStyle(
            fontSize: 12,
            color: colors.onSurfaceVariant,
          ),
        ),
        if (metrics.bestStreak > 1) ...[
          const SizedBox(width: 10),
          Icon(Icons.emoji_events_outlined,
              size: 14, color: colors.onSurfaceVariant),
          const SizedBox(width: 2),
          Text(
            JalaliHelper.toFa(metrics.bestStreak),
            style: TextStyle(
              fontSize: 12,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

// ─── Toggle Button ────────────────────────────────────────────

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({required this.isDone, required this.onTap});

  final bool isDone;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDone ? colors.primary : Colors.transparent,
          border: isDone
              ? null
              : Border.all(color: colors.outlineVariant, width: 2),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.check,
          size: 20,
          color: isDone ? colors.onPrimary : colors.outlineVariant,
        ),
      ),
    );
  }
}

// ─── Popup Menu ───────────────────────────────────────────────

class _PopupMenu extends ConsumerWidget {
  const _PopupMenu({required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      iconSize: 18,
      padding: EdgeInsets.zero,
      onSelected: (value) async {
        if (value == 'edit') {
          await showAddHabitSheet(context, habit: habit);
        } else if (value == 'archive') {
          final ok = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text(AppStrings.archiveHabitTitle),
              content: Text('«${habit.title}» ${AppStrings.archiveHabitBody}'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text(AppStrings.cancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text(AppStrings.archive),
                ),
              ],
            ),
          );
          if (ok == true) {
            await ref.read(databaseProvider).archiveHabit(habit.id);
          }
        }
      },
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 18),
              SizedBox(width: 8),
              Text(AppStrings.edit),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'archive',
          child: Row(
            children: [
              Icon(Icons.archive_outlined, size: 18),
              SizedBox(width: 8),
              Text(AppStrings.archive),
            ],
          ),
        ),
      ],
    );
  }
}
