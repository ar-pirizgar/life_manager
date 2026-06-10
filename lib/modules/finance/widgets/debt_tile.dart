import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/finance_providers.dart';

class DebtTile extends ConsumerWidget {
  const DebtTile({super.key, required this.debt});

  final Debt debt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final dir = DebtDirection.fromKey(debt.direction);
    final isIOwe = dir == DebtDirection.iOwe;
    final accentColor =
        isIOwe ? const Color(0xFFEF4444) : const Color(0xFF22C55E);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentColor.withValues(alpha: 0.12),
              ),
              child: Icon(
                isIOwe ? Icons.arrow_upward : Icons.arrow_downward,
                color: accentColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    debt.person,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (debt.title != null && debt.title!.isNotEmpty)
                    Text(
                      debt.title!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                    ),
                  if (debt.dueDate != null)
                    Text(
                      'سررسید: ${JalaliHelper.full(debt.dueDate!)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                    ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  fmtAmount(debt.amount),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
                const SizedBox(height: 4),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () => _settle(context, ref),
                  child: const Text('تسویه'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _settle(BuildContext context, WidgetRef ref) async {
    final db = ref.read(databaseProvider);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تسویه بدهی'),
        content: Text('بدهی با ${debt.person} تسویه شده؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('لغو'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('تسویه'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await (db.update(db.debts)..where((d) => d.id.equals(debt.id)))
          .write(const DebtsCompanion(status: Value('settled')));
    }
  }
}
