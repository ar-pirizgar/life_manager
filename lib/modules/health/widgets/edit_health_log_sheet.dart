import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database.dart';
import '../providers/health_providers.dart';

void showEditHealthLogSheet(BuildContext context, HealthLog log) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => _EditHealthLogSheet(log: log),
  );
}

class _EditHealthLogSheet extends ConsumerStatefulWidget {
  const _EditHealthLogSheet({required this.log});

  final HealthLog log;

  @override
  ConsumerState<_EditHealthLogSheet> createState() =>
      _EditHealthLogSheetState();
}

class _EditHealthLogSheetState extends ConsumerState<_EditHealthLogSheet> {
  late DateTime _date;
  late final TextEditingController _weightCtrl;
  late final TextEditingController _waistCtrl;
  late final TextEditingController _bodyFatCtrl;
  int? _energyLevel;
  int? _sleepQuality;
  late final TextEditingController _notesCtrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final log = widget.log;
    _date = log.date;
    _weightCtrl = TextEditingController(
        text: log.weight != null ? log.weight!.toStringAsFixed(1) : '');
    _waistCtrl = TextEditingController(
        text: log.waistCm != null ? log.waistCm!.toStringAsFixed(1) : '');
    _bodyFatCtrl = TextEditingController(
        text: log.bodyFatPct != null ? log.bodyFatPct!.toStringAsFixed(1) : '');
    _energyLevel = log.energyLevel;
    _sleepQuality = log.sleepQuality;
    _notesCtrl = TextEditingController(text: log.notes ?? '');
  }

  @override
  void dispose() {
    _weightCtrl.dispose();
    _waistCtrl.dispose();
    _bodyFatCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  bool get _hasAnyValue =>
      _weightCtrl.text.trim().isNotEmpty ||
      _waistCtrl.text.trim().isNotEmpty ||
      _bodyFatCtrl.text.trim().isNotEmpty ||
      _energyLevel != null ||
      _sleepQuality != null;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    if (!_hasAnyValue) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.atLeastOneField)),
      );
      return;
    }
    setState(() => _saving = true);
    final weight = double.tryParse(_weightCtrl.text.trim());
    final waist = double.tryParse(_waistCtrl.text.trim());
    final bodyFat = double.tryParse(_bodyFatCtrl.text.trim());
    final notes =
        _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim();

    await ref.read(healthNotifierProvider.notifier).updateLog(
          id: widget.log.id,
          date: _date,
          weight: weight,
          waistCm: waist,
          bodyFatPct: bodyFat,
          energyLevel: _energyLevel,
          sleepQuality: _sleepQuality,
          notes: notes,
        );

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.healthLogSaved)),
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
                  AppStrings.editHealthLog,
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
                      '${_date.year}/${_date.month.toString().padLeft(2, '0')}/${_date.day.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _weightCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: AppStrings.weightLabel,
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
                labelText: AppStrings.waistLabel,
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
                labelText: AppStrings.bodyFatLabel,
                border: OutlineInputBorder(),
                suffixText: AppStrings.bodyFatUnit,
              ),
            ),
            const SizedBox(height: 16),
            _ScoreRow(
              label: AppStrings.energyLabel,
              icon: Icons.bolt_outlined,
              value: _energyLevel,
              onChanged: (v) => setState(() => _energyLevel = v),
            ),
            const SizedBox(height: 12),
            _ScoreRow(
              label: AppStrings.sleepLabel,
              icon: Icons.bedtime_outlined,
              value: _sleepQuality,
              onChanged: (v) => setState(() => _sleepQuality = v),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notesCtrl,
              maxLines: 3,
              minLines: 2,
              decoration: const InputDecoration(
                labelText: AppStrings.healthNotesLabel,
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
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

class _ScoreRow extends StatelessWidget {
  const _ScoreRow({
    required this.label,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: colors.primary),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w500)),
            const Spacer(),
            if (value != null)
              Text('$value/۱۰',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: colors.primary)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            for (int i = 1; i <= 10; i++)
              Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(value == i ? null : i),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    height: 28,
                    decoration: BoxDecoration(
                      color: value != null && i <= value!
                          ? colors.primary
                          : colors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$i',
                      style: TextStyle(
                        fontSize: 10,
                        color: value != null && i <= value!
                            ? colors.onPrimary
                            : colors.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
