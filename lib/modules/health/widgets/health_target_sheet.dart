import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database.dart';
import '../providers/health_providers.dart';

void showHealthTargetSheet(BuildContext context, {HealthTarget? existing}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => _HealthTargetSheet(existing: existing),
  );
}

class _HealthTargetSheet extends ConsumerStatefulWidget {
  const _HealthTargetSheet({this.existing});

  final HealthTarget? existing;

  @override
  ConsumerState<_HealthTargetSheet> createState() => _HealthTargetSheetState();
}

class _HealthTargetSheetState extends ConsumerState<_HealthTargetSheet> {
  late final TextEditingController _weightCtrl;
  late final TextEditingController _waistCtrl;
  late final TextEditingController _bodyFatCtrl;
  DateTime? _targetDate;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final t = widget.existing;
    _weightCtrl = TextEditingController(
        text: t?.targetWeight != null
            ? t!.targetWeight!.toStringAsFixed(1)
            : '');
    _waistCtrl = TextEditingController(
        text: t?.targetWaistCm != null
            ? t!.targetWaistCm!.toStringAsFixed(1)
            : '');
    _bodyFatCtrl = TextEditingController(
        text: t?.targetBodyFatPct != null
            ? t!.targetBodyFatPct!.toStringAsFixed(1)
            : '');
    _targetDate = t?.targetDate;
  }

  @override
  void dispose() {
    _weightCtrl.dispose();
    _waistCtrl.dispose();
    _bodyFatCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _targetDate ?? DateTime.now().add(const Duration(days: 90)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null) setState(() => _targetDate = picked);
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    await ref.read(healthNotifierProvider.notifier).saveTarget(
          targetWeight: double.tryParse(_weightCtrl.text.trim()),
          targetWaistCm: double.tryParse(_waistCtrl.text.trim()),
          targetBodyFatPct: double.tryParse(_bodyFatCtrl.text.trim()),
          targetDate: _targetDate,
        );

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.healthTargetsSaved)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, bottom + 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Text(
                  AppStrings.healthTargetsTitle,
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'اهداف فقط برای مرجع نمایش داده می‌شوند.',
              style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _weightCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: AppStrings.targetWeightLabel,
                border: OutlineInputBorder(),
                suffixText: AppStrings.weightUnit,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _waistCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: AppStrings.targetWaistLabel,
                border: OutlineInputBorder(),
                suffixText: AppStrings.waistUnit,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _bodyFatCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: AppStrings.targetBodyFatLabel,
                border: OutlineInputBorder(),
                suffixText: AppStrings.bodyFatUnit,
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: colors.outline),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 18, color: colors.primary),
                    const SizedBox(width: 8),
                    Text(
                      _targetDate == null
                          ? AppStrings.targetDateLabel
                          : '${_targetDate!.year}/${_targetDate!.month.toString().padLeft(2, '0')}/${_targetDate!.day.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 15,
                        color: _targetDate == null
                            ? colors.onSurfaceVariant
                            : null,
                      ),
                    ),
                    if (_targetDate != null) ...[
                      const Spacer(),
                      GestureDetector(
                        onTap: () => setState(() => _targetDate = null),
                        child: Icon(Icons.clear,
                            size: 18, color: colors.onSurfaceVariant),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(AppStrings.save),
            ),
          ],
        ),
      ),
    );
  }
}
