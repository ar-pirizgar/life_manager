import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/finance_providers.dart';

Future<void> showAddDebtSheet(BuildContext context) => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const _AddDebtSheet(),
    );

class _AddDebtSheet extends ConsumerStatefulWidget {
  const _AddDebtSheet();

  @override
  ConsumerState<_AddDebtSheet> createState() => _AddDebtSheetState();
}

class _AddDebtSheetState extends ConsumerState<_AddDebtSheet> {
  final _formKey = GlobalKey<FormState>();
  final _personCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _titleCtrl = TextEditingController();

  DebtDirection _direction = DebtDirection.iOwe;
  DateTime? _dueDate;
  bool _saving = false;

  @override
  void dispose() {
    _personCtrl.dispose();
    _amountCtrl.dispose();
    _titleCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final amount =
          double.parse(_amountCtrl.text.replaceAll(',', '').trim());
      final db = ref.read(databaseProvider);
      await db.into(db.debts).insert(
            DebtsCompanion(
              id: Value(const Uuid().v4()),
              person: Value(_personCtrl.text.trim()),
              amount: Value(amount),
              direction: Value(_direction.key),
              title: Value(_titleCtrl.text.trim().isEmpty
                  ? null
                  : _titleCtrl.text.trim()),
              dueDate: Value(_dueDate),
            ),
          );
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final insets = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
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
            Text('افزودن بدهی',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SegmentedButton<DebtDirection>(
              segments: DebtDirection.values
                  .map((d) =>
                      ButtonSegment(value: d, label: Text(d.label)))
                  .toList(),
              selected: {_direction},
              onSelectionChanged: (s) =>
                  setState(() => _direction = s.first),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _personCtrl,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'نام شخص'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'نام را وارد کنید'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amountCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'مبلغ'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'مبلغ را وارد کنید';
                if (double.tryParse(v.replaceAll(',', '').trim()) == null) {
                  return 'عدد معتبر وارد کنید';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _titleCtrl,
              decoration:
                  const InputDecoration(labelText: 'توضیحات (اختیاری)'),
            ),
            const SizedBox(height: 4),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.event_outlined, color: colors.primary),
              title: Text(_dueDate == null
                  ? 'سررسید (اختیاری)'
                  : JalaliHelper.full(_dueDate!)),
              trailing: TextButton(
                onPressed: _pickDueDate,
                child: Text(_dueDate == null ? 'انتخاب' : 'تغییر'),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('ذخیره'),
            ),
          ],
        ),
      ),
    );
  }
}
