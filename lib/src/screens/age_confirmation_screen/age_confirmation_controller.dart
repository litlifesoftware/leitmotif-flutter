import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A controller class to handle functionality required on the [AgeConfirmationScreen].
///
/// Among others the calendar view used on the above screen widget will depend on
/// methods and data defined in this class as part of solving related problems
/// concerning [DateTime] problems.
class AgeConfirmationController {
  /// The age requirement which will determine whether or not
  /// the [selectedDate] is valid.
  final int requiredAge;

  /// Creates an [AgeConfirmationController].
  ///
  /// Pass a [requiredAge] value.
  AgeConfirmationController({
    required this.requiredAge,
  }) {
    // init();
  }

  // /// Initializes the [AgeConfirmationController].
  // ///
  // /// Creates the derivate dates using the first day of birth which enables the
  // /// user to pass the required age. The [DateTime] of today will be decreased
  // /// by the [requiredAge] in days.
  // void init() {
  //   templateDate = DateTime.now().subtract(Duration(
  //       days: ((365 + 1 / 4 - 1 / 100 + 1 / 400) * requiredAge).round()));
  //   derivateDateList = List<DateTime>();
  //   createDerivateDates(templateDate);
  // }

  /// The currently selected [DateTime] which will be the user's
  /// day of birth.
  ///
  /// Ensure the [selectedDate] [DateTime] will remain
  /// null until the user will make the first input.
  DateTime? selectedDate;

  // /// The [DateTime] used to create the displayed derivate
  // /// dates.
  // DateTime templateDate;

  // /// The created [DateTime] objects derivated by the [templateDate].
  // List<DateTime> derivateDateList;

  // /// The [List] of all days of the week in English (international)
  // /// localization.
  // List<String> weekdays = [
  //   "Monday",
  //   "Tuesday",
  //   "Wednesday",
  //   "Thursday",
  //   "Friday",
  //   "Saturday",
  //   "Sunday",
  // ];

  // /// Returns a [List] of [String] values containing the localized weekdays.
  // ///
  // /// The provided [Locale] will first be checked for its [languageCode]
  // /// property value to determine how many letters the a
  // List<String> getLocalizedWeekdays(Locale locale) {
  //   print(locale.languageCode);
  //   DateFormat formatter = DateFormat(DateFormat.WEEKDAY, locale.languageCode);
  //   if (locale.languageCode == 'us' ||
  //       locale.languageCode == 'de' ||
  //       locale.languageCode == 'es' ||
  //       locale.languageCode == 'ru' ||
  //       locale.languageCode == 'fr') {
  //     return [
  //       DateTime(2020, 8, 24),
  //       DateTime(2020, 8, 25),
  //       DateTime(2020, 8, 26),
  //       DateTime(2020, 8, 27),
  //       DateTime(2020, 8, 28),
  //       DateTime(2020, 8, 29),
  //       DateTime(2020, 8, 30)
  //     ].map((day) => formatter.format(day)).toList();
  //   } else
  //     return weekdays;
  // }

  // /// Return a [List] of abbreviated weekday labels.
  // List<String> get abbreviatedWeekdays {
  //   return weekdays.map((day) => day.substring(0, 3).toUpperCase()).toList();
  // }

  // /// Return a [List] of abbreviated and localized weekday labels.
  // List<String> getLocalizedAbbreviatedWeekdays(Locale locale) {
  //   return getLocalizedWeekdays(locale)
  //       .map((day) =>
  //           day.substring(0, locale.languageCode == 'de' ? 2 : 3).toUpperCase())
  //       .toList();
  // }

  /// Set the [selectedDate] object using the provided [DateTime].
  void setSelectedDate(DateTime date) {
    selectedDate = date;
  }

  // /// Decrease the [templateDate] [DateTime] by one month.
  // void decreaseByMonth() {
  //   templateDate = DateTime(templateDate.year, templateDate.month, 0);
  //   createDerivateDates(templateDate);
  // }

  // /// Increase the [templateDate] [DateTime] by one month.
  // void increaseByMonth() {
  //   templateDate = DateTime(templateDate.year, templateDate.month + 2, 0);
  //   createDerivateDates(templateDate);
  // }

  // /// Decrease the [templateDate] [DateTime] by one year.
  // void decreaseByYear() {
  //   templateDate = DateTime(templateDate.year - 1, templateDate.month + 1, 0);
  //   createDerivateDates(templateDate);
  // }

  // /// Increase the [templateDate] [DateTime] by one year.
  // void increaseByYear() {
  //   templateDate = DateTime(templateDate.year + 1, templateDate.month + 1, 0);
  //   createDerivateDates(templateDate);
  // }

  /// Check if the provided [DateTime] object are set in the same
  /// year.
  bool sameYear(DateTime main, DateTime other) {
    return main.year == other.year;
  }

  /// Check if the provided [DateTime] object are set in the same
  /// month.
  bool sameMonth(DateTime main, DateTime other) {
    return main.month == other.month;
  }

  /// Return the total amount of days a mean year has.
  double get daysPerMeanYear {
    return (365 + 1 / 4 - 1 / 100 + 1 / 400);
  }

  /// Return the total amount of days since the user's day of birth.
  /// This will be the required age in days.
  int get ageRequirementInDays {
    return (daysPerMeanYear * 13).floor();
  }

  /// Check if the provided day of birth [DateTime] is valid.
  ///
  /// This will state whether or not the user is allowed to
  /// use this application.
  bool dayOfBirthIsValid(DateTime dayOfBirth) {
    return DateTime.now()
        .subtract(Duration(days: ageRequirementInDays))
        .isAfter(dayOfBirth);
  }

  // /// Create a updated [List] of [DateTime] objects stored in the
  // /// [derivateDateList].
  // ///
  // /// Each time the month or year on the displayed calendar view is
  // /// change, the corresponding [DateTime] objects must be derivated
  // /// based on the provided reference [DateTime]

  // void createDerivateDates(DateTime reference) {
  //   /// Clear the [derivateDateList].
  //   derivateDateList.clear();

  //   /// Create a clean DateTime which will only enclose
  //   /// the provided year and month value.
  //   final DateTime cleanDate = DateTime(reference.year, reference.month, 0);

  //   /// Create a seperate day counter.
  //   int prevDay = 0;

  //   /// If the weekday is earlier than
  //   /// sunday (7).
  //   if (cleanDate.weekday < 7) {
  //     /// Copy the weekday value to the [prevDay] counter.
  //     prevDay = cleanDate.weekday;

  //     for (int i = 1; i <= prevDay; i++) {
  //       derivateDateList.add(cleanDate.subtract(Duration(days: prevDay - i)));
  //     }
  //   }
  //   for (int i = 0; i < (42 - prevDay); i++) {
  //     derivateDateList.add(cleanDate.add(Duration(days: i + 1)));
  //   }
  // }
}
