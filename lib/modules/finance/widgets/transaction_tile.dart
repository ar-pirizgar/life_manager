import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/finance_providers.dart';
import 'edit_transaction_sheet.dart';

class TransactionTile extends ConsumerWidget {
  const TransactionTile({super.key, required this.tx});

  final Transaction tx;

  static const _icons = <String, IconData>{
    'food': Icons.restaurant_outlined,
    'transport': Icons.directions_car_outlined,
    'shopping': Icons.shopping_bag_outlined,
    'housing': Icons.home_outlined,
    'health': Icons.medical_services_outlined,
    'entertainment': Icons.movie_outlined,
    'education': Icons.school_outlined,
    'salary': Icons.work_outlined,
    'freelance': Icons.laptop_outlined,
    'investment': Icons.trending_up_outlined,
    'installment_payment': Icons.credit_score_outlined,
    'other': Icons.category_outlined,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final type = TxType.fromKey(tx.type);
    final cat = TxCategory.fromKey(tx.category);
    final isIncome = type == TxType.income;
    final amountColor =
        isIncome ? const Color(0xFF22C55E) : const Color(0xFFEF4444);

    return Dismissible(
      key: Key(tx.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16),
        color: colors.errorContainer,
        child: Icon(Icons.delete_outline, color: colors.onErrorContainer),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('حذف تراکنش'),
            content: Text('«${tx.title}» حذف شود؟'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('لغو'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: FilledButton.styleFrom(
                  backgroundColor: colors.error,
                  foregroundColor: colors.onError,
                ),
                child: const Text('حذف'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) async {
        final db = ref.read(databaseProvider);
        await (db.delete(db.transactions)
              ..where((t) => t.id.equals(tx.id)))
            .go();
      },
      child: ListTile(
        onTap: () => showEditTransactionSheet(context, tx),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isIncome
                ? const Color(0xFF22C55E).withValues(alpha: 0.12)
                : const Color(0xFFEF4444).withValues(alpha: 0.12),
          ),
          child: Icon(
            _icons[tx.category] ?? Icons.category_outlined,
            color: amountColor,
            size: 20,
          ),
        ),
        title: Text(tx.title),
        subtitle: Text('${cat.label} · ${JalaliHelper.relative(tx.date)}'),
        trailing: Text(
          '${isIncome ? '+' : '-'}${fmtAmount(tx.amount)}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: amountColor,
              ),
        ),
      ),
    );
  }
}
