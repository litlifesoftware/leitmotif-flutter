import 'package:leitmotif/models.dart';

class LitCalendarController {
  /// Stores the total number of days each month has.
  ///
  /// Access the individual months using its index (January = `0`).
  final List<int> daysPerMonth = [
    // January
    31,
    // February
    28,
    // March
    31,
    // April
    30,
    // May
    31,
    // June
    30,
    // July
    31,
    // Aug
    31,
    // Sep
    30,
    // October
    31,
    // November
    30,
    // December
    31,
  ];

  /// Evaluates whether the provided [year] is a leap year.
  bool checkLeapYear(int year) {
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        if (year % 400 == 0) return true;
        return false;
      }
      return true;
    }
    return false;
  }

  bool checkLeapYearMonth(int year, int month) {
    return checkLeapYear(year) && month == DateTime.february;
  }

  /// Gets the total days of the provided calendar month.
  ///
  /// Accounts for a leap year if the month `February` is requested by
  /// increasing the default count by one.
  int getTotalDaysOfCalendarMonth(int year, int month) {
    int days = daysPerMonth[month - 1];

    return checkLeapYearMonth(year, month) ? (days + 1) : days;
  }

  /// Returns a `List` of [LitCalendarDate] objects to feature on a calendar
  /// view (adjusted either to a 5 x 7 or a 6 x 7 grid) based on the provided
  /// month and year.
  ///
  /// If the first day of the calendar month is not starting on the first day
  /// of the week, days of the previous month are filling the empty space.
  ///
  /// Specify to invert the first day of the week by providing a
  /// [firstDayOfWeek] value.
  List<LitCalendarDate> getCalendarDates(
    int month,
    int year, {
    FirstDayOfTheWeek firstDayOfWeek = FirstDayOfTheWeek.sunday,
  }) {
    List<LitCalendarDate> calendar = [];

    // Temporarily stores the previous/next year.
    int otherYear;

    // Temporarily stores the previous/next month.
    int otherMonth;

    /// States how many days are left to fill the grid view.
    int leftDays;

    /// States how many days are included in the provided calendaric period.
    int totalDays = getTotalDaysOfCalendarMonth(year, month);

    /// States whether the inverted sequence is applied.
    ///
    /// The week should start using the last day of the week (`Sunday`).
    bool invertSeq = firstDayOfWeek == FirstDayOfTheWeek.sunday;

    /// States whether the international `ISO 8601` specification is applied.
    ///
    /// The week should start using the first day of the week (`Monday`).
    bool internSeq = firstDayOfWeek == FirstDayOfTheWeek.monday;

    // Add the provided month's days to the list.
    for (int i = 0; i < totalDays; i++) {
      calendar.add(
        LitCalendarDate(
          date: DateTime(year, month, i + 1),
          thisMonth: true,
        ),
      );
    }

    // Fill the empty elements of the grid using the last days of the
    // previous month (if the first day of the provided month does not start
    // on the first day of the week).
    if ((invertSeq && calendar.first.date.weekday != DateTime.sunday) ||
        (internSeq && calendar.first.date.weekday != DateTime.monday)) {
      // December of the last year is prior to the month `January`.
      if (month == DateTime.january) {
        otherMonth = DateTime.december;
        otherYear = year - 1;
        // Else the prior month is in the same year.
      } else {
        otherMonth = month - 1;
        otherYear = year;
      }

      totalDays = getTotalDaysOfCalendarMonth(otherYear, otherMonth);

      leftDays =
          totalDays - calendar.first.date.weekday + ((invertSeq) ? 0 : 1);

      for (int i = totalDays; i > leftDays; i--) {
        calendar.insert(
          0,
          LitCalendarDate(
            date: DateTime(otherYear, otherMonth, i),
            prevMonth: true,
          ),
        );
      }
    }

    // Fill the empty elements of the grid using the first days of the next
    // month (if the last day of the provided month does not end on the last
    // day of the week).
    if ((invertSeq && calendar.last.date.weekday != DateTime.saturday) ||
        (internSeq && calendar.last.date.weekday != DateTime.sunday)) {
      // `January` of the next year is follows the month `December`.
      if (month == DateTime.december) {
        otherMonth = DateTime.january;
        otherYear = year + 1;
        // Else the next month is in the same year.
      } else {
        otherMonth = month + 1;
        otherYear = year;
      }

      totalDays = getTotalDaysOfCalendarMonth(otherYear, otherMonth);

      leftDays = 7 - calendar.last.date.weekday - ((invertSeq) ? 1 : 0);
      if (leftDays == -1) leftDays = 6;

      for (int i = 0; i < leftDays; i++) {
        calendar.add(
          LitCalendarDate(
            date: DateTime(otherYear, otherMonth, i + 1),
            nextMonth: true,
          ),
        );
      }
    }

    return calendar;
  }
}
