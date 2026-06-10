import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../../finance/providers/finance_providers.dart';
import '../../goals/providers/goal_providers.dart';
import '../../habits/providers/habit_providers.dart';
import '../../tasks/providers/task_providers.dart';
import '../../timer/providers/timer_providers.dart';
import '../providers/dashboard_providers.dart';
import '../widgets/score_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.dashboard)),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(databaseProvider),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ScoresSection(),
              const SizedBox(height: 20),
              _ProductivitySection(),
              const SizedBox(height: 20),
              _TimeSection(),
              const SizedBox(height: 20),
              _FinanceSection(),
              const SizedBox(height: 20),
              _GoalsSection(),
              const SizedBox(height: 20),
              _KpisSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(
    this.title, {
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          if (actionLabel != null && onAction != null)
            TextButton(
              onPressed: onAction,
              child: Text(actionLabel!,
                  style: TextStyle(fontSize: 13, color: colors.primary)),
            ),
        ],
      ),
    );
  }
}

// ── Scores Section ────────────────────────────────────────────

class _ScoresSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final daily = ref.watch(dailyScoreProvider);
    final focus = ref.watch(focusScoreProvider);
    final balance = ref.watch(lifeBalanceScoreProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionHeader(AppStrings.scoresSection),
        Row(
          children: [
            Expanded(
                child: ScoreCard(
                    title: AppStrings.dailyScore, score: daily)),
            const SizedBox(width: 8),
            Expanded(
                child: ScoreCard(
                    title: AppStrings.focusScore, score: focus)),
            const SizedBox(width: 8),
            Expanded(
                child: ScoreCard(
                    title: AppStrings.lifeBalance, score: balance)),
          ],
        ),
      ],
    );
  }
}

// ── Productivity Section ──────────────────────────────────────

class _ProductivitySection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(todayTasksProvider).valueOrNull ?? [];
    final habits = ref.watch(activeHabitsProvider).valueOrNull ?? [];
    final todayDone = ref.watch(todayDoneSetProvider);

    final taskDone = tasks.where((t) => t.status == 'done').length;
    final habitDone = todayDone.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionHeader(AppStrings.productivitySection),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _StatTile(
                    icon: Icons.check_circle_outline,
                    label: AppStrings.tasksLabel,
                    value:
                        '${JalaliHelper.toFa(taskDone.toString())}/${JalaliHelper.toFa(tasks.length.toString())}',
                    progress: tasks.isEmpty
                        ? 0
                        : taskDone / tasks.length,
                  ),
                ),
                Container(width: 1, height: 56, color: Theme.of(context).colorScheme.outlineVariant),
                Expanded(
                  child: _StatTile(
                    icon: Icons.loop_outlined,
                    label: AppStrings.habitsLabel,
                    value:
                        '${JalaliHelper.toFa(habitDone.toString())}/${JalaliHelper.toFa(habits.length.toString())}',
                    progress: habits.isEmpty
                        ? 0
                        : habitDone / habits.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Time Section ──────────────────────────────────────────────

class _TimeSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(todayTimeLogsProvider).valueOrNull ?? [];

    final totalSecs = logs.fold(0, (s, l) => s + l.durationSeconds);
    final deepSecs = logs
        .where((l) => l.category == 'deep_work')
        .fold(0, (s, l) => s + l.durationSeconds);

    final categoryTotals = <String, int>{};
    for (final l in logs) {
      categoryTotals[l.category] =
          (categoryTotals[l.category] ?? 0) + l.durationSeconds;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionHeader(AppStrings.timeSection),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _StatTile(
                        icon: Icons.psychology_outlined,
                        label: AppStrings.deepWorkLabel,
                        value: _fmtDuration(deepSecs),
                      ),
                    ),
                    Container(width: 1, height: 56, color: Theme.of(context).colorScheme.outlineVariant),
                    Expanded(
                      child: _StatTile(
                        icon: Icons.timer_outlined,
                        label: AppStrings.totalTimeLabel,
                        value: _fmtDuration(totalSecs),
                      ),
                    ),
                  ],
                ),
                if (categoryTotals.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _CategoryBreakdown(totals: categoryTotals, totalSecs: totalSecs),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _fmtDuration(int seconds) {
    if (seconds == 0) return JalaliHelper.toFa('0');
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    if (h > 0) {
      return '${JalaliHelper.toFa(h.toString())}h ${JalaliHelper.toFa(m.toString())}m';
    }
    return '${JalaliHelper.toFa(m.toString())}m';
  }
}

class _CategoryBreakdown extends StatelessWidget {
  const _CategoryBreakdown({
    required this.totals,
    required this.totalSecs,
  });

  final Map<String, int> totals;
  final int totalSecs;

  static const _labels = {
    'deep_work': 'کار عمیق',
    'shallow_work': 'کار سطحی',
    'learning': 'یادگیری',
    'exercise': 'ورزش',
    'personal': 'شخصی',
    'family': 'خانواده',
    'recovery': 'بازیابی',
    'misc': 'متفرقه',
  };

  static const _colors = [
    Color(0xFF4F46E5),
    Color(0xFF06B6D4),
    Color(0xFF22C55E),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFF8B5CF6),
    Color(0xFFEC4899),
    Color(0xFF6B7280),
  ];

  @override
  Widget build(BuildContext context) {
    final entries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    const colorList = _colors;

    return Column(
      children: [
        for (int i = 0; i < entries.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: _CategoryBar(
              label: _labels[entries[i].key] ?? entries[i].key,
              secs: entries[i].value,
              total: totalSecs,
              color: colorList[i % colorList.length],
            ),
          ),
      ],
    );
  }
}

class _CategoryBar extends StatelessWidget {
  const _CategoryBar({
    required this.label,
    required this.secs,
    required this.total,
    required this.color,
  });

