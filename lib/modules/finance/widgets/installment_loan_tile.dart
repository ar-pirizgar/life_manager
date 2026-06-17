import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/database/database.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/finance_providers.dart';
import '../providers/installment_providers.dart';

class InstallmentLoanTile extends ConsumerWidget {
  const InstallmentLoanTile({super.key, required this.loan});

  final InstallmentLoan loan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final installmentsAsync = ref.watch(loanInstallmentsProvider(loan.id));

    return installmentsAsync.when(
      data: (installments) => _buildCard(context, ref, installments),
      loading: () => _buildCard(context, ref, const []),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildCard(
      BuildContext context, WidgetRef ref, List<LoanInstallment> installments) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    final hasOverdue = installments.any((i) => i.status == 'overdue');
    final hasThisWeek = !hasOverdue &&
        installments.any((i) =>
            i.status == 'pending' && _isThisWeek(i.reminderDate));

    final (badgeLabel, badgeColor) = hasOverdue
        ? ('عقب‌افتاده', const Color(0xFFEF4444))
        : hasThisWeek
            ? ('این هفته', const Color(0xFFF59E0B))
            : ('به موقع', const Color(0xFF22C55E));

    final progress = loan.totalInstallments == 0
        ? 0.0
        : (loan.paidInstallments / loan.totalInstallments).clamp(0.0, 1.0);

    final remaining =
        (loan.totalInstallments - loan.paidInstallments) * loan.installmentAmount;

    // Next pending/overdue installment
    final LoanInstallment? nextInstallment = installments
        .where((i) => i.status == 'pending' || i.status == 'overdue')
        .fold<LoanInstallment?>(
          null,
          (prev, i) =>
              prev == null || i.installmentNumber < prev.installmentNumber
                  ? i
                  : prev,
        );

    final overdueInstallments =
        installments.where((i) => i.status == 'overdue').toList();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/finance/loan/${loan.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row 1: title + badge
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loan.title,
                          style: theme.textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          LoanType.fromKey(loan.type).label,
                          style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badgeLabel,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: badgeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: colors.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation(
                    hasOverdue
                        ? const Color(0xFFEF4444)
                        : colors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // Counter + remaining
              Row(
                children: [
                  Text(
                    '${JalaliHelper.toFa(loan.paidInstallments)} از ${JalaliHelper.toFa(loan.totalInstallments)} قسط',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: colors.onSurfaceVariant),
                  ),
                  const Spacer(),
                  Text(
                    'مانده: ${fmtAmount(remaining)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              // Next installment info
              if (nextInstallment != null) ...[
                const SizedBox(height: 8),
                const Divider(height: 1),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.schedule_outlined,
                        size: 14, color: colors.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text(
                      'قسط بعدی: ${fmtAmount(nextInstallment.amount)} — ${JalaliHelper.full(nextInstallment.reminderDate)}',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ],

              // Overdue quick-pay button
              if (overdueInstallments.isNotEmpty) ...[
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFEF4444),
                      side: const BorderSide(color: Color(0xFFEF4444)),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    icon: const Icon(Icons.payment_outlined, size: 16),
                    label: Text(
                        'ثبت پرداخت (${JalaliHelper.toFa(overdueInstallments.length)} قسط عقب‌افتاده)'),
                    onPressed: () => _payFirstOverdue(context, ref,
                        overdueInstallments.first),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  bool _isThisWeek(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final nextWeek = today.add(const Duration(days: 7));
    final d = DateTime(date.year, date.month, date.day);
    return !d.isBefore(today) && d.isBefore(nextWeek);
  }

  Future<void> _payFirstOverdue(BuildContext context, WidgetRef ref,
      LoanInstallment installment) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('ثبت پرداخت'),
        content: Text(
            'قسط ${installment.installmentNumber} به مبلغ ${fmtAmount(installment.amount)} پرداخت شد؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('لغو'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('تأیید'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(loanRepositoryProvider).markInstallmentPaid(installment);
    }
  }
}
