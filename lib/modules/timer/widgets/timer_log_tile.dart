import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../shared/database/database.dart';
import '../providers/timer_providers.dart';

class TimerLogTile extends StatelessWidget {
  const TimerLogTile({super.key, required this.log});

  final TimeLog log;

  static const _icons = <String, IconData>{
    'deep_work': Icons.psychology_outlined,
    'shallow_work': Icons.work_outline,
    'learning': Icons.menu_book_outlined,
    'exercise': Icons.fitness_center_outlined,
    'personal': Icons.person_outline,
    'family': Icons.people_outline,
    'recovery': Icons.bedtime_outlined,
    'misc': Icons.more_horiz,
  };

  String _formatDuration(int seconds) {
    final d = Duration(seconds: seconds);
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    if (h > 0) return '$h ساعت $m دقیقه';
    if (m > 0) return '$m دقیقه $s ثانیه';
    return '$s ثانیه';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final cat = TimerCategory.fromKey(log.category);
    final timeStr = DateFormat('HH:mm').format(log.startedAt);

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.secondaryContainer,
        ),
        child: Icon(
          _icons[log.category] ?? Icons.circle,
          color: colors.onSecondaryContainer,
          size: 20,
        ),
      ),
      title: Text(cat.label),
      subtitle: Text(timeStr),
      trailing: Text(
        _formatDuration(log.durationSeconds),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colors.primary,
            ),
      ),
    );
  }
}
