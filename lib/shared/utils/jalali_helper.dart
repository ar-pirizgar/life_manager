import 'package:flutter/material.dart';
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

  /// نام ماه و سال: «خرداد ۱۴۰۵»
  static String monthYear(DateTime date) {
    final j = Jalali.fromDateTime(date);
    return '${_months[j.month - 1]} ${_toFa(j.year)}';
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

  /// نمایش تقویم شمسی برای انتخاب تاریخ
  static Future<DateTime?> pickDate(
    BuildContext context, {
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final initial = Jalali.fromDateTime(initialDate);
    final first = firstDate != null ? Jalali.fromDateTime(firstDate) : Jalali(1380, 1, 1);
    final last = lastDate != null ? Jalali.fromDateTime(lastDate) : Jalali(1420, 12, 29);

    int selYear = initial.year;
    int selMonth = initial.month;
    int selDay = initial.day;

    final result = await showDialog<DateTime>(
      context: context,
      builder: (ctx) => _JalaliPickerDialog(
        initialYear: selYear,
        initialMonth: selMonth,
        initialDay: selDay,
        firstYear: first.year,
        lastYear: last.year,
        months: _months,
      ),
    );
    return result;
  }
}

class _JalaliPickerDialog extends StatefulWidget {
  const _JalaliPickerDialog({
    required this.initialYear,
    required this.initialMonth,
    required this.initialDay,
    required this.firstYear,
    required this.lastYear,
    required this.months,
  });

  final int initialYear, initialMonth, initialDay;
  final int firstYear, lastYear;
  final List<String> months;

  @override
  State<_JalaliPickerDialog> createState() => _JalaliPickerDialogState();
}

class _JalaliPickerDialogState extends State<_JalaliPickerDialog> {
  late int _year, _month, _day;

  @override
  void initState() {
    super.initState();
    _year = widget.initialYear;
    _month = widget.initialMonth;
    _day = widget.initialDay;
  }

  int get _daysInMonth {
    final j = Jalali(_year, _month, 1);
    return j.monthLength;
  }

  void _clampDay() {
    if (_day > _daysInMonth) _day = _daysInMonth;
  }

  @override
  Widget build(BuildContext context) {
    final years = List.generate(widget.lastYear - widget.firstYear + 1,
        (i) => widget.firstYear + i);
    final days = List.generate(_daysInMonth, (i) => i + 1);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: const Text('انتخاب تاریخ'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // سال
            Expanded(
              flex: 3,
              child: DropdownButton<int>(
                value: _year,
                items: years
                    .map((y) => DropdownMenuItem(
                          value: y,
                          child: Text(JalaliHelper.toFa(y)),
                        ))
                    .toList(),
                onChanged: (v) => setState(() {
                  _year = v!;
                  _clampDay();
                }),
              ),
            ),
            const SizedBox(width: 8),
            // ماه
            Expanded(
              flex: 3,
              child: DropdownButton<int>(
                value: _month,
                items: List.generate(12, (i) => i + 1)
                    .map((m) => DropdownMenuItem(
                          value: m,
                          child: Text(widget.months[m - 1]),
                        ))
                    .toList(),
                onChanged: (v) => setState(() {
                  _month = v!;
                  _clampDay();
                }),
              ),
            ),
            const SizedBox(width: 8),
            // روز
            Expanded(
              flex: 2,
              child: DropdownButton<int>(
                value: _day,
                items: days
                    .map((d) => DropdownMenuItem(
                          value: d,
                          child: Text(JalaliHelper.toFa(d)),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _day = v!),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('لغو'),
          ),
          FilledButton(
            onPressed: () {
              final jalali = Jalali(_year, _month, _day);
              Navigator.pop(context, jalali.toDateTime());
            },
            child: const Text('تأیید'),
          ),
        ],
      ),
    );
  }
}
