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
      _Keys.applyLabel: 'Apply',
      _Keys.cancelLabel: 'Cancel',
      _Keys.startLabel: 'Start',
      _Keys.selectLabel: 'Select',
      _Keys.resetLabel: 'Reset',
      _Keys.dateInputLabel: 'Enter Date',
      _Keys.colorInputLabel: 'Enter Color',
      _Keys.ageInputLabel: 'Enter your Age',
      _Keys.ageRequiredLabel: 'This app does need your age',
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
      _Keys.invalidInputLabel: 'Invalid Input',
      _Keys.invalidInputBody: 'Please check your input.',
      _Keys.invalidInputExtendedBody:
          'Some of your inputted values are not valid. Please check your input.' +
              '' +
              'Please check your input.',
      _Keys.verifyAgeScreenSuccessTitle: 'Age confirmed',
      _Keys.verifyAgeScreenSuccessSubtitle: 'Your age has been confirmed',
      _Keys.verifyAgeScreenSuccessBody:
          'Thank you for verifying your age. Have a good time!',
      _Keys.verifyAgeScreenDescriptionBody:
          "Your date of birth helps us to enable certain functions" +
              " " +
              "on this app. We won't send any data to" +
              " " +
              "anyone. Your age will not be shared.",
      _Keys.creditsLabel: 'Credits',
      _Keys.fullyTransparentLabel: 'Color is fully transparent',
      _Keys.licensesLabel: 'Licenses',
      _Keys.backLabel: 'Back',
      _Keys.notificationLabel: 'Notification',
      _Keys.advancedSettingsLabel: 'Advanced Settings',
      _Keys.settingsLabel: 'Settings',
      _Keys.nextLabel: 'Next',
      _Keys.onboardingLabel: 'Onboarding',
      _Keys.dismissLabel: 'Dismiss',
      _Keys.signUpLabel: 'Sign Up',
      _Keys.privacyPolicyLabel: 'Privacy Policy',
      _Keys.privacyLabel: 'Privacy',
      _Keys.privateLabel: 'Private',
      _Keys.offlineLabel: 'Offline',
      _Keys.agreeLabel: 'Agree',
      _Keys.deleteLabel: 'Delete',
    },
    // 'German' localization
    'de': const {
      _Keys.submitLabel: 'Bestätigen',
      _Keys.applyLabel: 'Anwenden',
      _Keys.cancelLabel: 'Abbrechen',
      _Keys.startLabel: 'Start',
      _Keys.selectLabel: 'Auswählen',
      _Keys.resetLabel: 'Zurücksetzen',
      _Keys.dateInputLabel: 'Datum eingeben',
      _Keys.colorInputLabel: 'Enter Color',
      _Keys.ageInputLabel: 'Gib dein Alter ein',
      _Keys.ageRequiredLabel: 'Diese App benötigt dein Alter',
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
      _Keys.invalidInputLabel: 'Fehlerhafte Eingaben',
      _Keys.invalidInputBody: 'Bitte überprüfe deine Eingabe.',
      _Keys.invalidInputExtendedBody:
          'Einige deiner eingegebenen Werte sind fehlerhaft.' +
              ' ' +
              'Bitte überprüfe deine Eingabe.',
      _Keys.verifyAgeScreenSuccessTitle: 'Alter bestätigt',
      _Keys.verifyAgeScreenSuccessSubtitle: 'Dein Alter wurde bestätigt',
      _Keys.verifyAgeScreenSuccessBody:
          'Vielen Dank für die Altersbestätigung. Viel Vergnügen!',
      _Keys.verifyAgeScreenDescriptionBody:
          "Dein Alter hilft uns Funktionen dieser App zu gewährleisten." +
              " " +
              "Diese App wird keine Daten weitergeben." +
              " " +
              "Dein Alter wird geteilt.",
      _Keys.creditsLabel: 'Mitwirkende',
      _Keys.fullyTransparentLabel: 'Diese Farbe ist vollständig transparent',
      _Keys.licensesLabel: 'Lizenzen',
      _Keys.backLabel: 'Zurück',
      _Keys.notificationLabel: 'Benachrichtigung',
      _Keys.advancedSettingsLabel: 'Erweiterte Einstellungen',
      _Keys.settingsLabel: 'Einstellungen',
      _Keys.nextLabel: 'Nächste',
      _Keys.onboardingLabel: 'Start',
      _Keys.dismissLabel: 'Ausblenden',
      _Keys.signUpLabel: 'Registrieren',
      _Keys.privacyPolicyLabel: 'Datenschutzrichtlinien',
      _Keys.privacyLabel: 'Privatsphäre',
      _Keys.privateLabel: 'Vertraulich',
      _Keys.offlineLabel: 'Offline',
      _Keys.agreeLabel: 'Akzeptieren',
      _Keys.deleteLabel: 'Entfernen',
    },
  };

  /// Returns the currently implemented languages as their two-letter code.
  static List<String> languages() => _localizedValues.keys.toList();

  String get submitLabel {
    return _localizedValues[locale.languageCode]![_Keys.submitLabel]!;
  }

  String get applyLabel {
    return _localizedValues[locale.languageCode]![_Keys.applyLabel]!;
  }

  String get cancelLabel {
    return _localizedValues[locale.languageCode]![_Keys.cancelLabel]!;
  }

  String get resetLabel {
    return _localizedValues[locale.languageCode]![_Keys.resetLabel]!;
  }

  String get dateInputLabel {
    return _localizedValues[locale.languageCode]![_Keys.dateInputLabel]!;
  }

  String get colorInputLabel {
    return _localizedValues[locale.languageCode]![_Keys.colorInputLabel]!;
  }

  String get ageInputLabel {
    return _localizedValues[locale.languageCode]![_Keys.ageInputLabel]!;
  }

  String get ageRequiredLabel {
    return _localizedValues[locale.languageCode]![_Keys.ageRequiredLabel]!;
  }

  String get startLabel {
    return _localizedValues[locale.languageCode]![_Keys.startLabel]!;
  }

  String get selectLabel {
    return _localizedValues[locale.languageCode]![_Keys.selectLabel]!;
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

  String get invalidInputLabel {
    return _localizedValues[locale.languageCode]![_Keys.invalidInputLabel]!;
  }

  String get invalidInputBody {
    return _localizedValues[locale.languageCode]![_Keys.invalidInputBody]!;
  }

  String get invalidInputExtendedBody {
    return _localizedValues[locale.languageCode]![
        _Keys.invalidInputExtendedBody]!;
  }

  String get verifyAgeScreenSuccessTitle {
    return _localizedValues[locale.languageCode]![
        _Keys.verifyAgeScreenSuccessTitle]!;
  }

  String get verifyAgeScreenSuccessSubtitle {
    return _localizedValues[locale.languageCode]![
        _Keys.verifyAgeScreenSuccessSubtitle]!;
  }

  String get verifyAgeScreenSuccessBody {
    return _localizedValues[locale.languageCode]![
        _Keys.verifyAgeScreenSuccessBody]!;
  }

  String get verifyAgeScreenDescriptionBody {
    return _localizedValues[locale.languageCode]![
        _Keys.verifyAgeScreenDescriptionBody]!;
  }

  String get creditsLabel {
    return _localizedValues[locale.languageCode]![_Keys.creditsLabel]!;
  }

  String get fullyTransprentLabel {
    return _localizedValues[locale.languageCode]![_Keys.fullyTransparentLabel]!;
  }

  String get licensesLabel {
    return _localizedValues[locale.languageCode]![_Keys.licensesLabel]!;
  }

  String get backLabel {
    return _localizedValues[locale.languageCode]![_Keys.backLabel]!;
  }

  String get notificationLabel {
    return _localizedValues[locale.languageCode]![_Keys.notificationLabel]!;
  }

  String get advancedSettingsLabel {
    return _localizedValues[locale.languageCode]![_Keys.advancedSettingsLabel]!;
  }

  String get settingsLabel {
    return _localizedValues[locale.languageCode]![_Keys.settingsLabel]!;
  }

  String get nextLabel {
    return _localizedValues[locale.languageCode]![_Keys.nextLabel]!;
  }

  String get onboardingLabel {
    return _localizedValues[locale.languageCode]![_Keys.onboardingLabel]!;
  }

  String get dismissLabel {
    return _localizedValues[locale.languageCode]![_Keys.dismissLabel]!;
  }

  String get signUpLabel {
    return _localizedValues[locale.languageCode]![_Keys.signUpLabel]!;
  }

  String get privacyPolicyLabel {
    return _localizedValues[locale.languageCode]![_Keys.privacyPolicyLabel]!;
  }

  String get privacyLabel {
    return _localizedValues[locale.languageCode]![_Keys.privacyLabel]!;
  }

  String get privateLabel {
    return _localizedValues[locale.languageCode]![_Keys.privateLabel]!;
  }

  String get offlineLabel {
    return _localizedValues[locale.languageCode]![_Keys.offlineLabel]!;
  }

  String get agreeLabel {
    return _localizedValues[locale.languageCode]![_Keys.agreeLabel]!;
  }

  String get deleteLabel {
    return _localizedValues[locale.languageCode]![_Keys.deleteLabel]!;
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
  static const String applyLabel = 'applyLabel';
  static const String cancelLabel = 'cancelLabel';
  static const String startLabel = 'startLabel';
  static const String selectLabel = 'selectLabel';
  static const String resetLabel = 'resetLabel';
  static const String backLabel = 'backLabel';
  static const String dateInputLabel = 'dateInputLabel';
  static const String colorInputLabel = 'colorInputLabel';
  static const String ageInputLabel = 'ageInputLabel';
  static const String ageRequiredLabel = 'ageRequiredLabel';
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
  static const String invalidInputLabel = 'invalidInputLabel';
  static const String invalidInputBody = 'invalidInputBody';
  static const String invalidInputExtendedBody = 'invalidInputExtendedBody';
  static const String verifyAgeScreenSuccessTitle =
      'verifyAgeScreenSuccessTitle';
  static const String verifyAgeScreenSuccessSubtitle =
      'verifyAgeScreenSuccessSubtitle';
  static const String verifyAgeScreenSuccessBody = 'verifyAgeScreenSuccessBody';
  static const String verifyAgeScreenDescriptionBody =
      'verifyAgeScreenDescriptionBody';
  static const String creditsLabel = 'creditsLabel';
  static const String fullyTransparentLabel = 'fullyTransprentLabel';
  static const String licensesLabel = 'licensesLabel';
  static const String notificationLabel = 'notificationLabel';
  static const String advancedSettingsLabel = 'advancedSettingsLabel';
  static const String settingsLabel = 'settingsLabel';
  static const String nextLabel = 'nextLabel';
  static const String onboardingLabel = 'onboardingLabel';
  static const String dismissLabel = 'dismissLabel';
  static const String signUpLabel = 'signUpLabel';
  static const String privacyPolicyLabel = 'privacyPolicyLabel';
  static const String privacyLabel = 'privacyLabel';
  static const String privateLabel = 'privateLabel';
  static const String offlineLabel = 'offlineLabel';
  static const String agreeLabel = 'agreeLabel';
  static const String deleteLabel = 'deleteLabel';
}
