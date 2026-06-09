import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../providers/goal_providers.dart';

class AddShortGoalSheet extends ConsumerStatefulWidget {
  const AddShortGoalSheet({super.key, this.presetLongGoalId});

  final String? presetLongGoalId;

  static Future<void> show(BuildContext context, {String? longGoalId}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddShortGoalSheet(presetLongGoalId: longGoalId),
    );
  }

  @override
  ConsumerState<AddShortGoalSheet> createState() =>
      _AddShortGoalSheetState();
}

class _AddShortGoalSheetState extends ConsumerState<AddShortGoalSheet> {
  final _titleController = TextEditingController();
  final _focusNode = FocusNode();
  DateTime? _deadline;
  String? _selectedLongGoalId;

  @override
  void initState() {
    super.initState();
    _selectedLongGoalId = widget.presetLongGoalId;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _pickDeadline() async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          _deadline ?? DateTime.now().add(const Duration(days: 14)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
    );
    if (picked != null) setState(() => _deadline = picked);
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;
    await ref.read(goalRepositoryProvider).addShortGoal(
          title: title,
          longGoalId: _selectedLongGoalId,
          deadline: _deadline,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final longGoals = ref.watch(allLongGoalsProvider);

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
            Text('هدف کوتاه‌مدت جدید',
                style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              focusNode: _focusNode,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _save(),
              decoration:
                  const InputDecoration(hintText: 'عنوان هدف'),
            ),
            if (widget.presetLongGoalId == null) ...[
              const SizedBox(height: 12),
              longGoals.when(
                data: (goals) {
                  if (goals.isEmpty) return const SizedBox.shrink();
                  return DropdownButtonFormField<String?>(
                    initialValue: _selectedLongGoalId,
                    decoration: InputDecoration(
                      hintText: 'هدف بلندمدت مرتبط (اختیاری)',
                      filled: true,
                      fillColor:
                          theme.colorScheme.surfaceContainerHighest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                    ),
                    items: [
                      const DropdownMenuItem(
                          value: null,
                          child: Text('بدون هدف بلندمدت')),
                      ...goals.map((g) => DropdownMenuItem(
                          value: g.id, child: Text(g.title))),
                    ],
                    onChanged: (v) =>
                        setState(() => _selectedLongGoalId = v),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
            const SizedBox(height: 12),
            _DeadlineRow(
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

class _DeadlineRow extends StatelessWidget {
  const _DeadlineRow({
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
