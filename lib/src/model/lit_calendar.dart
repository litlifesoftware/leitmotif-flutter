/// A `Leitmotif` model class describing a date in a calendar calendric.
class LitCalendarDate {
  final DateTime date;
  final bool thisMonth;
  final bool prevMonth;
  final bool nextMonth;

  /// Creates a `LitCalendarDate`.
  const LitCalendarDate({
    required this.date,
    this.thisMonth = false,
    this.prevMonth = false,
    this.nextMonth = false,
  });
}

/// Days of Week on which a calendar week can start on.
enum FirstDayOfTheWeek { sunday, monday }
