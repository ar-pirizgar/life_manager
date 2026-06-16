import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';
import '../providers/habit_providers.dart';

Future<void> showAddHabitSheet(BuildContext context, {Habit? habit}) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _AddHabitSheet(habit: habit),
    );

class _AddHabitSheet extends ConsumerStatefulWidget {
  const _AddHabitSheet({this.habit});

  final Habit? habit;

  @override
  ConsumerState<_AddHabitSheet> createState() => _AddHabitSheetState();
}

class _AddHabitSheetState extends ConsumerState<_AddHabitSheet> {
  static const _emojis = [
    '✅', '🏃', '📚', '💧', '🧘', '🥗',
    '💊', '😴', '✍️', '🎯', '🧹', '🎸',
  ];

  final _titleCtrl = TextEditingController();
  late String _emoji;
  late HabitTimeOfDay _timeOfDay;
  bool _saving = false;

  bool get _isEdit => widget.habit != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      _titleCtrl.text = widget.habit!.title;
      _emoji = widget.habit!.emoji;
      _timeOfDay = HabitTimeOfDay.fromKey(widget.habit!.timeOfDay);
    } else {
      _emoji = '✅';
      _timeOfDay = HabitTimeOfDay.any;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_titleCtrl.text.trim().isEmpty) return;
    setState(() => _saving = true);
    try {
      final db = ref.read(databaseProvider);
      if (_isEdit) {
        await db.updateHabit(
          widget.habit!.id,
          title: _titleCtrl.text.trim(),
          emoji: _emoji,
          timeOfDay: _timeOfDay.key,
        );
      } else {
        await db.into(db.habits).insert(
              HabitsCompanion(
                id: Value(const Uuid().v4()),
                title: Value(_titleCtrl.text.trim()),
                emoji: Value(_emoji),
                timeOfDay: Value(_timeOfDay.key),
              ),
            );
      }
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final insets = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, insets + 16),
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
          Text(
            _isEdit ? AppStrings.editHabit : AppStrings.newHabit,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titleCtrl,
            autofocus: !_isEdit,
            decoration:
                const InputDecoration(labelText: AppStrings.habitTitleHint),
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.habitIcon,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _emojis.map((e) {
              final selected = e == _emoji;
              return GestureDetector(
                onTap: () => setState(() => _emoji = e),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected
                        ? colors.primaryContainer
                        : colors.surfaceContainerHighest,
                    border: selected
                        ? Border.all(color: colors.primary, width: 2)
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(e, style: const TextStyle(fontSize: 20)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.habitTimeOfDay,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          SegmentedButton<HabitTimeOfDay>(
            segments: HabitTimeOfDay.values
                .map((t) => ButtonSegment(value: t, label: Text(t.label)))
                .toList(),
            selected: {_timeOfDay},
            onSelectionChanged: (s) =>
                setState(() => _timeOfDay = s.first),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(AppStrings.save),
          ),
        ],
      ),
    );
  }
}
