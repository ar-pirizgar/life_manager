import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database.dart';
import '../providers/dashboard_providers.dart';

class AddKpiLogSheet extends ConsumerStatefulWidget {
  const AddKpiLogSheet({super.key, required this.kpi});

  final Kpi kpi;

  @override
  ConsumerState<AddKpiLogSheet> createState() => _AddKpiLogSheetState();
}

class _AddKpiLogSheetState extends ConsumerState<AddKpiLogSheet> {
  final _valueCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _valueCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final value = double.parse(_valueCtrl.text.trim());
    await ref.read(kpiNotifierProvider.notifier).logValue(
          kpiId: widget.kpi.id,
          value: value,
          notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
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
              Row(
                children: [
                  Text(widget.kpi.emoji,
                      style: const TextStyle(fontSize: 28)),
                  const SizedBox(width: 12),
                  Text(
                    widget.kpi.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _valueCtrl,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: AppStrings.logValueHint,
                  suffixText: widget.kpi.unit,
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return AppStrings.invalidNumber;
                  }
                  if (double.tryParse(v.trim()) == null) {
                    return AppStrings.invalidNumber;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notesCtrl,
                decoration:
                    const InputDecoration(labelText: AppStrings.logNotes),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _save,
                child: const Text(AppStrings.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
