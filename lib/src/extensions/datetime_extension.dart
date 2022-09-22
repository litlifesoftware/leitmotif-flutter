import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Extension on [DateTime] class.
///
/// Includes methods to:
/// - Format the [DateTime] into a localized and human-readible string.
///
extension DateTimeExtension on DateTime {
  /// The formatted string will output the the day, the month and the
  /// year.
  ///
  /// For example the EN localization of the corresponding [DateTime] will
  /// return `April 10, 2021`.
  String formatAsLocalizedDate(BuildContext context) {
    final DateFormat formatter =
        DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    return formatter.format(this);
  }

  /// The formatted string will output the the day, the month and the
  /// year.
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

  /// The formatted string will output the weekday, the day, the month and the
  /// year.
  ///
  /// For example the EN localization of the corresponding [DateTime] will
  /// return `Saturday, April 10, 2021`.
  String formatAsLocalizedDateWithWeekday(BuildContext context) {
    final DateFormat formatter =
        DateFormat.yMMMMEEEEd(Localizations.localeOf(context).languageCode);
    return formatter.format(this);
  }

  /// The formatted string will only output the year.
  ///
  /// For example the EN localization of the corresponding [DateTime] will
  /// return `2021`.
  String formatAsLocalizedYear(BuildContext context) {
    final DateFormat formatter =
        DateFormat.y(Localizations.localeOf(context).languageCode);
    return formatter.format(this);
  }

  /// The formatted string will only output the month.
  ///
  /// For example the EN localization of the corresponding [DateTime] will
  /// return `September`.
  String formatAsLocalizedMonth(BuildContext context) {
    final DateFormat formatter =
        DateFormat.MMMM(Localizations.localeOf(context).languageCode);
    return formatter.format(this);
  }
}
