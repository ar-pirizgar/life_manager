import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/database/database.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/goal_providers.dart';

Future<void> showEditShortGoalSheet(BuildContext context, ShortGoal goal) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _EditShortGoalSheet(goal: goal),
    );

class _EditShortGoalSheet extends ConsumerStatefulWidget {
  const _EditShortGoalSheet({required this.goal});
  final ShortGoal goal;

  @override
  ConsumerState<_EditShortGoalSheet> createState() =>
      _EditShortGoalSheetState();
}

class _EditShortGoalSheetState
    extends ConsumerState<_EditShortGoalSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  DateTime? _deadline;
  late String _status;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.goal.title);
    _deadline = widget.goal.deadline;
    _status = widget.goal.status;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDeadline() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _deadline ?? DateTime.now().add(const Duration(days: 14)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) setState(() => _deadline = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final repo = ref.read(goalRepositoryProvider);
      await repo.updateShortGoal(
        widget.goal.copyWith(
          title: _titleCtrl.text.trim(),
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
            Text('ویرایش هدف کوتاه‌مدت',
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
                ButtonSegment(value: 'completed', label: Text('تکمیل')),
              ],
              selected: {_status},
              onSelectionChanged: (s) =>
                  setState(() => _status = s.first),
            ),
            const SizedBox(height: 4),
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
