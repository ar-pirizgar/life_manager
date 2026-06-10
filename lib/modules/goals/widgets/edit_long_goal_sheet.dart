import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/database/database.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/goal_providers.dart';

Future<void> showEditLongGoalSheet(BuildContext context, LongGoal goal) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _EditLongGoalSheet(goal: goal),
    );

class _EditLongGoalSheet extends ConsumerStatefulWidget {
  const _EditLongGoalSheet({required this.goal});
  final LongGoal goal;

  @override
  ConsumerState<_EditLongGoalSheet> createState() =>
      _EditLongGoalSheetState();
}

class _EditLongGoalSheetState extends ConsumerState<_EditLongGoalSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;
  DateTime? _deadline;
  late String _status;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.goal.title);
    _descCtrl =
        TextEditingController(text: widget.goal.description ?? '');
    _deadline = widget.goal.deadline;
    _status = widget.goal.status;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDeadline() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _deadline ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (picked != null) setState(() => _deadline = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final repo = ref.read(goalRepositoryProvider);
      final desc = _descCtrl.text.trim();
      await repo.updateLongGoal(
        widget.goal.copyWith(
          title: _titleCtrl.text.trim(),
          description: Value(desc.isEmpty ? null : desc),
          deadline: Value(_deadline),
          status: _status,
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
            Text('ویرایش هدف بلندمدت',
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
              controller: _descCtrl,
              maxLines: 3,
              minLines: 1,
              decoration:
                  const InputDecoration(labelText: 'توضیحات (اختیاری)'),
            ),
            const SizedBox(height: 4),
            // وضعیت
            const SizedBox(height: 8),
            Text(
              'وضعیت',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 6),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'active', label: Text('فعال')),
                ButtonSegment(value: 'paused', label: Text('متوقف')),
                ButtonSegment(value: 'completed', label: Text('تکمیل')),
              ],
              selected: {_status},
              onSelectionChanged: (s) =>
                  setState(() => _status = s.first),
            ),
            const SizedBox(height: 4),
            // مهلت
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading:
                  Icon(Icons.event_outlined, color: colors.primary),
              title: Text(_deadline == null
                  ? 'مهلت (اختیاری)'
                  : JalaliHelper.full(_deadline!)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_deadline != null)
                    IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () => setState(() => _deadline = null),
                    ),
                  TextButton(
                    onPressed: _pickDeadline,
                    child:
                        Text(_deadline == null ? 'انتخاب' : 'تغییر'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
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
