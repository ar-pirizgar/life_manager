import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/review_providers.dart';

class ReviewsHubScreen extends ConsumerWidget {
  const ReviewsHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyAsync = ref.watch(allWeeklyReviewsProvider);
    final monthlyAsync = ref.watch(allMonthlyReflectionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.reviewsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          // ── Start new review buttons ──────────────────────
          const _ActionCard(
            icon: Icons.calendar_view_week_outlined,
            title: AppStrings.weeklyReviewTitle,
            subtitle: 'عملکرد هفتگی را مرور کن',
            color: Colors.blue,
            routePath: '/more/reviews/weekly',
          ),
          const SizedBox(height: 12),
          const _ActionCard(
            icon: Icons.calendar_month_outlined,
            title: AppStrings.monthlyReflectionTitle,
            subtitle: 'بازتاب ماهانه و مرور اهداف',
            color: Colors.purple,
            routePath: '/more/reviews/monthly',
          ),
          const SizedBox(height: 24),
          // ── Weekly reviews history ────────────────────────
          const _SectionHeader(AppStrings.pastWeeklyReviews),
          const SizedBox(height: 8),
          weeklyAsync.when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text('خطا: $e'),
            data: (list) => list.isEmpty
                ? const _EmptyHint(AppStrings.noReviewsYet)
                : Column(
                    children: list
                        .take(5)
                        .map((r) => _WeeklyReviewTile(review: r))
                        .toList(),
                  ),
          ),
          const SizedBox(height: 24),
          // ── Monthly reflections history ───────────────────
          const _SectionHeader(AppStrings.pastMonthlyReflections),
          const SizedBox(height: 8),
          monthlyAsync.when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text('خطا: $e'),
            data: (list) => list.isEmpty
                ? const _EmptyHint(AppStrings.noReviewsYet)
                : Column(
                    children: list
                        .take(5)
                        .map((r) => _MonthlyReflectionTile(reflection: r))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Helper widgets ────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.routePath,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final String routePath;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.15),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.chevron_right,
            color: Theme.of(context).colorScheme.onSurfaceVariant),
        onTap: () => context.go(routePath),
      ),
    );
  }
}

class _WeeklyReviewTile extends StatelessWidget {
  const _WeeklyReviewTile({required this.review});

  final WeeklyReview review;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final weekEnd = review.weekStart.add(const Duration(days: 6));
    final dateLabel =
        '${JalaliHelper.short(review.weekStart)} تا ${JalaliHelper.short(weekEnd)}';
    final hasAnswers = review.answeredWorked != null ||
        review.answeredFailed != null ||
        review.answeredLearned != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.calendar_view_week_outlined,
            color: Colors.blue),
        title: Text(dateLabel,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        subtitle: Text(
          '${review.completedTasks}/${review.totalTasks} تسک · '
          '${(review.habitSuccessRate * 100).round()}٪ عادت',
          style: TextStyle(fontSize: 11, color: colors.onSurfaceVariant),
        ),
        trailing: hasAnswers
            ? Icon(Icons.edit_note, size: 18, color: colors.primary)
            : null,
      ),
    );
  }
}

class _MonthlyReflectionTile extends StatelessWidget {
  const _MonthlyReflectionTile({required this.reflection});

  final MonthlyReflection reflection;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final monthDate = DateTime(reflection.year, reflection.month);
    final label = JalaliHelper.monthYear(monthDate);
    final hasAnswers = reflection.answeredContinue != null ||
        reflection.answeredStop != null ||
        reflection.answeredStart != null ||
        reflection.answeredProud != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.calendar_month_outlined, color: Colors.purple),
        title: Text(label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        trailing: hasAnswers
            ? Icon(Icons.edit_note, size: 18, color: colors.primary)
            : null,
      ),
    );
  }
}
