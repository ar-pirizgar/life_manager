import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/database/database.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/finance_providers.dart';
import '../providers/installment_providers.dart';
import '../widgets/add_installment_loan_sheet.dart';

class InstallmentLoanDetailScreen extends ConsumerWidget {
  const InstallmentLoanDetailScreen({super.key, required this.loanId});

  final String loanId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanAsync = ref.watch(loanByIdProvider(loanId));
    final installmentsAsync = ref.watch(loanInstallmentsProvider(loanId));

    return Scaffold(
      appBar: AppBar(
        title: loanAsync.when(
          data: (l) => Text(l?.title ?? 'جزئیات وام'),
          loading: () => const Text('جزئیات وام'),
          error: (_, __) => const Text('جزئیات وام'),
        ),
        actions: [
          loanAsync.when(
            data: (loan) => loan != null && loan.status == 'active'
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        tooltip: 'ویرایش',
                        onPressed: () => showAddInstallmentLoanSheet(
                          context,
                          loan: loan,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        tooltip: 'حذف',
                        onPressed: () => _deleteLoan(context, ref, loan),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: loanAsync.when(
        data: (loan) {
          if (loan == null) {
            return const Center(child: Text('وام یافت نشد'));
          }
          return installmentsAsync.when(
            data: (installments) =>
                _buildBody(context, ref, loan, installments),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const SizedBox.shrink(),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, InstallmentLoan loan,
      List<LoanInstallment> installments) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    final remaining =
        (loan.totalInstallments - loan.paidInstallments) * loan.installmentAmount;
    final progress = loan.totalInstallments == 0
        ? 0.0
        : (loan.paidInstallments / loan.totalInstallments).clamp(0.0, 1.0);

    return ListView(
      children: [
        // ── Summary card ─────────────────────────────────────────
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('مانده بدهی',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: colors.onSurfaceVariant)),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      LoanType.fromKey(loan.type).label,
                      style: theme.textTheme.labelSmall?.copyWith(
                          color: colors.onPrimaryContainer),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                fmtAmount(remaining),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: remaining > 0
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF22C55E),
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: colors.surfaceContainerHighest,
                  valueColor:
                      AlwaysStoppedAnimation(colors.primary),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _InfoChip(
                    icon: Icons.payments_outlined,
                    label: 'هر قسط: ${fmtAmount(loan.installmentAmount)}',
                  ),
                  _InfoChip(
                    icon: Icons.event_outlined,
                    label: 'موعد: روز ${JalaliHelper.toFa(loan.dueDayOfMonth)}',
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _InfoChip(
                    icon: Icons.notifications_outlined,
                    label:
                        'یادآوری: روز ${JalaliHelper.toFa(loan.reminderDayOfMonth)}',
                  ),
                  _InfoChip(
                    icon: Icons.format_list_numbered_outlined,
                    label:
                        '${JalaliHelper.toFa(loan.paidInstallments)} از ${JalaliHelper.toFa(loan.totalInstallments)} قسط',
                  ),
                ],
              ),
            ],
          ),
        ),

        // ── Installments list ─────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Text('تاریخچه اقساط',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),

        ...installments.map((inst) =>
            _InstallmentRow(installment: inst, loan: loan, ref: ref)),

        const SizedBox(height: 24),
      ],
    );
  }

  Future<void> _deleteLoan(
      BuildContext context, WidgetRef ref, InstallmentLoan loan) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف وام'),
        content: Text(
            'وام «${loan.title}» و تمام اقساط آن حذف شود؟\nتراکنش‌های ثبت شده حذف نمی‌شوند.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('لغو'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
              foregroundColor: Theme.of(ctx).colorScheme.onError,
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      await ref.read(loanRepositoryProvider).deleteLoan(loan.id);
      if (context.mounted) Navigator.pop(context);
    }
  }
}

class _InstallmentRow extends StatelessWidget {
  const _InstallmentRow({
    required this.installment,
    required this.loan,
    required this.ref,
  });

  final LoanInstallment installment;
  final InstallmentLoan loan;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final status = InstallmentPaymentStatus.fromKey(installment.status);

    final isOverdue = status == InstallmentPaymentStatus.overdue;
    final isPaid = status == InstallmentPaymentStatus.paid;
    final isPaidEarly = isPaid &&
        installment.paidAt != null &&
        installment.paidAt!.isBefore(installment.dueDate);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: isOverdue
              ? const Color(0xFFEF4444)
              : colors.outlineVariant.withValues(alpha: 0.5),
          width: isOverdue ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isPaid
            ? const Color(0xFF22C55E).withValues(alpha: 0.04)
            : isOverdue
                ? const Color(0xFFEF4444).withValues(alpha: 0.04)
                : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            // شماره قسط
            SizedBox(
              width: 36,
              child: Text(
                JalaliHelper.toFa(installment.installmentNumber),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isOverdue
                      ? const Color(0xFFEF4444)
                      : isPaid
                          ? const Color(0xFF22C55E)
                          : colors.onSurface,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fmtAmount(installment.amount),
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  if (isPaid) ...[
                    Text(
                      'پرداخت شده: ${JalaliHelper.full(installment.paidAt!)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF22C55E)),
                    ),
                    if (isPaidEarly)
                      Text(
                        'زودتر از موعد',
                        style: theme.textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF22C55E),
                            fontStyle: FontStyle.italic),
                      ),
                  ] else if (isOverdue)
                    Text(
                      'موعد: ${JalaliHelper.full(installment.dueDate)}',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: const Color(0xFFEF4444)),
                    )
                  else
                    Text(
                      'یادآوری: ${JalaliHelper.full(installment.reminderDate)}',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: colors.onSurfaceVariant),
                    ),
                ],
              ),
            ),

            // Status badge or pay button
            if (isPaid)
              const Icon(Icons.check_circle,
                  color: Color(0xFF22C55E), size: 20)
            else if (isOverdue)
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444),
                  minimumSize: Size.zero,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () => _payInstallment(context),
                child: const Text('ثبت پرداخت'),
              )
            else
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () => _payInstallment(context),
                child: const Text('پرداخت'),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _payInstallment(BuildContext context) async {
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

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: colors.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}
