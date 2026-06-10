import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/database/database.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../providers/task_providers.dart';

Future<void> showEditTaskSheet(BuildContext context, Task task) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _EditTaskSheet(task: task),
    );

class _EditTaskSheet extends ConsumerStatefulWidget {
  const _EditTaskSheet({required this.task});
  final Task task;

  @override
  ConsumerState<_EditTaskSheet> createState() => _EditTaskSheetState();
}

class _EditTaskSheetState extends ConsumerState<_EditTaskSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;
  late DateTime _dueDate;
  late String _priority;
  late String _status;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.task.title);
    _descCtrl =
        TextEditingController(text: widget.task.description ?? '');
    _dueDate = widget.task.dueDate;
    _priority = widget.task.priority;
    _status = widget.task.status;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
    );
    if (picked != null) {
      setState(() =>
          _dueDate = DateTime(picked.year, picked.month, picked.day));
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final repo = ref.read(taskRepositoryProvider);
      final desc = _descCtrl.text.trim();
      await repo.updateTask(
        widget.task.copyWith(
          title: _titleCtrl.text.trim(),
          description: Value(desc.isEmpty ? null : desc),
          dueDate: _dueDate,
          priority: _priority,
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
            Text('ویرایش تسک',
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
            const SizedBox(height: 12),
            // اولویت
            const _SectionLabel('اولویت'),
            const SizedBox(height: 6),
            Row(
              children: [
                _PriorityChip(
                  label: 'بالا',
                  value: 'high',
                  color: const Color(0xFFEF4444),
                  selected: _priority == 'high',
                  onTap: () => setState(() => _priority = 'high'),
                ),
                const SizedBox(width: 6),
                _PriorityChip(
                  label: 'متوسط',
                  value: 'medium',
                  color: const Color(0xFFF97316),
                  selected: _priority == 'medium',
                  onTap: () => setState(() => _priority = 'medium'),
                ),
                const SizedBox(width: 6),
                _PriorityChip(
                  label: 'پایین',
                  value: 'low',
                  color: const Color(0xFF60A5FA),
                  selected: _priority == 'low',
                  onTap: () => setState(() => _priority = 'low'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // وضعیت
            const _SectionLabel('وضعیت'),
            const SizedBox(height: 6),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'pending', label: Text('در انتظار')),
                ButtonSegment(value: 'done', label: Text('انجام شده')),
                ButtonSegment(value: 'cancelled', label: Text('لغو')),
              ],
              selected: {_status},
              onSelectionChanged: (s) =>
                  setState(() => _status = s.first),
            ),
            const SizedBox(height: 4),
            // تاریخ
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.calendar_today_outlined,
                  color: colors.primary),
              title: Text(JalaliHelper.relative(_dueDate)),
              trailing: TextButton(
                onPressed: _pickDate,
                child: const Text('تغییر'),
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  const _PriorityChip({
    required this.label,
    required this.value,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String value;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? color : color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : color,
          ),
        ),
      ),
    );
  }
}
