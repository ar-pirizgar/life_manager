import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';
import '../../../shared/utils/jalali_helper.dart';

// ─── Enums ────────────────────────────────────────────────────

enum TxType {
  expense('expense', 'هزینه'),
  income('income', 'درآمد');

  const TxType(this.key, this.label);
  final String key;
  final String label;
  static TxType fromKey(String key) =>
      key == 'income' ? TxType.income : TxType.expense;
}

enum TxCategory {
  food('food', 'غذا', TxType.expense),
  transport('transport', 'حمل‌ونقل', TxType.expense),
  shopping('shopping', 'خرید', TxType.expense),
  housing('housing', 'مسکن', TxType.expense),
  health('health', 'سلامت', TxType.expense),
  entertainment('entertainment', 'سرگرمی', TxType.expense),
  education('education', 'آموزش', TxType.expense),
  salary('salary', 'حقوق', TxType.income),
  freelance('freelance', 'فریلنسر', TxType.income),
  investment('investment', 'سرمایه‌گذاری', TxType.income),
  other('other', 'متفرقه', null);

  const TxCategory(this.key, this.label, this.primaryType);
  final String key;
  final String label;
  final TxType? primaryType;

  static TxCategory fromKey(String key) => TxCategory.values.firstWhere(
        (e) => e.key == key,
        orElse: () => TxCategory.other,
      );

  static List<TxCategory> forType(TxType type) => TxCategory.values
      .where((e) => e.primaryType == type || e.primaryType == null)
      .toList();
}

enum DebtDirection {
  iOwe('i_owe', 'من بدهکارم'),
  theyOwe('they_owe', 'طرف بدهکاره');

  const DebtDirection(this.key, this.label);
  final String key;
  final String label;
  static DebtDirection fromKey(String key) =>
      key == 'they_owe' ? DebtDirection.theyOwe : DebtDirection.iOwe;
}

// ─── Summary Model ────────────────────────────────────────────

class FinanceSummary {
  const FinanceSummary({required this.income, required this.expense});
  final double income;
  final double expense;
  double get balance => income - expense;
  double get savingsRate =>
      income == 0 ? 0 : (balance / income).clamp(0.0, 1.0);
}

// ─── Amount Formatter ─────────────────────────────────────────

String fmtAmount(double amount) {
  final s = NumberFormat('#,##0', 'en').format(amount.abs());
  return JalaliHelper.toFa(s);
}

// ─── Providers ────────────────────────────────────────────────

final currentMonthTransactionsProvider =
    StreamProvider<List<Transaction>>((ref) {
  return ref.watch(databaseProvider).watchCurrentMonthTransactions();
});

final allTransactionsProvider = StreamProvider<List<Transaction>>((ref) {
  return ref.watch(databaseProvider).watchAllTransactions();
});

final monthSummaryProvider = Provider<FinanceSummary>((ref) {
  final txs =
      ref.watch(currentMonthTransactionsProvider).valueOrNull ?? [];
  double income = 0, expense = 0;
  for (final t in txs) {
    if (t.type == 'income') {
      income += t.amount;
    } else {
      expense += t.amount;
    }
  }
  return FinanceSummary(income: income, expense: expense);
});

final activeDebtsProvider = StreamProvider<List<Debt>>((ref) {
  return ref.watch(databaseProvider).watchActiveDebts();
});

final financialGoalsProvider = StreamProvider<List<FinancialGoal>>((ref) {
  return ref.watch(databaseProvider).watchFinancialGoals();
});
