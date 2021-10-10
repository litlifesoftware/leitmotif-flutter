import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

/// A Leitmotif `localization` class enabling localized values on dialog and
/// screen widgets.
///
/// Implements the default localization, which is applied on widgets without
/// custom localization.
class LeitmotifLocalizations {
  /// Creates a [LeitmotifLocalizations] object using the provided `locale`.
  LeitmotifLocalizations(this.locale);

  /// The device's locale.
  final Locale locale;

  /// Returns the closest [LeitmotifLocalizations] object inside the current
  /// `BuildContext`.
  static LeitmotifLocalizations of(BuildContext context) {
    return Localizations.of<LeitmotifLocalizations>(
        context, LeitmotifLocalizations)!;
  }

  /// A list of localized labels, titles and body text elements.
  ///
  /// Currently implemented and supported languages:
  /// * `English`
  /// * `German`
  static const _localizedValues = <String, Map<String, String>>{
    // 'English' localization
    'en': const {
      _Keys.submitLabel: 'Submit',
      _Keys.cancelLabel: 'Cancel',
      _Keys.dateInputLabel: 'Enter Date',
      _Keys.dayOfWeek1: 'Monday',
      _Keys.dayOfWeek2: 'Tuesday',
      _Keys.dayOfWeek3: 'Wednesday',
      _Keys.dayOfWeek4: 'Thursday',
      _Keys.dayOfWeek5: 'Friday',
      _Keys.dayOfWeek6: 'Saturday',
      _Keys.dayOfWeek7: 'Sunday',
      _Keys.january: 'January',
      _Keys.february: 'February',
      _Keys.march: 'March',
      _Keys.april: 'April',
      _Keys.may: 'May',
      _Keys.june: 'June',
      _Keys.july: 'July',
      _Keys.august: 'August',
      _Keys.september: 'September',
      _Keys.october: 'October',
      _Keys.november: 'November',
      _Keys.december: 'December',
      _Keys.yourAgeLabel: 'Your Age',
      _Keys.invalidInputBody: 'Please check your input.',
      _Keys.verifyAgeScreenTitle: 'Enter your Age',
      _Keys.verifyAgeScreenSubtitle: 'This app does need your age',
    },
    // 'German' localization
    'de': const {
      _Keys.submitLabel: 'Bestätigen',
      _Keys.cancelLabel: 'Abbrechen',
      _Keys.dateInputLabel: 'Datum eingeben',
      _Keys.dayOfWeek1: 'Montag',
      _Keys.dayOfWeek2: 'Dienstag',
      _Keys.dayOfWeek3: 'Mittwoch',
      _Keys.dayOfWeek4: 'Donnerstag',
      _Keys.dayOfWeek5: 'Freitag',
      _Keys.dayOfWeek6: 'Samstag',
      _Keys.dayOfWeek7: 'Sonntag',
      _Keys.january: 'Januar',
      _Keys.february: 'Februar',
      _Keys.march: 'März',
      _Keys.april: 'April',
      _Keys.may: 'Mai',
      _Keys.june: 'Juni',
      _Keys.july: 'Juli',
      _Keys.august: 'August',
      _Keys.september: 'September',
      _Keys.october: 'Oktober',
      _Keys.november: 'November',
      _Keys.december: 'Dezember',
      _Keys.yourAgeLabel: 'Dein Alter',
      _Keys.invalidInputBody: 'Bitte überprüfe deine Eingabe.',
      _Keys.verifyAgeScreenTitle: 'Gib dein Alter ein',
      _Keys.verifyAgeScreenSubtitle: 'Diese App benötigt dein Alter',
    },
  };

  /// Returns the currently implemented languages as their two-letter code.
  static List<String> languages() => _localizedValues.keys.toList();

  String get submitLabel {
    return _localizedValues[locale.languageCode]![_Keys.submitLabel]!;
  }

  String get cancelLabel {
    return _localizedValues[locale.languageCode]![_Keys.cancelLabel]!;
  }

  String get dateInputLabel {
    return _localizedValues[locale.languageCode]![_Keys.dateInputLabel]!;
  }

  String get dayOfWeek1 {
    return _localizedValues[locale.languageCode]![_Keys.dayOfWeek1]!;
  }

  String get dayOfWeek2 {
    return _localizedValues[locale.languageCode]![_Keys.dayOfWeek2]!;
  }

