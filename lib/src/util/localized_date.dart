import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Extension on DateTime class to shorten the process of localizing formatted
/// [DateTime]s.
extension LocalizedDateTime on DateTime {
  /// Formats the [DateTime] to a localized and human-readible string.
  ///
  /// The formatted string will output the the day, the month and the
  /// year included in the [DateTime].
  ///
  /// For example the EN localization of the corresponding [DateTime] will
  /// return `April 10, 2021`.
  String formatAsLocalizedDate(BuildContext context) {
    final DateFormat formatter =
        DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    return formatter.format(this);
  }

  /// Formats the [DateTime] to a localized and human-readible string.
  ///
  /// The formatted string will output the the day, the month and the
  /// year included in the [DateTime].
  ///
  /// For example the EN localization of the corresponding [DateTime] will
  /// return `April 10, 2021`.
  String formatAsLocalizedDateTime(BuildContext context) {
    final String formattedDate =
        DateFormat.yMMMMd(Localizations.localeOf(context).languageCode)
            .format(this);
    String formattedTime = DateFormat('kk:mm').format(this);

    return "$formattedDate $formattedTime";
  }

  /// Formats the [DateTime] to a localized and human-readible string.
  ///
  /// The formatted string will output the weekday, the day, the month and the
  /// year included in the [DateTime].
  ///
  /// For example the EN localization of the corresponding [DateTime] will
  /// return `Saturday, April 10, 2021`.
  String formatAsLocalizedDateWithWeekday(BuildContext context) {
    final DateFormat formatter =
        DateFormat.yMMMMEEEEd(Localizations.localeOf(context).languageCode);
    return formatter.format(this);
  }

  /// Formats the [DateTime] to a localized and human-readible string.
  ///
  /// The formatted string will only output the year included in the [DateTime].
  ///
  /// For example the EN localization of the corresponding [DateTime] will
  /// return `2021`.
  String formatAsLocalizedYear(BuildContext context) {
    final DateFormat formatter =
        DateFormat.y(Localizations.localeOf(context).languageCode);
    return formatter.format(this);
  }
}
