import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../providers/task_providers.dart';

/// شیت ثبت سریع تسک.
/// از صفحه اصلی باز می‌شود؛ هدف: ثبت در کمترین زمان ممکن.
class QuickAddTaskSheet extends ConsumerStatefulWidget {
  const QuickAddTaskSheet({super.key});

  /// نمایش به‌صورت bottom sheet
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const QuickAddTaskSheet(),
    );
  }

  @override
  ConsumerState<QuickAddTaskSheet> createState() => _QuickAddTaskSheetState();
}

class _QuickAddTaskSheetState extends ConsumerState<QuickAddTaskSheet> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    // فوکوس خودکار روی فیلد متن برای ورود سریع
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool get _isToday {
    final now = DateTime.now();
    return _selectedDate.year == now.year &&
        _selectedDate.month == now.month &&
        _selectedDate.day == now.day;
  }

  bool get _isTomorrow {
    final t = DateTime.now().add(const Duration(days: 1));
    return _selectedDate.year == t.year &&
        _selectedDate.month == t.month &&
        _selectedDate.day == t.day;
  }

  Future<void> _pickFromCalendar() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
    );
    if (picked != null) {
      setState(() => _selectedDate =
          DateTime(picked.year, picked.month, picked.day));
    }
  }

  Future<void> _save() async {
    final title = _controller.text.trim();
    if (title.isEmpty) return;

    await ref.read(taskRepositoryProvider).addTask(
          title: title,
          dueDate: _selectedDate,
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
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // دستگیره بالای شیت
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
            Text('تسک جدید', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _save(),
              decoration: const InputDecoration(
                hintText: 'چه کاری باید انجام بشه؟',
              ),
            ),
            const SizedBox(height: 16),
            // انتخاب سریع تاریخ
            Row(
              children: [
                _DateChip(
                  label: 'امروز',
                  selected: _isToday,
                  onTap: () {
                    final now = DateTime.now();
                    setState(() => _selectedDate =
                        DateTime(now.year, now.month, now.day));
                  },
                ),
                const SizedBox(width: 8),
                _DateChip(
                  label: 'فردا',
                  selected: _isTomorrow,
                  onTap: () {
                    final t = DateTime.now().add(const Duration(days: 1));
                    setState(() =>
                        _selectedDate = DateTime(t.year, t.month, t.day));
                  },
                ),
                const SizedBox(width: 8),
                _DateChip(
                  label: _isToday || _isTomorrow
                      ? 'تقویم'
                      : _jalaliShort(_selectedDate),
                  selected: !_isToday && !_isTomorrow,
                  icon: Icons.calendar_today,
                  onTap: _pickFromCalendar,
                ),
              ],
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _save,
              child: const Text('ذخیره'),
            ),
          ],
        ),
      ),
    );
  }

  String _jalaliShort(DateTime date) {
    final j = Jalali.fromDateTime(date);
    const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    String toFa(int n) {
      return n
          .toString()
          .split('')
          .map((c) => fa[int.parse(c)])
          .join();
    }

    return '${toFa(j.month)}/${toFa(j.day)}';
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? theme.colorScheme.primary
                : theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: selected
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  color: selected
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
