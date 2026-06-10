import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/finance_providers.dart';

Future<void> showEditTransactionSheet(
        BuildContext context, Transaction tx) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _EditTransactionSheet(tx: tx),
    );

class _EditTransactionSheet extends ConsumerStatefulWidget {
  const _EditTransactionSheet({required this.tx});
  final Transaction tx;

  @override
  ConsumerState<_EditTransactionSheet> createState() =>
      _EditTransactionSheetState();
}

class _EditTransactionSheetState
    extends ConsumerState<_EditTransactionSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _amountCtrl;
  late final TextEditingController _notesCtrl;
  late TxType _type;
  late TxCategory _category;
  late DateTime _date;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.tx.title);
    _amountCtrl =
        TextEditingController(text: widget.tx.amount.toStringAsFixed(0));
    _notesCtrl = TextEditingController(text: widget.tx.notes ?? '');
    _type = TxType.fromKey(widget.tx.type);
    _category = TxCategory.fromKey(widget.tx.category);
    _date = widget.tx.date;
  }

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
    final db = ref.read(databaseProvider);
    try {
      final amount =
          double.parse(_amountCtrl.text.replaceAll(',', '').trim());
      final notes = _notesCtrl.text.trim();
      await (db.update(db.transactions)
            ..where((t) => t.id.equals(widget.tx.id)))
          .write(TransactionsCompanion(
        title: Value(_titleCtrl.text.trim()),
        amount: Value(amount),
        type: Value(_type.key),
        category: Value(_category.key),
        date: Value(_date),
        notes: Value(notes.isEmpty ? null : notes),
      ));
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
            Text('ویرایش تراکنش',
                style: Theme.of(context).textTheme.titleLarge),
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
