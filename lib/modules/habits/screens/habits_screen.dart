import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/utils/jalali_helper.dart';
import '../providers/habit_providers.dart';
import '../widgets/add_habit_sheet.dart';
import '../widgets/habit_card.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(activeHabitsProvider);
    // Watch done count unconditionally — same pattern as _HabitsTab in home
    // screen. Avoids a diamond dependency where todayProgressProvider would
    // subscribe to activeHabitsProvider mid-build, triggering a fan-out error.
    final done = ref.watch(todayDoneSetProvider).length;

    return Scaffold(
      appBar: AppBar(title: const Text('عادت‌ها')),
      body: habitsAsync.when(
        data: (habits) => Column(
          children: [
            _TodayHeader(done: done, total: habits.length),
            Expanded(
              child: habits.isEmpty
                  ? _emptyState(context)
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: habits.length,
                      itemBuilder: (_, i) => HabitCard(habit: habits[i]),
                    ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            'خطا: $e',
            style: TextStyle(
                color: Theme.of(context).colorScheme.error),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddHabitSheet(context),
        tooltip: 'افزودن عادت',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ─── Today Header ─────────────────────────────────────────────

class _TodayHeader extends StatelessWidget {
  const _TodayHeader({required this.done, required this.total});

  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final progress = total == 0 ? 0.0 : done / total;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          JalaliHelper.full(DateTime.now()),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: colors.onSurfaceVariant,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          total == 0
                              ? 'هنوز عادتی تعریف نشده'
                              : '${JalaliHelper.toFa(done)} از ${JalaliHelper.toFa(total)} عادت انجام شده',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  if (total > 0) ...[
                    const SizedBox(width: 12),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 52,
                          height: 52,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 5,
                            backgroundColor: colors.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation(
                              progress == 1.0
                                  ? const Color(0xFF22C55E)
                                  : colors.primary,
                            ),
                          ),
                        ),
                        Text(
                          '${(progress * 100).round()}٪',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              if (total > 0) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: colors.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation(
                      progress == 1.0
                          ? const Color(0xFF22C55E)
                          : colors.primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Empty State ──────────────────────────────────────────────

Widget _emptyState(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.loop_outlined,
          size: 64,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: 16),
        Text(
          'هنوز عادتی تعریف نشده',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'با دکمه + اولین عادت خود را بسازید',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    ),
  );
}
