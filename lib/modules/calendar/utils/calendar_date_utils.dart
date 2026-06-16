import 'package:shamsi_date/shamsi_date.dart';

/// محاسبات تاریخ برای تقویم — تولید بازه‌های هفته/ماه برای هر دو
/// تقویم میلادی و شمسی. خروجی همیشه `DateTime` میلادی است؛ فقط
/// نحوه‌ی چیدمان روزها بر اساس تقویم انتخابی فرق می‌کند.
class CalendarDateUtils {
  CalendarDateUtils._();

  static DateTime _atMidnight(DateTime d) => DateTime(d.year, d.month, d.day);

  /// شروع هفته‌ی حاوی [date].
  /// میلادی: یکشنبه — شمسی: شنبه
  static DateTime startOfWeek(DateTime date, {required bool isJalali}) {
    final day = _atMidnight(date);
    if (isJalali) {
      final j = Jalali.fromDateTime(day);
      return j.addDays(-(j.weekDay - 1)).toDateTime();
    }
    final offset = day.weekday % 7; // یکشنبه=7 -> 0 افست
    return day.subtract(Duration(days: offset));
  }

  /// ۷ روز هفته‌ای که [date] در آن قرار دارد
  static List<DateTime> daysInWeek(DateTime date, {required bool isJalali}) {
    final start = startOfWeek(date, isJalali: isJalali);
    return List.generate(7, (i) => start.add(Duration(days: i)));
  }

  /// گرید کامل ماه (شامل روزهای اضافه از ماه قبل/بعد برای تکمیل هفته‌ها)
  static List<DateTime> daysInMonthGrid(DateTime date,
      {required bool isJalali}) {
    if (isJalali) {
      final j = Jalali.fromDateTime(_atMidnight(date));
      final firstOfMonth = j.withDay(1);
      final gridStart =
          firstOfMonth.addDays(-(firstOfMonth.weekDay - 1));
      final totalDays = ((firstOfMonth.weekDay - 1) + j.monthLength + 6) ~/
          7 *
          7;
      return List.generate(
          totalDays, (i) => gridStart.addDays(i).toDateTime());
    }
    final firstOfMonth = DateTime(date.year, date.month, 1);
    final gridStart = startOfWeek(firstOfMonth, isJalali: false);
    final daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    final leading = firstOfMonth.difference(gridStart).inDays;
    final totalDays = ((leading + daysInMonth + 6) ~/ 7) * 7;
    return List.generate(
        totalDays, (i) => gridStart.add(Duration(days: i)));
  }

  /// انتقال [date] به ماه قبل/بعد ([delta] = -1 یا +1)، با حفظ روز اول ماه
  static DateTime shiftMonth(DateTime date, int delta,
      {required bool isJalali}) {
    if (isJalali) {
      final j = Jalali.fromDateTime(_atMidnight(date));
      var year = j.year;
      var month = j.month + delta;
      if (month < 1) {
        month += 12;
        year -= 1;
      } else if (month > 12) {
        month -= 12;
        year += 1;
      }
      return Jalali(year, month, 1).toDateTime();
    }
    return DateTime(date.year, date.month + delta, 1);
  }

  /// آیا [date] در همان ماه (میلادی یا شمسی) [reference] است
  static bool isSameMonth(DateTime date, DateTime reference,
      {required bool isJalali}) {
    if (isJalali) {
      final a = Jalali.fromDateTime(_atMidnight(date));
      final b = Jalali.fromDateTime(_atMidnight(reference));
      return a.year == b.year && a.month == b.month;
    }
    return date.year == reference.year && date.month == reference.month;
  }

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// تعداد dot بر اساس تعداد تسک‌ها: ۰ → ۰، ۱-۲ → ۱، ۳-۴ → ۲، ۵+ → ۳
  static int dotCountFor(int taskCount) {
    if (taskCount == 0) return 0;
    if (taskCount <= 2) return 1;
    if (taskCount <= 4) return 2;
    return 3;
  }
}