  String get dayOfWeek3 {
    return _localizedValues[locale.languageCode]![_Keys.dayOfWeek3]!;
  }

  String get dayOfWeek4 {
    return _localizedValues[locale.languageCode]![_Keys.dayOfWeek4]!;
  }

  String get dayOfWeek5 {
    return _localizedValues[locale.languageCode]![_Keys.dayOfWeek5]!;
  }

  String get dayOfWeek6 {
    return _localizedValues[locale.languageCode]![_Keys.dayOfWeek6]!;
  }

  String get dayOfWeek7 {
    return _localizedValues[locale.languageCode]![_Keys.dayOfWeek7]!;
  }

  String get january {
    return _localizedValues[locale.languageCode]![_Keys.january]!;
  }

  String get february {
    return _localizedValues[locale.languageCode]![_Keys.february]!;
  }

  String get march {
    return _localizedValues[locale.languageCode]![_Keys.march]!;
  }

  String get april {
    return _localizedValues[locale.languageCode]![_Keys.april]!;
  }

  String get may {
    return _localizedValues[locale.languageCode]![_Keys.may]!;
  }

  String get june {
    return _localizedValues[locale.languageCode]![_Keys.june]!;
  }

  String get july {
    return _localizedValues[locale.languageCode]![_Keys.july]!;
  }

  String get august {
    return _localizedValues[locale.languageCode]![_Keys.august]!;
  }

  String get september {
    return _localizedValues[locale.languageCode]![_Keys.september]!;
  }

  String get october {
    return _localizedValues[locale.languageCode]![_Keys.october]!;
  }

  String get november {
    return _localizedValues[locale.languageCode]![_Keys.november]!;
  }

  String get december {
    return _localizedValues[locale.languageCode]![_Keys.december]!;
  }

  String get yourAgeLabel {
    return _localizedValues[locale.languageCode]![_Keys.yourAgeLabel]!;
  }

  String get invalidInputBody {
    return _localizedValues[locale.languageCode]![_Keys.invalidInputBody]!;
  }

  String get verifyAgeScreenTitle {
    return _localizedValues[locale.languageCode]![_Keys.verifyAgeScreenTitle]!;
  }

  String get verifyAgeScreenSubtitle {
    return _localizedValues[locale.languageCode]![
        _Keys.verifyAgeScreenSubtitle]!;
  }
}

/// A Leitmotif delegate class initializing the [LeitmotifLocalizations].
class LeitmotifLocalizationsDelegate
    extends LocalizationsDelegate<LeitmotifLocalizations> {
  const LeitmotifLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      LeitmotifLocalizations.languages().contains(locale.languageCode);

  @override
  Future<LeitmotifLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of LeitmotifLocalizations.
    return SynchronousFuture<LeitmotifLocalizations>(
      LeitmotifLocalizations(locale),
    );
  }

  @override
  bool shouldReload(LeitmotifLocalizationsDelegate old) => false;
}

/// Contains all keys that map to a localized value.
///
/// The keys on the localization map are accessed using it's corresponding
/// [_Keys] property to enforce integrity.
class _Keys {
  static const String submitLabel = 'submitLabel';
  static const String cancelLabel = 'cancelLabel';
  static const String dateInputLabel = 'dateInputLabel';
  static const String dayOfWeek1 = 'dayOfWeek1';
  static const String dayOfWeek2 = 'dayOfWeek2';
  static const String dayOfWeek3 = 'dayOfWeek3';
  static const String dayOfWeek4 = 'dayOfWeek4';
  static const String dayOfWeek5 = 'dayOfWeek5';
  static const String dayOfWeek6 = 'dayOfWeek6';
  static const String dayOfWeek7 = 'dayOfWeek7';
  static const String january = 'january';
  static const String february = 'february';
  static const String march = 'march';
  static const String april = 'april';
  static const String may = 'may';
  static const String june = 'june';
  static const String july = 'july';
  static const String august = 'august';
  static const String september = 'september';
  static const String october = 'october';
  static const String november = 'november';
  static const String december = 'december';
  static const String yourAgeLabel = 'yourAgeLabel';
  static const String invalidInputBody = 'invalidInputBody';
  static const String verifyAgeScreenTitle = 'verifyAgeScreenTitle';
  static const String verifyAgeScreenSubtitle = 'verifyAgeScreenSubtitle';
}