  final String label;
  final int secs;
  final int total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final frac = total == 0 ? 0.0 : secs / total;
    final h = secs ~/ 3600;
    final m = (secs % 3600) ~/ 60;
    final valStr = h > 0
        ? '${JalaliHelper.toFa(h.toString())}h ${JalaliHelper.toFa(m.toString())}m'
        : '${JalaliHelper.toFa(m.toString())}m';

    return Row(
      children: [
        SizedBox(
          width: 64,
          child: Text(label,
              style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurfaceVariant)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: frac,
              minHeight: 8,
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 52,
          child: Text(valStr,
              style: const TextStyle(fontSize: 11),
              textAlign: TextAlign.end),
        ),
      ],
    );
  }
}

// ── Finance Section ───────────────────────────────────────────

class _FinanceSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txs = ref.watch(currentMonthTransactionsProvider).valueOrNull ?? [];
    double income = 0;
    double expense = 0;
    for (final t in txs) {
      if (t.type == 'income') {
        income += t.amount;
      } else {
        expense += t.amount;
      }
    }
    final balance = income - expense;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionHeader(AppStrings.financeSection),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _FinanceTile(
                    label: AppStrings.incomeLabel,
                    amount: income,
                    color: const Color(0xFF22C55E),
                  ),
                ),
                Container(width: 1, height: 56, color: Theme.of(context).colorScheme.outlineVariant),
                Expanded(
                  child: _FinanceTile(
                    label: AppStrings.expenseLabel,
                    amount: expense,
                    color: const Color(0xFFEF4444),
                  ),
                ),
                Container(width: 1, height: 56, color: Theme.of(context).colorScheme.outlineVariant),
                Expanded(
                  child: _FinanceTile(
                    label: AppStrings.balanceLabel,
                    amount: balance,
                    color: balance >= 0
                        ? const Color(0xFF22C55E)
                        : const Color(0xFFEF4444),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FinanceTile extends StatelessWidget {
  const _FinanceTile({
    required this.label,
    required this.amount,
    required this.color,
  });

  final String label;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          fmtAmount(amount),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// ── Goals Section ─────────────────────────────────────────────

class _GoalsSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final longGoals = ref.watch(allLongGoalsProvider).valueOrNull ?? [];
    final shortGoals = ref.watch(allShortGoalsProvider).valueOrNull ?? [];

    final activeLong = longGoals.where((g) => g.status == 'active').length;
    final completedLong =
        longGoals.where((g) => g.status == 'completed').length;
    final activeShort = shortGoals.where((g) => g.status == 'active').length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionHeader(AppStrings.goalsSection),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _StatTile(
                    icon: Icons.flag_outlined,
                    label: AppStrings.longGoalsLabel,
                    value:
                        '${JalaliHelper.toFa(activeLong.toString())} فعال / ${JalaliHelper.toFa(completedLong.toString())} تکمیل',
                  ),
                ),
                Container(width: 1, height: 56, color: Theme.of(context).colorScheme.outlineVariant),
                Expanded(
                  child: _StatTile(
                    icon: Icons.subdirectory_arrow_right_outlined,
                    label: AppStrings.shortGoalsLabel,
                    value: JalaliHelper.toFa('$activeShort فعال'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── KPIs Section ──────────────────────────────────────────────

class _KpisSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kpis = ref.watch(activeKpisProvider).valueOrNull ?? [];
    final preview = kpis.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionHeader(
          AppStrings.kpisSection,
          actionLabel: AppStrings.seeAll,
          onAction: () => context.go('/more/dashboard/kpis'),
        ),
        if (preview.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(Icons.bar_chart_outlined,
                      size: 40,
                      color: Theme.of(context).colorScheme.outline),
                  const SizedBox(height: 12),
                  const Text(AppStrings.noKpis,
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.noKpisHint,
                    style: TextStyle(
                        fontSize: 12,
                        color:
                            Theme.of(context).colorScheme.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => context.go('/more/dashboard/kpis'),
                    icon: const Icon(Icons.add),
                    label: const Text(AppStrings.addKpi),
                  ),
                ],
              ),
            ),
          )
        else
          for (final kpi in preview) _KpiPreviewTile(kpi: kpi),
      ],
    );
  }
}

class _KpiPreviewTile extends ConsumerWidget {
  const _KpiPreviewTile({required this.kpi});
  final Kpi kpi;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestLog =
        ref.watch(latestKpiLogProvider(kpi.id)).valueOrNull;
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Text(kpi.emoji, style: const TextStyle(fontSize: 24)),
        title: Text(kpi.title,
            style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: latestLog != null
            ? Text(
                '${JalaliHelper.toFa(_fmtVal(latestLog.value))} ${kpi.unit}')
            : Text(AppStrings.noLogs,
                style: TextStyle(
                    color: colors.onSurfaceVariant, fontSize: 12)),
        trailing: Icon(Icons.chevron_left, color: colors.onSurfaceVariant),
        onTap: () => context.go('/more/dashboard/kpis'),
      ),
    );
  }

  String _fmtVal(double v) {
    if (v == v.truncateToDouble()) return v.toInt().toString();
    return v.toStringAsFixed(1);
  }
}

// ── Shared Stat Tile ──────────────────────────────────────────

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
    this.progress,
  });

  final IconData icon;
  final String label;
  final String value;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 22, color: colors.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
              fontSize: 11, color: colors.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
        if (progress != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 4,
                backgroundColor: colors.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(
                  progress! >= 0.7
                      ? const Color(0xFF22C55E)
                      : progress! >= 0.4
                          ? const Color(0xFFF59E0B)
                          : const Color(0xFFEF4444),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
