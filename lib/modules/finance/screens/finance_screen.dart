import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/finance_providers.dart';
import '../widgets/add_debt_sheet.dart';
import '../widgets/add_financial_goal_sheet.dart';
import '../widgets/add_transaction_sheet.dart';
import '../widgets/debt_tile.dart';
import '../widgets/finance_summary_card.dart';
import '../widgets/financial_goal_tile.dart';
import '../widgets/transaction_tile.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('مالی'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'تراکنش‌ها'),
              Tab(text: 'بدهی‌ها'),
              Tab(text: 'اهداف'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _TransactionsTab(),
            _DebtsTab(),
            _GoalsTab(),
          ],
        ),
        floatingActionButton: Builder(
          builder: (ctx) => FloatingActionButton(
            onPressed: () => showAddTransactionSheet(ctx),
            tooltip: 'افزودن تراکنش',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

// ─── Transactions Tab ─────────────────────────────────────────

class _TransactionsTab extends ConsumerWidget {
  const _TransactionsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTxs = ref.watch(allTransactionsProvider);

    return asyncTxs.when(
      data: (txs) {
        if (txs.isEmpty) {
          return Column(
            children: [
              const FinanceSummaryCard(),
              Expanded(child: _emptyState(context, 'هنوز تراکنشی ثبت نشده')),
            ],
          );
        }
        return Column(
          children: [
            const FinanceSummaryCard(),
            Expanded(
              child: ListView.builder(
                itemCount: txs.length,
                itemBuilder: (_, i) => TransactionTile(tx: txs[i]),
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

// ─── Debts Tab ────────────────────────────────────────────────

class _DebtsTab extends ConsumerWidget {
  const _DebtsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDebts = ref.watch(activeDebtsProvider);

    return asyncDebts.when(
      data: (debts) {
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'بدهی‌های فعال',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => showAddDebtSheet(context),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('افزودن'),
                  ),
                ],
              ),
            ),
            if (debts.isEmpty)
              Expanded(
                  child: _emptyState(context, 'هیچ بدهی فعالی وجود ندارد'))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: debts.length,
                  itemBuilder: (_, i) => DebtTile(debt: debts[i]),
                ),
              ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

// ─── Goals Tab ────────────────────────────────────────────────

class _GoalsTab extends ConsumerWidget {
  const _GoalsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncGoals = ref.watch(financialGoalsProvider);

    return asyncGoals.when(
      data: (goals) {
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'اهداف مالی',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => showAddFinancialGoalSheet(context),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('افزودن'),
                  ),
                ],
              ),
            ),
            if (goals.isEmpty)
              Expanded(
                  child: _emptyState(context, 'هنوز هدف مالی تعریف نشده'))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: goals.length,
                  itemBuilder: (_, i) =>
                      FinancialGoalTile(goal: goals[i]),
                ),
              ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

// ─── Helpers ─────────────────────────────────────────────────

Widget _emptyState(BuildContext context, String message) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.account_balance_wallet_outlined,
          size: 48,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: 12),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    ),
  );
}
