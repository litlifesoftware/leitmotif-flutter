import 'dart:ui';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CalendarController {
  //DateTime selectedDate;
  DateTime templateDate;
  final List<DateTime> derivateDates = [];

  CalendarController() {
    init();
  }

  void init() {
    templateDate = DateTime.now();
    _setDerivateDates(templateDate);
  }

  final List<String> weekdays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  final List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  /// Return a [List] of abbreviated weekday labels.
  List<String> get abbreviatedWeekdays {
    return weekdays.map((day) => day.substring(0, 3).toUpperCase()).toList();
  }

  void selectMonth(int month) {
    templateDate = DateTime(templateDate.year, month + 1, 0);
    _setDerivateDates(templateDate);
  }

  void selectYear(int year) {
    templateDate = DateTime(year, templateDate.month + 1, 0);
    _setDerivateDates(templateDate);
  }

  /// Decrease the [templateDate] [DateTime] by one month.
  void decreaseByMonth() {
    templateDate = DateTime(templateDate.year, templateDate.month, 0);
    _setDerivateDates(templateDate);
  }

  /// Increase the [templateDate] [DateTime] by one month.
  void increaseByMonth() {
    templateDate = DateTime(templateDate.year, templateDate.month + 2, 0);
    _setDerivateDates(templateDate);
  }

  /// Decrease the [templateDate] [DateTime] by one year.
  void decreaseByYear() {
    templateDate = DateTime(templateDate.year - 1, templateDate.month + 1, 0);
    _setDerivateDates(templateDate);
  }

  /// Increase the [templateDate] [DateTime] by one year.
  void increaseByYear() {
    templateDate = DateTime(templateDate.year + 1, templateDate.month + 1, 0);
    _setDerivateDates(templateDate);
  }

  void _setDerivateDates(DateTime referencedDate) {
    derivateDates.clear();
    final DateTime cleanedDate =
        DateTime(referencedDate.year, referencedDate.month, 0);
    int previousDay = 0;

    /// If the weekday is earlier than
    /// sunday (7).
    if (cleanedDate.weekday < 7) {
      /// Copy the weekday value to the [prevDay] counter.
      previousDay = cleanedDate.weekday;

      for (int i = 1; i <= previousDay; i++) {
        derivateDates
            .add(cleanedDate.subtract(Duration(days: previousDay - i)));
      }
    }
    for (int i = 0; i < (42 - previousDay); i++) {
      derivateDates.add(cleanedDate.add(Duration(days: i + 1)));
    }
  }
}
