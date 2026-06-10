import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/app_strings.dart';
import '../providers/dashboard_providers.dart';

class AddKpiSheet extends ConsumerStatefulWidget {
  const AddKpiSheet({super.key});

  @override
  ConsumerState<AddKpiSheet> createState() => _AddKpiSheetState();
}

class _AddKpiSheetState extends ConsumerState<AddKpiSheet> {
  final _titleCtrl = TextEditingController();
  final _unitCtrl = TextEditingController();
  final _emojiCtrl = TextEditingController(text: '📊');
  final _targetCtrl = TextEditingController();
  String _direction = 'higher_better';
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _unitCtrl.dispose();
    _emojiCtrl.dispose();
    _targetCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final target = _targetCtrl.text.trim().isEmpty
        ? null
        : double.tryParse(_targetCtrl.text.trim());
    await ref.read(kpiNotifierProvider.notifier).addKpi(
          title: _titleCtrl.text.trim(),
          unit: _unitCtrl.text.trim(),
          emoji: _emojiCtrl.text.trim().isEmpty ? '📊' : _emojiCtrl.text.trim(),
          direction: _direction,
          targetValue: target,
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
              const Text(
                AppStrings.addKpi,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 72,
                    child: TextFormField(
                      controller: _emojiCtrl,
                      decoration: const InputDecoration(labelText: 'آیکون'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _titleCtrl,
                      decoration: const InputDecoration(
                          labelText: AppStrings.kpiTitleHint),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty)
                              ? AppStrings.titleRequired
                              : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _unitCtrl,
                decoration:
                    const InputDecoration(labelText: AppStrings.kpiUnitHint),
                validator: (v) =>
                    (v == null || v.trim().isEmpty)
                        ? AppStrings.unitRequired
                        : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _targetCtrl,
                decoration:
                    const InputDecoration(labelText: AppStrings.kpiTargetHint),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  if (double.tryParse(v.trim()) == null) {
                    return AppStrings.invalidNumber;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(AppStrings.kpiDirection,
                  style: TextStyle(
                      color: colors.onSurfaceVariant, fontSize: 13)),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                      value: 'higher_better',
                      label: Text(AppStrings.higherBetter)),
                  ButtonSegment(
                      value: 'lower_better',
                      label: Text(AppStrings.lowerBetter)),
                ],
                selected: {_direction},
                onSelectionChanged: (s) =>
                    setState(() => _direction = s.first),
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
