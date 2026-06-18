import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/database/database.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/installment_providers.dart';

Future<void> showAddInstallmentLoanSheet(
  BuildContext context, {
  InstallmentLoan? loan,
}) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.88,
        minChildSize: 0.1,
        maxChildSize: 0.95,
        builder: (_, scrollController) =>
            _AddInstallmentLoanSheet(loan: loan, scrollController: scrollController),
      ),
    );

class _AddInstallmentLoanSheet extends ConsumerStatefulWidget {
  const _AddInstallmentLoanSheet({this.loan, required this.scrollController});

  final InstallmentLoan? loan;
  final ScrollController scrollController;

  @override
  ConsumerState<_AddInstallmentLoanSheet> createState() =>
      _AddInstallmentLoanSheetState();
}

class _AddInstallmentLoanSheetState
    extends ConsumerState<_AddInstallmentLoanSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _totalAmountCtrl = TextEditingController();
  final _installmentAmountCtrl = TextEditingController();
  final _totalInstallmentsCtrl = TextEditingController();
  final _paidInstallmentsCtrl = TextEditingController(text: '0');

  LoanType _type = LoanType.bankLoan;
  int _dueDayOfMonth = 25;
  int _reminderDayOfMonth = 1;
  DateTime _startDate = DateTime.now();
  bool _saving = false;

  bool get _isEditing => widget.loan != null;

  @override
  void initState() {
    super.initState();
    final loan = widget.loan;
    if (loan != null) {
      _titleCtrl.text = loan.title;
      _totalAmountCtrl.text = loan.totalAmount.toInt().toString();
      _installmentAmountCtrl.text = loan.installmentAmount.toInt().toString();
      _totalInstallmentsCtrl.text = loan.totalInstallments.toString();
      _paidInstallmentsCtrl.text = loan.paidInstallments.toString();
      _type = LoanType.fromKey(loan.type);
      _dueDayOfMonth = loan.dueDayOfMonth;
      _reminderDayOfMonth = loan.reminderDayOfMonth;
      _startDate = loan.startDate;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _totalAmountCtrl.dispose();
    _installmentAmountCtrl.dispose();
    _totalInstallmentsCtrl.dispose();
    _paidInstallmentsCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickStartDate() async {
    final picked = await JalaliHelper.pickDate(
      context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (picked != null) setState(() => _startDate = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final repo = ref.read(loanRepositoryProvider);
      final title = _titleCtrl.text.trim();
      final totalAmount =
          double.parse(_totalAmountCtrl.text.replaceAll(',', '').trim());
      final installmentAmount = double.parse(
          _installmentAmountCtrl.text.replaceAll(',', '').trim());
      final totalInstallments = int.parse(_totalInstallmentsCtrl.text.trim());

      if (_isEditing) {
        await repo.updateLoan(
          loanId: widget.loan!.id,
          title: title,
          type: _type,
          totalAmount: totalAmount,
          installmentAmount: installmentAmount,
          totalInstallments: totalInstallments,
          dueDayOfMonth: _dueDayOfMonth,
          reminderDayOfMonth: _reminderDayOfMonth,
          startDate: _startDate,
        );
      } else {
        await repo.createLoan(
          title: title,
          type: _type,
          totalAmount: totalAmount,
          installmentAmount: installmentAmount,
          totalInstallments: totalInstallments,
          paidInstallments:
              int.tryParse(_paidInstallmentsCtrl.text.trim()) ?? 0,
          dueDayOfMonth: _dueDayOfMonth,
          reminderDayOfMonth: _reminderDayOfMonth,
          startDate: _startDate,
        );
      }
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final insets = MediaQuery.viewInsetsOf(context).bottom;

    return SingleChildScrollView(
      controller: widget.scrollController,
      padding: EdgeInsets.fromLTRB(16, 12, 16, insets + 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _isEditing ? 'ویرایش وام / قسط' : 'افزودن وام / قسط',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            // نوع وام
            DropdownButtonFormField<LoanType>(
              initialValue: _type,
              decoration: const InputDecoration(labelText: 'نوع'),
              items: LoanType.values
                  .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(t.label),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _type = v!),
            ),
            const SizedBox(height: 12),

            // عنوان
            TextFormField(
              controller: _titleCtrl,
              autofocus: true,
              decoration:
                  const InputDecoration(labelText: 'عنوان (مثلاً: وام خودرو)'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'عنوان الزامی است' : null,
            ),
            const SizedBox(height: 12),

            // مبلغ کل
            TextFormField(
              controller: _totalAmountCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'مبلغ کل'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'مبلغ کل الزامی است';
                if (double.tryParse(v.replaceAll(',', '').trim()) == null) {
                  return 'عدد معتبر وارد کنید';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // مبلغ هر قسط
            TextFormField(
              controller: _installmentAmountCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'مبلغ هر قسط'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'مبلغ هر قسط الزامی است';
                }
                if (double.tryParse(v.replaceAll(',', '').trim()) == null) {
                  return 'عدد معتبر وارد کنید';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                // تعداد کل اقساط
                Expanded(
                  child: TextFormField(
                    controller: _totalInstallmentsCtrl,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: 'تعداد کل اقساط'),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'الزامی است';
                      final n = int.tryParse(v.trim());
                      if (n == null || n < 1) return 'عدد معتبر';
                      if (_isEditing) {
                        final paid = widget.loan!.paidInstallments;
                        if (n < paid) return 'کمتر از $paid نمی‌شود';
                      }
                      return null;
                    },
                  ),
                ),
                if (!_isEditing) ...[
                  const SizedBox(width: 12),
                  // اقساط پرداخت شده — فقط در حالت ایجاد
                  Expanded(
                    child: TextFormField(
                      controller: _paidInstallmentsCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'اقساط پرداخت شده'),
                      validator: (v) {
                        final n = int.tryParse(v?.trim() ?? '');
                        if (n == null || n < 0) return 'عدد معتبر';
                        return null;
                      },
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),

            // موعد واقعی قسط
            _DaySelector(
              label: 'موعد واقعی قسط',
              value: _dueDayOfMonth,
              onChanged: (v) => setState(() => _dueDayOfMonth = v),
            ),
            const SizedBox(height: 12),

            // روز یادآوری در Tasks — highlighted
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colors.primary.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DaySelector(
                    label: 'روز یادآوری در تسک‌ها',
                    value: _reminderDayOfMonth,
                    onChanged: (v) => setState(() => _reminderDayOfMonth = v),
                    labelColor: colors.primary,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'یک تسک خودکار این روز ساخته می‌شود',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.primary,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // تاریخ شروع
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.calendar_today_outlined, color: colors.primary),
              title: Text('تاریخ شروع: ${JalaliHelper.full(_startDate)}'),
              trailing: TextButton(
                onPressed: _pickStartDate,
                child: const Text('تغییر'),
              ),
            ),

            if (_isEditing) ...[
              const SizedBox(height: 4),
              Text(
                'اقساط پرداخت‌شده حفظ می‌شوند. فقط اقساط آینده بازتولید می‌شوند.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
              ),
            ],

            const SizedBox(height: 16),

            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_isEditing ? 'ذخیره تغییرات' : 'ذخیره'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DaySelector extends StatelessWidget {
  const _DaySelector({
    required this.label,
    required this.value,
    required this.onChanged,
    this.labelColor,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: labelColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.remove_circle_outline, size: 20),
          onPressed: value > 1 ? () => onChanged(value - 1) : null,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
        SizedBox(
          width: 32,
          child: Text(
            JalaliHelper.toFa(value),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, color: labelColor),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline, size: 20),
          onPressed: value < 31 ? () => onChanged(value + 1) : null,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
      ],
    );
  }
}
