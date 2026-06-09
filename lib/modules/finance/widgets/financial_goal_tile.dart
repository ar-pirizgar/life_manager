import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/finance_providers.dart';

class FinancialGoalTile extends ConsumerWidget {
  const FinancialGoalTile({super.key, required this.goal});

  final FinancialGoal goal;

  double get _progress => goal.targetAmount == 0
      ? 0
      : (goal.currentAmount / goal.targetAmount).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final pct = (_progress * 100).toStringAsFixed(0);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    goal.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  '${JalaliHelper.toFa(pct)}٪',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _progress >= 1.0
                        ? const Color(0xFF22C55E)
                        : colors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: 6,
                backgroundColor: colors.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation(
                  _progress >= 1.0
                      ? const Color(0xFF22C55E)
                      : colors.primary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${fmtAmount(goal.currentAmount)} از ${fmtAmount(goal.targetAmount)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                ),
                const Spacer(),
                if (goal.deadline != null)
                  Text(
                    JalaliHelper.full(goal.deadline!),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () => _updateProgress(context, ref),
                  child: const Text('بروزرسانی'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: colors.error,
                  ),
                  onPressed: () => _delete(context, ref),
                  child: const Text('حذف'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateProgress(BuildContext context, WidgetRef ref) async {
    final ctrl = TextEditingController(
        text: goal.currentAmount == 0 ? '' : goal.currentAmount.toString());
    final result = await showDialog<double>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('بروزرسانی پیشرفت'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'مبلغ فعلی'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('لغو'),
          ),
          FilledButton(
            onPressed: () {
              final v =
                  double.tryParse(ctrl.text.replaceAll(',', '').trim());
              if (v != null) Navigator.pop(ctx, v);
            },
            child: const Text('ذخیره'),
          ),
        ],
      ),
    );
    ctrl.dispose();
    if (result != null) {
      final db = ref.read(databaseProvider);
      await (db.update(db.financialGoals)
            ..where((g) => g.id.equals(goal.id)))
          .write(FinancialGoalsCompanion(currentAmount: Value(result)));
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف هدف مالی'),
        content: Text('هدف «${goal.title}» حذف شود؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('لغو'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (ok == true) {
      final db = ref.read(databaseProvider);
      await (db.delete(db.financialGoals)
            ..where((g) => g.id.equals(goal.id)))
          .go();
    }
  }
}
