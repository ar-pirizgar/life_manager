import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/finance_providers.dart';
import '../providers/installment_providers.dart';
import '../widgets/add_financial_goal_sheet.dart';
import '../widgets/add_installment_loan_sheet.dart';
import '../widgets/add_transaction_sheet.dart';
import '../widgets/finance_summary_card.dart';
import '../widgets/financial_goal_tile.dart';
import '../widgets/installment_loan_tile.dart';
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
              Tab(text: 'اقساط'),
              Tab(text: 'اهداف'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _TransactionsTab(),
            _InstallmentsTab(),
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

// ─── Installments Tab ─────────────────────────────────────────

class _InstallmentsTab extends ConsumerStatefulWidget {
  const _InstallmentsTab();

  @override
  ConsumerState<_InstallmentsTab> createState() => _InstallmentsTabState();
}

class _InstallmentsTabState extends ConsumerState<_InstallmentsTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(loanRepositoryProvider).syncInstallmentsState());
  }

  @override
  Widget build(BuildContext context) {
    final loansAsync = ref.watch(activeLoansProvider);
    final pendingAsync = ref.watch(allPendingInstallmentsProvider);

    return loansAsync.when(
      data: (loans) {
        final now = DateTime.now();
        final loanIds = loans.map((l) => l.id).toSet();

        double totalRemaining = loans.fold(0.0, (sum, l) {
          return sum +
              (l.totalInstallments - l.paidInstallments) *
                  l.installmentAmount;
        });

        double thisMonth = 0;
        pendingAsync.whenData((pending) {
          thisMonth = pending
              .where((i) =>
                  loanIds.contains(i.loanId) &&
                  i.month == now.month &&
                  i.year == now.year)
              .fold(0.0, (sum, i) => sum + i.amount);
        });

        return Column(
          children: [
            // ── Summary cards ─────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      label: 'کل بدهی فعال',
                      amount: totalRemaining,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SummaryCard(
                      label: 'قسط این ماه',
                      amount: thisMonth,
                      color: const Color(0xFFF59E0B),
                    ),
                  ),
                ],
              ),
            ),

            // ── Header with add button ─────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Text(
                    'وام‌ها و اقساط',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () =>
                        showAddInstallmentLoanSheet(context),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('افزودن'),
                  ),
                ],
              ),
            ),

            // ── Loans list ────────────────────────────────────
            if (loans.isEmpty)
              Expanded(
                child: _emptyState(
                    context, 'هیچ وام یا قستی ثبت نشده'),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: loans.length,
                  itemBuilder: (_, i) =>
                      InstallmentLoanTile(loan: loans[i]),
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

// ─── Summary Card ─────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.amount,
    required this.color,
  });

  final String label;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            fmtAmount(amount),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
        ],
      ),
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
