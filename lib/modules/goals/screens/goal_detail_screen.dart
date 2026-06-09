import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../../shared/database/database.dart';
import '../providers/goal_providers.dart';
import '../widgets/add_short_goal_sheet.dart';
import '../widgets/short_goal_tile.dart';

class GoalDetailScreen extends ConsumerWidget {
  const GoalDetailScreen({super.key, required this.goalId});

  final String goalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncGoal = ref.watch(longGoalProvider(goalId));

    return asyncGoal.when(
      data: (goal) {
        if (goal == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('هدف پیدا نشد')),
          );
        }
        return _GoalBody(goal: goal);
      },
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('خطا: $e')),
      ),
    );
  }
}

class _GoalBody extends ConsumerWidget {
  const _GoalBody({required this.goal});

  final LongGoal goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final asyncShorts = ref.watch(shortGoalsForLongProvider(goal.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(goal.title),
        actions: [
          PopupMenuButton<String>(
            onSelected: (status) => ref
                .read(goalRepositoryProvider)
                .setLongGoalStatus(goal.id, status),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'active', child: Text('فعال')),
              PopupMenuItem(value: 'paused', child: Text('متوقف')),
              PopupMenuItem(
                  value: 'completed', child: Text('تکمیل‌شده')),
            ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer
                      .withValues(alpha:0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (goal.description != null) ...[
                      Text(goal.description!,
                          style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 10),
                    ],
                    Wrap(
                      spacing: 8,
                      children: [
                        _InfoChip(
                          icon: Icons.flag_outlined,
                          label: switch (goal.status) {
                            'completed' => 'تکمیل‌شده',
                            'paused' => 'متوقف',
                            _ => 'فعال',
                          },
                          color: switch (goal.status) {
                            'completed' => theme.colorScheme.primary,
                            'paused' => Colors.orange,
                            _ => theme.colorScheme.tertiary,
                          },
                        ),
                        if (goal.deadline != null)
                          _InfoChip(
                            icon: Icons.calendar_today_outlined,
                            label: _jalali(goal.deadline!),
                            color: theme.colorScheme.outline,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Text(
                'اهداف کوتاه‌مدت',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          asyncShorts.when(
            data: (shorts) {
              if (shorts.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Center(
                      child: Text(
                        'هنوز هدف کوتاه‌مدتی برای این هدف نساختی',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                sliver: SliverList.builder(
                  itemCount: shorts.length,
                  itemBuilder: (_, i) =>
                      ShortGoalTile(goal: shorts[i], showParent: false),
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
            error: (e, _) => SliverToBoxAdapter(
              child: Center(child: Text('خطا: $e')),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            AddShortGoalSheet.show(context, longGoalId: goal.id),
        child: const Icon(Icons.add),
      ),
    );
  }

  String _jalali(DateTime dt) {
    final j = Jalali.fromDateTime(dt);
    const months = [
      'فروردین', 'اردیبهشت', 'خرداد', 'تیر', 'مرداد', 'شهریور',
      'مهر', 'آبان', 'آذر', 'دی', 'بهمن', 'اسفند'
    ];
    return '${j.day} ${months[j.month - 1]}';
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip(
      {required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
