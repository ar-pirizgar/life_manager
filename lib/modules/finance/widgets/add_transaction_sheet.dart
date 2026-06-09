import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/finance_providers.dart';

Future<void> showAddTransactionSheet(BuildContext context) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const _AddTransactionSheet(),
    );

class _AddTransactionSheet extends ConsumerStatefulWidget {
  const _AddTransactionSheet();

  @override
  ConsumerState<_AddTransactionSheet> createState() =>
      _AddTransactionSheetState();
}

class _AddTransactionSheetState extends ConsumerState<_AddTransactionSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  TxType _type = TxType.expense;
  TxCategory _category = TxCategory.other;
  DateTime _date = DateTime.now();
  bool _saving = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  List<TxCategory> get _categories => TxCategory.forType(_type);

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final amount =
          double.parse(_amountCtrl.text.replaceAll(',', '').trim());
      final db = ref.read(databaseProvider);
      await db.into(db.transactions).insert(
            TransactionsCompanion(
              id: Value(const Uuid().v4()),
              title: Value(_titleCtrl.text.trim()),
              amount: Value(amount),
              type: Value(_type.key),
              category: Value(_category.key),
              date: Value(_date),
              notes: Value(_notesCtrl.text.trim().isEmpty
                  ? null
                  : _notesCtrl.text.trim()),
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
            SegmentedButton<TxType>(
              segments: TxType.values
                  .map((t) => ButtonSegment(
                        value: t,
                        label: Text(t.label),
                        icon: Icon(t == TxType.expense
                            ? Icons.arrow_downward
                            : Icons.arrow_upward),
                      ))
                  .toList(),
              selected: {_type},
              onSelectionChanged: (s) => setState(() {
                _type = s.first;
                _category = TxCategory.other;
              }),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountCtrl,
              autofocus: true,
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
              decoration: const InputDecoration(labelText: 'عنوان'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'عنوان را وارد کنید'
                  : null,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final cat = _categories[i];
                  return FilterChip(
                    label: Text(cat.label),
                    selected: _category == cat,
                    onSelected: (_) => setState(() => _category = cat),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading:
                  Icon(Icons.calendar_today_outlined, color: colors.primary),
              title: Text(JalaliHelper.relative(_date)),
              trailing: TextButton(
                onPressed: _pickDate,
                child: const Text('تغییر'),
              ),
            ),
            TextFormField(
              controller: _notesCtrl,
              decoration:
                  const InputDecoration(labelText: 'یادداشت (اختیاری)'),
            ),
            const SizedBox(height: 16),
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
