import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/goal_providers.dart';
import '../widgets/add_long_goal_sheet.dart';
import '../widgets/add_short_goal_sheet.dart';
import '../widgets/long_goal_tile.dart';
import '../widgets/short_goal_tile.dart';

class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLongTab = _tabController.index == 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('اهداف'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'بلندمدت'),
            Tab(text: 'کوتاه‌مدت'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _LongGoalsList(),
          _ShortGoalsList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => isLongTab
            ? AddLongGoalSheet.show(context)
            : AddShortGoalSheet.show(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _LongGoalsList extends ConsumerWidget {
  const _LongGoalsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final asyncGoals = ref.watch(allLongGoalsProvider);

    return asyncGoals.when(
      data: (goals) {
        if (goals.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flag_outlined,
                    size: 48, color: theme.colorScheme.outlineVariant),
                const SizedBox(height: 12),
                Text(
                  'هنوز هدف بلندمدتی نداری',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          itemCount: goals.length,
          itemBuilder: (_, i) => LongGoalTile(goal: goals[i]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('خطا: $e')),
    );
  }
}

class _ShortGoalsList extends ConsumerWidget {
  const _ShortGoalsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final asyncGoals = ref.watch(allShortGoalsProvider);

    return asyncGoals.when(
      data: (goals) {
        if (goals.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.track_changes_outlined,
                    size: 48, color: theme.colorScheme.outlineVariant),
                const SizedBox(height: 12),
                Text(
                  'هنوز هدف کوتاه‌مدتی نداری',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          itemCount: goals.length,
          itemBuilder: (_, i) => ShortGoalTile(goal: goals[i]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('خطا: $e')),
    );
  }
}
