import 'package:intl/intl.dart';

/// Extension on DateTime class to shorten the process of localizing formatted
/// [DateTime]s.
extension LocalizedDateTime on DateTime {
  /// Formats the [DateTime] to a localized and human-readible string.
  ///
  /// The formatted string will output the weekday, the day, the month and the
  /// year included in the [DateTime].
  ///
  /// For example the english localization of the corresponding [DateTime] will
  /// return `Saturday, April 10, 2021`.
  String formatAsLocalizedDateWithWeekday() {
    final DateFormat formatter = DateFormat.yMMMMEEEEd(Intl.getCurrentLocale());
    return formatter.format(this);
  }
}
