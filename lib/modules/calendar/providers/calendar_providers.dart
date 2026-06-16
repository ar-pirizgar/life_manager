import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/database/database.dart';
import '../../tasks/providers/task_providers.dart';

/// بازه تاریخی برای کوئری تسک‌های تقویم
class DateRange {
  const DateRange(this.start, this.end);
  final DateTime start;
  final DateTime end;

  @override
  bool operator ==(Object other) =>
      other is DateRange && other.start == start && other.end == end;

  @override
  int get hashCode => Object.hash(start, end);
}

/// تسک‌های یک بازه تاریخی (هفته یا ماه) برای نمایش در تقویم
final calendarTasksProvider =
    StreamProvider.family<List<Task>, DateRange>((ref, range) {
  final repo = ref.watch(taskRepositoryProvider);
  return repo.watchTasksForDateRange(range.start, range.end);
});
