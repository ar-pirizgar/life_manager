import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';
import '../../../shared/utils/jalali_helper.dart';

Future<void> showAddFinancialGoalSheet(BuildContext context) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const _AddFinancialGoalSheet(),
    );

class _AddFinancialGoalSheet extends ConsumerStatefulWidget {
  const _AddFinancialGoalSheet();

  @override
  ConsumerState<_AddFinancialGoalSheet> createState() =>
      _AddFinancialGoalSheetState();
}

class _AddFinancialGoalSheetState
    extends ConsumerState<_AddFinancialGoalSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _targetCtrl = TextEditingController();
  final _currentCtrl = TextEditingController();

  DateTime? _deadline;
  bool _saving = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _targetCtrl.dispose();
    _currentCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDeadline() async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          _deadline ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (picked != null) setState(() => _deadline = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final target =
          double.parse(_targetCtrl.text.replaceAll(',', '').trim());
      final current = _currentCtrl.text.trim().isEmpty
          ? 0.0
          : double.parse(
              _currentCtrl.text.replaceAll(',', '').trim());
      final db = ref.read(databaseProvider);
      await db.into(db.financialGoals).insert(
            FinancialGoalsCompanion(
              id: Value(const Uuid().v4()),
              title: Value(_titleCtrl.text.trim()),
              targetAmount: Value(target),
              currentAmount: Value(current),
              deadline: Value(_deadline),
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
            Text('هدف مالی جدید',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleCtrl,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'عنوان'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'عنوان را وارد کنید'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _targetCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'مبلغ هدف'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'مبلغ هدف را وارد کنید';
                }
                if (double.tryParse(v.replaceAll(',', '').trim()) ==
                    null) {
                  return 'عدد معتبر وارد کنید';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _currentCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration:
                  const InputDecoration(labelText: 'پس‌انداز فعلی (اختیاری)'),
            ),
            const SizedBox(height: 4),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.event_outlined, color: colors.primary),
              title: Text(_deadline == null
                  ? 'مهلت (اختیاری)'
                  : JalaliHelper.full(_deadline!)),
              trailing: TextButton(
                onPressed: _pickDeadline,
                child: Text(_deadline == null ? 'انتخاب' : 'تغییر'),
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
