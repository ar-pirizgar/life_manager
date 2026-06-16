import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database_provider.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/review_providers.dart';
import '../widgets/review_stat_row.dart';

class WeeklyReviewScreen extends ConsumerStatefulWidget {
  const WeeklyReviewScreen({super.key});

  @override
  ConsumerState<WeeklyReviewScreen> createState() =>
      _WeeklyReviewScreenState();
}

class _WeeklyReviewScreenState extends ConsumerState<WeeklyReviewScreen> {
  late DateTime _weekStart;
  final _workedCtrl = TextEditingController();
  final _failedCtrl = TextEditingController();
  final _learnedCtrl = TextEditingController();
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _weekStart = weekStartOf(DateTime.now());
  }

  @override
  void dispose() {
    _workedCtrl.dispose();
    _failedCtrl.dispose();
    _learnedCtrl.dispose();
    super.dispose();
  }

  void _prevWeek() {
    setState(() {
      _weekStart = _weekStart.subtract(const Duration(days: 7));
      _loaded = false;
    });
  }

  void _nextWeek() {
    final next = _weekStart.add(const Duration(days: 7));
    if (next.isBefore(DateTime.now().add(const Duration(days: 1)))) {
      setState(() {
        _weekStart = next;
        _loaded = false;
      });
    }
  }

  Future<void> _loadExisting() async {
    if (_loaded) return;
    _loaded = true;
    final db = ref.read(databaseProvider);
    final existing = await db.getWeeklyReviewForWeek(_weekStart);
    if (existing != null && mounted) {
      _workedCtrl.text = existing.answeredWorked ?? '';
      _failedCtrl.text = existing.answeredFailed ?? '';
      _learnedCtrl.text = existing.answeredLearned ?? '';
    } else {
      _workedCtrl.clear();
      _failedCtrl.clear();
      _learnedCtrl.clear();
    }
  }

  Future<void> _save(WeekStats stats) async {
    await ref.read(reviewNotifierProvider.notifier).saveWeeklyReview(
          weekStart: _weekStart,
          stats: stats,
          answeredWorked:
              _workedCtrl.text.trim().isEmpty ? null : _workedCtrl.text.trim(),
          answeredFailed:
              _failedCtrl.text.trim().isEmpty ? null : _failedCtrl.text.trim(),
          answeredLearned: _learnedCtrl.text.trim().isEmpty
              ? null
              : _learnedCtrl.text.trim(),
        );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.reviewSaved)),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final weekEnd = _weekStart.add(const Duration(days: 6));
    final statsAsync = ref.watch(weekStatsProvider(_weekStart));

    // Load saved answers whenever week changes
    statsAsync.whenData((_) => _loadExisting());

    final dateRange =
        '${JalaliHelper.short(_weekStart)} ${AppStrings.of} ${JalaliHelper.short(weekEnd)}';
    final isCurrentWeek =
        _weekStart.isAtSameMomentAs(weekStartOf(DateTime.now()));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppStrings.weeklyReviewTitle,
                style: TextStyle(fontSize: 16)),
            Text(dateRange,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _prevWeek,
            tooltip: 'هفته قبل',
          ),
          IconButton(
            icon: Icon(Icons.chevron_right,
                color: isCurrentWeek ? Colors.grey : null),
            onPressed: isCurrentWeek ? null : _nextWeek,
            tooltip: 'هفته بعد',
          ),
        ],
      ),
      body: statsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطا: $e')),
        data: (stats) => _buildBody(stats),
      ),
    );
  }

  String _fmtVal(double v) {
    if (v == v.truncateToDouble()) return v.toInt().toString();
    return v.toStringAsFixed(1);
  }

  Widget _buildBody(WeekStats stats) {
    final colors = Theme.of(context).colorScheme;
    final habitsPercent = (stats.habitSuccessRate * 100).round();
    final totalHours = stats.totalMinutes ~/ 60;
    final totalMins = stats.totalMinutes % 60;
    final deepHours = stats.deepWorkMinutes ~/ 60;
    final deepMins = stats.deepWorkMinutes % 60;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Stats card ────────────────────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('خلاصه هفته',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colors.primary)),
                  const SizedBox(height: 12),
                  ReviewStatRow(
                    icon: Icons.check_circle_outline,
                    label: AppStrings.reviewCompletedTasks,
                    value:
                        '${stats.completedTasks} از ${stats.totalTasks}',
                  ),
                  ReviewStatRow(
                    icon: Icons.loop_outlined,
                    label: AppStrings.reviewHabitRate,
                    value: '$habitsPercent٪',
                  ),
                  ReviewStatRow(
                    icon: Icons.timer_outlined,
                    label: AppStrings.reviewTotalTime,
                    value: '$totalHours ساعت $totalMins دقیقه',
                  ),
                  ReviewStatRow(
                    icon: Icons.psychology_outlined,
                    label: AppStrings.reviewDeepWork,
                    value: '$deepHours ساعت $deepMins دقیقه',
                  ),
                  ReviewStatRow(
                    icon: Icons.account_balance_wallet_outlined,
                    label: AppStrings.reviewIncome,
                    value: '+${stats.income.toStringAsFixed(0)}',
                  ),
                  ReviewStatRow(
                    icon: Icons.shopping_cart_outlined,
                    label: AppStrings.reviewExpense,
                    value: '-${stats.expense.toStringAsFixed(0)}',
                    isLast: stats.weekHealthLog == null,
                  ),
                  if (stats.weekHealthLog != null) ...[
                    ReviewStatRow(
                      icon: Icons.monitor_weight_outlined,
                      label: AppStrings.reviewWeight,
                      value: stats.weekHealthLog!.weight != null
                          ? '${_fmtVal(stats.weekHealthLog!.weight!)} ${AppStrings.weightUnit}'
                          : '—',
                    ),
                    ReviewStatRow(
                      icon: Icons.straighten,
                      label: AppStrings.reviewWaist,
                      value: stats.weekHealthLog!.waistCm != null
                          ? '${_fmtVal(stats.weekHealthLog!.waistCm!)} ${AppStrings.waistUnit}'
                          : '—',
                    ),
                    ReviewStatRow(
                      icon: Icons.monitor_heart_outlined,
                      label: AppStrings.reviewBodyFat,
                      value: stats.weekHealthLog!.bodyFatPct != null
                          ? '${_fmtVal(stats.weekHealthLog!.bodyFatPct!)}${AppStrings.bodyFatUnit}'
                          : '—',
                    ),
                    ReviewStatRow(
                      icon: Icons.bolt_outlined,
                      label: AppStrings.energyLabel,
                      value: stats.weekHealthLog!.energyLevel != null
                          ? '${stats.weekHealthLog!.energyLevel} ${AppStrings.outOf10}'
                          : '—',
                    ),
                    ReviewStatRow(
                      icon: Icons.bedtime_outlined,
                      label: AppStrings.sleepLabel,
                      value: stats.weekHealthLog!.sleepQuality != null
                          ? '${stats.weekHealthLog!.sleepQuality} ${AppStrings.outOf10}'
                          : '—',
                      isLast: true,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // ── Reflection section ────────────────────────────────
          Text('بازتاب هفتگی',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: colors.onSurface)),
          const SizedBox(height: 12),
          _ReflectionField(
            label: AppStrings.reflectWorkedLabel,
            controller: _workedCtrl,
            color: Colors.green.shade50,
            iconColor: Colors.green,
            icon: Icons.thumb_up_outlined,
          ),
          const SizedBox(height: 12),
          _ReflectionField(
            label: AppStrings.reflectFailedLabel,
            controller: _failedCtrl,
            color: Colors.red.shade50,
            iconColor: Colors.red,
            icon: Icons.thumb_down_outlined,
          ),
          const SizedBox(height: 12),
          _ReflectionField(
            label: AppStrings.reflectLearnedLabel,
            controller: _learnedCtrl,
            color: Colors.blue.shade50,
            iconColor: Colors.blue,
            icon: Icons.lightbulb_outlined,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => _save(stats),
            child: const Text(AppStrings.saveReview),
          ),
        ],
      ),
    );
  }
}

class _ReflectionField extends StatelessWidget {
  const _ReflectionField({
    required this.label,
    required this.controller,
    required this.color,
    required this.iconColor,
    required this.icon,
  });

  final String label;
  final TextEditingController controller;
  final Color color;
  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: iconColor)),
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            maxLines: 3,
            minLines: 2,
            decoration: const InputDecoration(
              hintText: AppStrings.reflectAnswerHint,
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
