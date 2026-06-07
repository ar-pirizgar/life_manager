import 'package:shamsi_date/shamsi_date.dart';

/// کمک‌کننده تاریخ شمسی.
/// تبدیل و فرمت‌بندی تاریخ‌های میلادی به شمسی برای نمایش.
class JalaliHelper {
  JalaliHelper._();

  static const List<String> _months = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];

  static const List<String> _weekDays = [
    'شنبه',
    'یکشنبه',
    'دوشنبه',
    'سه‌شنبه',
    'چهارشنبه',
    'پنجشنبه',
    'جمعه',
  ];

  /// تبدیل به رشته کامل: «۱۵ خرداد ۱۴۰۵»
  static String full(DateTime date) {
    final j = Jalali.fromDateTime(date);
    return '${_toFa(j.day)} ${_months[j.month - 1]} ${_toFa(j.year)}';
  }

  /// تبدیل به رشته کوتاه: «۱۴۰۵/۰۳/۱۵»
  static String short(DateTime date) {
    final j = Jalali.fromDateTime(date);
    final m = j.month.toString().padLeft(2, '0');
    final d = j.day.toString().padLeft(2, '0');
    return _toFa('${j.year}/$m/$d');
  }

  /// نام روز هفته: «دوشنبه»
  static String weekDay(DateTime date) {
    final j = Jalali.fromDateTime(date);
    // در تقویم شمسی، شنبه اولین روز هفته است
    final idx = (j.weekDay - 1) % 7;
    return _weekDays[idx];
  }

  /// عنوان نسبی هوشمند: امروز / فردا / دیروز / تاریخ کامل
  static String relative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    final diff = target.difference(today).inDays;

    if (diff == 0) return 'امروز';
    if (diff == 1) return 'فردا';
    if (diff == -1) return 'دیروز';
    return full(date);
  }

  /// تبدیل ارقام انگلیسی به فارسی
  static String _toFa(Object input) {
    const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    var s = input.toString();
    for (var i = 0; i < en.length; i++) {
      s = s.replaceAll(en[i], fa[i]);
    }
    return s;
  }

  /// تبدیل عمومی اعداد به فارسی (برای استفاده در کل اپ)
  static String toFa(Object input) => _toFa(input);
}
