import 'dart:ui';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

/// A service class to access localized calendar labels for different regions.
///
/// The defined static methods can be accessed without initializing this class,
/// therefore the required [Locale] object must be provided on each method individually.
class CalendarLocalizationService {
  /// Returns a localized [List] of months.
  ///
  /// The corresponding [DateTime] objects are initialized by setting the first Month since
  /// the Unix epoche as the first [List] item. Each additional month is created by increasing
  /// the previous [DateTime] by one month.
  ///
  /// {@tool snippet}
  /// The user's language is determined by passing a [Locale] object. This object can be accessed
  /// using the localizations inside the context.
  /// ```dart
  /// CalendarLocalizationService.getLocalizedCalendarMonths(Localizations.localeOf(context));
  /// ```
  /// {@end-tool}
  ///
  static List<String> getLocalizedCalendarMonths(Locale locale) {
    print(locale.languageCode);
    initializeDateFormatting();
    DateFormat formatter = DateFormat(DateFormat.MONTH, locale.languageCode);

    return [
      DateTime(1970, 1, 1),
      DateTime(1970, 2, 1),
      DateTime(1970, 3, 1),
      DateTime(1970, 4, 1),
      DateTime(1970, 5, 1),
      DateTime(1970, 6, 1),
      DateTime(1970, 7, 1),
      DateTime(1970, 8, 1),
      DateTime(1970, 9, 1),
      DateTime(1970, 10, 1),
      DateTime(1970, 11, 1),
      DateTime(1970, 12, 1),
    ].map((month) => formatter.format(month)).toList();
  }

  /// Returns a localized [List] of weekdays.
  ///
  /// The corresponding [DateTime] objects are initialized by setting the first Monday since
  /// the Unix epoche as the first [List] item. Each additional weekday is created by increasing
  /// the previous [DateTime] by 86400 seconds (one day).
  ///
  /// {@tool snippet}
  /// The user's language is determined by passing a [Locale] object. This object can be accessed
  /// using the localizations inside the context.
  /// ```dart
  /// CalendarLocalizationService.getLocalizedCalendarWeekdays(Localizations.localeOf(context));
  /// ```
  /// {@end-tool}
  ///

  static List<String> getLocalizedCalendarWeekdays(Locale locale) {
    print(locale.languageCode);
    initializeDateFormatting();
    DateFormat formatter = DateFormat(DateFormat.WEEKDAY, locale.languageCode);
    final DateTime firstMondaySinceEpoche =
        DateTime.fromMillisecondsSinceEpoch(345600000);
    const Duration oneDay = const Duration(milliseconds: 86400000);
    return [
      firstMondaySinceEpoche,
      firstMondaySinceEpoche.add(oneDay),
      firstMondaySinceEpoche.add(oneDay * 2),
      firstMondaySinceEpoche.add(oneDay * 3),
      firstMondaySinceEpoche.add(oneDay * 4),
      firstMondaySinceEpoche.add(oneDay * 5),
      firstMondaySinceEpoche.add(oneDay * 6),
    ].map((day) => formatter.format(day)).toList();
  }
}
