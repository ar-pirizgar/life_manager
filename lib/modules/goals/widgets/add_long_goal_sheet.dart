import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../providers/goal_providers.dart';

class AddLongGoalSheet extends ConsumerStatefulWidget {
  const AddLongGoalSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddLongGoalSheet(),
    );
  }

  @override
  ConsumerState<AddLongGoalSheet> createState() => _AddLongGoalSheetState();
}

class _AddLongGoalSheetState extends ConsumerState<AddLongGoalSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _focusNode = FocusNode();
  DateTime? _deadline;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _pickDeadline() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _deadline ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) setState(() => _deadline = picked);
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;
    final desc = _descController.text.trim();
    await ref.read(goalRepositoryProvider).addLongGoal(
          title: title,
          description: desc.isEmpty ? null : desc,
          deadline: _deadline,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text('هدف بلندمدت جدید', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              focusNode: _focusNode,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(hintText: 'عنوان هدف'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _save(),
              maxLines: 2,
              decoration: const InputDecoration(
                  hintText: 'توضیحات (اختیاری)'),
            ),
            const SizedBox(height: 12),
            _DeadlinePicker(
              deadline: _deadline,
              onPick: _pickDeadline,
              onClear: () => setState(() => _deadline = null),
            ),
            const SizedBox(height: 20),
            FilledButton(onPressed: _save, child: const Text('ذخیره')),
          ],
        ),
      ),
    );
  }
}

class _DeadlinePicker extends StatelessWidget {
  const _DeadlinePicker({
    required this.deadline,
    required this.onPick,
    required this.onClear,
  });

  final DateTime? deadline;
  final VoidCallback onPick;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onPick,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined,
                size: 18, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 8),
            Text(
              deadline != null ? _jalali(deadline!) : 'ددلاین (اختیاری)',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: deadline != null
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (deadline != null) ...[
              const Spacer(),
              GestureDetector(
                onTap: onClear,
                child: Icon(Icons.close,
                    size: 16, color: theme.colorScheme.outline),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _jalali(DateTime dt) {
    final j = Jalali.fromDateTime(dt);
    const months = [
      'فروردین', 'اردیبهشت', 'خرداد', 'تیر', 'مرداد', 'شهریور',
      'مهر', 'آبان', 'آذر', 'دی', 'بهمن', 'اسفند'
    ];
    return '${j.day} ${months[j.month - 1]} ${j.year}';
  }
}
