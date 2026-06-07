import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_providers.dart';
import '../widgets/quick_add_task_sheet.dart';
import '../widgets/task_tile.dart';

/// صفحه مدیریت تسک‌ها با نماهای مختلف.
class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسک‌ها'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'امروز'),
            Tab(text: 'Inbox'),
            Tab(text: 'همه'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _TaskListView(source: _TaskSource.today),
          _TaskListView(source: _TaskSource.inbox),
          _TaskListView(source: _TaskSource.all),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => QuickAddTaskSheet.show(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

enum _TaskSource { today, inbox, all }

class _TaskListView extends ConsumerWidget {
  const _TaskListView({required this.source});

  final _TaskSource source;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final asyncTasks = switch (source) {
      _TaskSource.today => ref.watch(todayTasksProvider),
      _TaskSource.inbox => ref.watch(inboxTasksProvider),
      _TaskSource.all => ref.watch(allTasksProvider),
    };

    final emptyMessage = switch (source) {
      _TaskSource.today => 'تسکی برای امروز نداری',
      _TaskSource.inbox => 'Inbox خالیه',
      _TaskSource.all => 'هنوز تسکی نساختی',
    };

    return asyncTasks.when(
      data: (tasks) {
        if (tasks.isEmpty) {
          return Center(
            child: Text(
              emptyMessage,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          itemCount: tasks.length,
          itemBuilder: (_, i) => TaskTile(task: tasks[i]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('خطا: $e')),
    );
  }
}
