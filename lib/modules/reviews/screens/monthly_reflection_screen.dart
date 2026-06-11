import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database_provider.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/review_providers.dart';

class MonthlyReflectionScreen extends ConsumerStatefulWidget {
  const MonthlyReflectionScreen({super.key});

  @override
  ConsumerState<MonthlyReflectionScreen> createState() =>
      _MonthlyReflectionScreenState();
}

class _MonthlyReflectionScreenState
    extends ConsumerState<MonthlyReflectionScreen> {
  late int _year;
  late int _month;
  final _continueCtrl = TextEditingController();
  final _stopCtrl = TextEditingController();
  final _startCtrl = TextEditingController();
  final _proudCtrl = TextEditingController();
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _year = now.year;
    _month = now.month;
  }

  @override
  void dispose() {
    _continueCtrl.dispose();
    _stopCtrl.dispose();
    _startCtrl.dispose();
    _proudCtrl.dispose();
    super.dispose();
  }

  void _prevMonth() {
    setState(() {
      if (_month == 1) {
        _month = 12;
        _year--;
      } else {
        _month--;
      }
      _loaded = false;
    });
  }

  void _nextMonth() {
    final now = DateTime.now();
    final isCurrentMonth = _year == now.year && _month == now.month;
    if (isCurrentMonth) return;
    setState(() {
      if (_month == 12) {
        _month = 1;
        _year++;
      } else {
        _month++;
      }
      _loaded = false;
    });
  }

  Future<void> _loadExisting() async {
    if (_loaded) return;
    _loaded = true;
    final db = ref.read(databaseProvider);
    final existing = await db.getMonthlyReflection(_year, _month);
    if (existing != null && mounted) {
      _continueCtrl.text = existing.answeredContinue ?? '';
      _stopCtrl.text = existing.answeredStop ?? '';
      _startCtrl.text = existing.answeredStart ?? '';
      _proudCtrl.text = existing.answeredProud ?? '';
    } else {
      _continueCtrl.clear();
      _stopCtrl.clear();
      _startCtrl.clear();
      _proudCtrl.clear();
    }
  }

  Future<void> _save() async {
    await ref.read(reviewNotifierProvider.notifier).saveMonthlyReflection(
          year: _year,
          month: _month,
          answeredContinue: _continueCtrl.text.trim().isEmpty
              ? null
              : _continueCtrl.text.trim(),
          answeredStop: _stopCtrl.text.trim().isEmpty
              ? null
              : _stopCtrl.text.trim(),
          answeredStart: _startCtrl.text.trim().isEmpty
              ? null
              : _startCtrl.text.trim(),
          answeredProud: _proudCtrl.text.trim().isEmpty
              ? null
              : _proudCtrl.text.trim(),
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
    final now = DateTime.now();
    final isCurrentMonth = _year == now.year && _month == now.month;
    final monthDate = DateTime(_year, _month);
    final monthLabel = JalaliHelper.monthYear(monthDate);
    final goalHealthAsync = ref.watch(goalHealthProvider);

    // Load saved answers whenever month changes
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadExisting());

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppStrings.monthlyReflectionTitle,
                style: TextStyle(fontSize: 16)),
            Text(monthLabel,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _prevMonth,
            tooltip: 'ماه قبل',
          ),
          IconButton(
            icon: Icon(Icons.chevron_right,
                color: isCurrentMonth ? Colors.grey : null),
            onPressed: isCurrentMonth ? null : _nextMonth,
            tooltip: 'ماه بعد',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Goal Review section ───────────────────────────
            _GoalReviewSection(goalHealthAsync: goalHealthAsync),
            const SizedBox(height: 20),
            // ── Reflection questions ──────────────────────────
            Text('بازتاب ماهانه',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 12),
            _ReflectionField(
              label: AppStrings.reflectContinueLabel,
              controller: _continueCtrl,
              color: Colors.green.shade50,
              iconColor: Colors.green,
              icon: Icons.repeat,
            ),
            const SizedBox(height: 12),
            _ReflectionField(
              label: AppStrings.reflectStopLabel,
              controller: _stopCtrl,
              color: Colors.red.shade50,
              iconColor: Colors.red,
              icon: Icons.stop_circle_outlined,
            ),
            const SizedBox(height: 12),
            _ReflectionField(
              label: AppStrings.reflectStartLabel,
              controller: _startCtrl,
              color: Colors.blue.shade50,
              iconColor: Colors.blue,
              icon: Icons.play_circle_outlined,
            ),
            const SizedBox(height: 12),
            _ReflectionField(
              label: AppStrings.reflectProudLabel,
              controller: _proudCtrl,
              color: Colors.amber.shade50,
              iconColor: Colors.amber.shade700,
              icon: Icons.star_outline,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _save,
              child: const Text(AppStrings.saveReview),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Goal Review Section ───────────────────────────────────────

class _GoalReviewSection extends StatelessWidget {
  const _GoalReviewSection({required this.goalHealthAsync});

  final AsyncValue<List<GoalHealthInfo>> goalHealthAsync;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppStrings.goalReviewTitle,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: colors.onSurface)),
        const SizedBox(height: 8),
        goalHealthAsync.when(
          loading: () => const LinearProgressIndicator(),
          error: (e, _) => Text('خطا: $e'),
          data: (list) {
            if (list.isEmpty) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    AppStrings.noActiveGoals,
                    style: TextStyle(color: colors.onSurfaceVariant),
                  ),
                ),
              );
            }
            return Column(
              children: list
                  .map((info) => _GoalHealthTile(info: info))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _GoalHealthTile extends StatelessWidget {
  const _GoalHealthTile({required this.info});

  final GoalHealthInfo info;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final (label, chipColor) = switch (info.health) {
      'off_track' => (AppStrings.goalHealthOffTrack, Colors.red),
      'at_risk' => (AppStrings.goalHealthAtRisk, Colors.orange),
      _ => (AppStrings.goalHealthOnTrack, Colors.green),
    };
    final progress = info.totalShort == 0
        ? 0.0
        : info.completedShort / info.totalShort;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(info.goal.title,
                      style:
                          const TextStyle(fontWeight: FontWeight.w600)),
                  if (info.totalShort > 0) ...[
                    const SizedBox(height: 6),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: colors.surfaceContainerHighest,
                      color: chipColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${info.completedShort} از ${info.totalShort} هدف کوتاه تکمیل شده',
                      style: TextStyle(
                          fontSize: 11, color: colors.onSurfaceVariant),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: chipColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: chipColor),
              ),
            ),
          ],
        ),
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
