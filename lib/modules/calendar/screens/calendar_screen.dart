import 'package:flutter/material.dart';

import '../../../shared/constants/app_strings.dart';
import '../../../shared/utils/jalali_helper.dart';
import '../utils/calendar_date_utils.dart';
import '../widgets/calendar_day_tasks.dart';
import '../widgets/calendar_month_view.dart';
import '../widgets/calendar_week_view.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool _isWeekly = true;
  bool _isJalali = false;
  late DateTime _anchorDate;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _anchorDate = DateTime(now.year, now.month, now.day);
    _selectedDate = _anchorDate;
  }

  void _goPrevious() {
    setState(() {
      _anchorDate = _isWeekly
          ? _anchorDate.subtract(const Duration(days: 7))
          : CalendarDateUtils.shiftMonth(_anchorDate, -1, isJalali: _isJalali);
    });
  }

  void _goNext() {
    setState(() {
      _anchorDate = _isWeekly
          ? _anchorDate.add(const Duration(days: 7))
          : CalendarDateUtils.shiftMonth(_anchorDate, 1, isJalali: _isJalali);
    });
  }

  String get _headerLabel {
    if (_isWeekly) {
      final days =
          CalendarDateUtils.daysInWeek(_anchorDate, isJalali: _isJalali);
      return _isJalali
          ? '${JalaliHelper.full(days.first)} – ${JalaliHelper.full(days.last)}'
          : '${_gregorianShort(days.first)} – ${_gregorianShort(days.last)}';
    }
    return _isJalali
        ? JalaliHelper.monthYear(_anchorDate)
        : _gregorianMonthYear(_anchorDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.calendarTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment(
                          value: true, label: Text(AppStrings.calendarWeekly)),
                      ButtonSegment(
                          value: false,
                          label: Text(AppStrings.calendarMonthly)),
                    ],
                    selected: {_isWeekly},
                    onSelectionChanged: (s) =>
                        setState(() => _isWeekly = s.first),
                  ),
                ),
                const SizedBox(width: 8),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(
                        value: false, label: Text(AppStrings.calendarGregorian)),
                    ButtonSegment(
                        value: true, label: Text(AppStrings.calendarJalali)),
                  ],
                  selected: {_isJalali},
                  onSelectionChanged: (s) =>
                      setState(() => _isJalali = s.first),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _goPrevious,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      _headerLabel,
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _goNext,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _isWeekly
                ? CalendarWeekView(
                    anchorDate: _anchorDate,
                    selectedDate: _selectedDate,
                    isJalali: _isJalali,
                    onDaySelected: (d) => setState(() => _selectedDate = d),
                  )
                : CalendarMonthView(
                    anchorDate: _anchorDate,
                    selectedDate: _selectedDate,
                    isJalali: _isJalali,
                    onDaySelected: (d) => setState(() => _selectedDate = d),
                  ),
          ),
          const Divider(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: CalendarDayTasks(day: _selectedDate),
            ),
          ),
        ],
      ),
    );
  }
}

String _gregorianShort(DateTime d) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return '${d.day} ${months[d.month - 1]}';
}

String _gregorianMonthYear(DateTime d) {
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  return '${months[d.month - 1]} ${d.year}';
}
