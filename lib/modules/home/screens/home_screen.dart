import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database.dart';
import '../../../shared/theme/app_theme.dart';
import '../../habits/providers/habit_providers.dart';
import '../../tasks/providers/task_providers.dart';
import '../../tasks/widgets/edit_task_sheet.dart';
import '../../tasks/widgets/quick_add_task_sheet.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTabBar(),
            const Divider(height: 1, thickness: 1, color: AppColors.border),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  _TasksTab(),
                  _HabitsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: const [
                Tab(text: AppStrings.homeTasksTab),
                Tab(text: AppStrings.homeHabitsTab),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.tune, color: AppColors.textMuted),
            onPressed: () {},
            tooltip: 'فیلتر',
          ),
        ],
      ),
    );
  }
}

// ─── Tasks Tab ────────────────────────────────────────────────

class _TasksTab extends ConsumerWidget {
  const _TasksTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayTasks = ref.watch(todayTasksProvider);
    return Column(
      children: [
        Expanded(
          child: todayTasks.when(
            data: (tasks) => tasks.isEmpty
                ? const _EmptyTasks()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    itemCount: tasks.length,
                    itemBuilder: (_, i) => _TaskCard(task: tasks[i]),
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Text(
                'خطا: $e',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ),
        ),
        const _AddTaskButton(),
      ],
    );
  }
}

class _TaskCard extends ConsumerWidget {
  const _TaskCard({required this.task});
  final Task task;

  String _formatDueDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'امروز';
    }
    final tomorrow = now.add(const Duration(days: 1));
    if (date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day) {
      return 'فردا';
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priorityColor = AppColors.priorityFor(task.priority);
    final isDone = task.status == 'done';

    return GestureDetector(
      onLongPress: () => showEditTaskSheet(context, task),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: priorityColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: priorityColor.withValues(alpha: 0.22)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // هاله‌ی ملایم گوشه‌ی بالا-راست (= بالا-شروع در RTL)
              Positioned(
                top: -28,
                right: -28,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        priorityColor.withValues(alpha: 0.13),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    // دایره‌ی چک‌باکس (سمت راست در RTL)
                    GestureDetector(
                      onTap: () =>
                          ref.read(taskRepositoryProvider).toggleDone(task),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDone ? priorityColor : Colors.transparent,
                          border: isDone
                              ? null
                              : Border.all(
                                  color: priorityColor.withValues(alpha: 0.6),
                                  width: 1.5),
                        ),
                        child: isDone
                            ? const Icon(Icons.check,
                                size: 14, color: Colors.white)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // عنوان + خط دوم
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  task.title,
                                  style: TextStyle(
                                    color: isDone
                                        ? AppColors.textMuted
                                        : AppColors.textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    decoration: isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (task.category != null) ...[
                                const SizedBox(width: 5),
                                const Icon(Icons.label_outline,
                                    size: 13, color: AppColors.textMuted),
                              ],
                            ],
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const Icon(Icons.access_time_outlined,
                                  size: 11, color: AppColors.textSecondary),
                              const SizedBox(width: 3),
                              Text(
                                _formatDueDate(task.dueDate),
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 11,
                                ),
                              ),
                              if (task.category != null) ...[
                                const SizedBox(width: 6),
                                Text(
                                  task.category!,
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // نشانگر اولویت (سمت چپ در RTL)
                    _PriorityBadge(priority: task.priority),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  const _PriorityBadge({required this.priority});
  final String priority;

  String get _label => switch (priority) {
        'critical' => AppStrings.priorityCriticalLabel,
        'high' => AppStrings.priorityHighLabel,
        'medium' => AppStrings.priorityMediumLabel,
        _ => AppStrings.priorityLowLabel,
      };

  int get _dotCount => switch (priority) {
        'critical' => 3,
        'high' => 2,
        _ => 1,
      };

  @override
  Widget build(BuildContext context) {
    final color = AppColors.priorityFor(priority);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 0.5),
          ),
          child: Text(
            _label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < _dotCount; i++) ...[
              if (i > 0) const SizedBox(width: 3),
              Container(
                width: 5,
                height: 5,
                decoration:
                    BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _EmptyTasks extends StatelessWidget {
  const _EmptyTasks();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline,
              size: 56, color: AppColors.textMuted),
          SizedBox(height: 16),
          Text(
            AppStrings.homeNoTasks,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class _AddTaskButton extends StatelessWidget {
  const _AddTaskButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: InkWell(
        onTap: () => QuickAddTaskSheet.show(context),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border:
                Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: AppColors.primary, size: 20),
              SizedBox(width: 6),
              Text(
                AppStrings.homeAddTask,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Habits Tab ───────────────────────────────────────────────

class _HabitsTab extends ConsumerWidget {
  const _HabitsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(activeHabitsProvider);
    final doneSet = ref.watch(todayDoneSetProvider);

    return habitsAsync.when(
      data: (habits) => habits.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.self_improvement,
                      size: 56, color: AppColors.textMuted),
                  SizedBox(height: 16),
                  Text(
                    AppStrings.homeNoHabits,
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 15),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              itemCount: habits.length,
              itemBuilder: (_, i) => _HabitCard(
                habit: habits[i],
                isDoneToday: doneSet.contains(habits[i].id),
              ),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Text(
          'خطا: $e',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _HabitCard extends ConsumerWidget {
  const _HabitCard({required this.habit, required this.isDoneToday});
  final Habit habit;
  final bool isDoneToday;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(habitLogsProvider(habit.id));
    final metrics = logsAsync.when(
      data: (logs) => computeMetrics(logs, habit.createdAt),
      loading: () => const HabitMetrics(),
      error: (_, __) => const HabitMetrics(),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0C140C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E3A1E)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            // آیکون‌باکس (سمت راست در RTL)
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(habit.emoji,
                    style: const TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(width: 10),
            // نام عادت + دایره‌های هفته (وسط)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < 7; i++) ...[
                        if (i > 0) const SizedBox(width: 4),
                        _DayDot(isDone: metrics.last7Days[i]),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // استریک (سمت چپ در RTL)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🔥', style: TextStyle(fontSize: 20)),
                Text(
                  '${metrics.currentStreak} ${AppStrings.streakDays}',
                  style: const TextStyle(
                    color: AppColors.successAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({required this.isDone});
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDone ? AppColors.success : Colors.transparent,
        border: isDone ? null : Border.all(color: AppColors.border),
      ),
      child: isDone
          ? const Icon(Icons.check, size: 12, color: Colors.white)
          : null,
    );
  }
}
