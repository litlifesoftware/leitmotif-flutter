import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

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

  /// Returns the [LeitmotifLocalizations]' delegate.
  static const LeitmotifLocalizationsDelegate delegate =
      LeitmotifLocalizationsDelegate();

  /// A list of localized labels, titles and body text elements.
  ///
  /// Currently implemented and supported languages:
  /// * `English`
  /// * `German`
  static const _localizedValues = <String, Map<String, String>>{
    // 'English' localization
    LeitmotifLocalizationsEn.languageCode: LeitmotifLocalizationsEn.values,
    // 'German' localization
    LeitmotifLocalizationsDe.languageCode: LeitmotifLocalizationsDe.values,
  };

  /// Returns the currently implemented languages as their two-letter code.
  static List<String> languages() => _localizedValues.keys.toList();

  /// Returns the localized value based on the provided [localizationKey]
  /// implemented on the corresponding localization class.
  String localizeValue(String localizationKey) {
    return _localizedValues[locale.languageCode]![localizationKey]!;
  }

  String get submitLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.submitLabel]!;
  }

  String get applyLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.applyLabel]!;
  }

  String get cancelLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.cancelLabel]!;
  }

  String get resetLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.resetLabel]!;
  }

  String get dateInputLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.dateInputLabel]!;
  }

  String get colorInputLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.colorInputLabel]!;
  }

  String get ageInputLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.ageInputLabel]!;
  }

  String get ageRequiredLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.ageRequiredLabel]!;
  }

  String get startLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.startLabel]!;
  }

  String get selectLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.selectLabel]!;
  }

  String get dayOfWeek1 {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.dayOfWeek1]!;
  }

  String get dayOfWeek2 {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.dayOfWeek2]!;
  }

  String get dayOfWeek3 {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.dayOfWeek3]!;
  }

  String get dayOfWeek4 {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.dayOfWeek4]!;
  }

  String get dayOfWeek5 {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.dayOfWeek5]!;
  }

  String get dayOfWeek6 {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.dayOfWeek6]!;
  }

  String get dayOfWeek7 {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.dayOfWeek7]!;
  }

  String get january {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.january]!;
  }

  String get february {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.february]!;
  }

  String get march {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.march]!;
  }

  String get april {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.april]!;
  }

  String get may {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.may]!;
  }

  String get june {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.june]!;
  }

  String get july {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.july]!;
  }

  String get august {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.august]!;
  }

  String get september {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.september]!;
  }

  String get october {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.october]!;
  }

  String get november {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.november]!;
  }

  String get december {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.december]!;
  }

  String get yourAgeLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.yourAgeLabel]!;
  }

  String get invalidInputLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.invalidInputLabel]!;
  }

  String get invalidInputBody {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.invalidInputBody]!;
  }

  String get invalidInputExtendedBody {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.invalidInputExtendedBody]!;
  }

  String get verifyAgeScreenSuccessTitle {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.verifyAgeScreenSuccessTitle]!;
  }

  String get verifyAgeScreenSuccessSubtitle {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.verifyAgeScreenSuccessSubtitle]!;
  }

  String get verifyAgeScreenSuccessBody {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.verifyAgeScreenSuccessBody]!;
  }

  String get verifyAgeScreenDescriptionBody {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.verifyAgeScreenDescriptionBody]!;
  }

  String get creditsLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.creditsLabel]!;
  }

  String get fullyTransprentLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.fullyTransparentLabel]!;
  }

  String get licensesLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.licensesLabel]!;
  }

  String get backLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.backLabel]!;
  }

  String get notificationLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.notificationLabel]!;
  }

  String get advancedSettingsLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.advancedSettingsLabel]!;
  }

  String get settingsLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.settingsLabel]!;
  }

  String get nextLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.nextLabel]!;
  }

  String get onboardingLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.onboardingLabel]!;
  }

  String get dismissLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.dismissLabel]!;
  }

  String get signUpLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.signUpLabel]!;
  }

  String get privacyPolicyLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.privacyPolicyLabel]!;
  }

  String get privacyLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.privacyLabel]!;
  }

  String get privateLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.privateLabel]!;
  }

  String get offlineLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.offlineLabel]!;
  }

  String get agreeLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.agreeLabel]!;
  }

  String get deleteLabel {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.deleteLabel]!;
  }

  String get deleteObjectDescriptionText {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.deleteDescriptionBodyText]!;
  }

  String get deleteObjectTitle {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.deleteObjectTitle]!;
  }

  String get confirmDeleteTitle {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.confirmDeleteTitle]!;
  }

  String get deleteObjectPrompt {
    return _localizedValues[locale.languageCode]![
        LeitmotifLocalizationsKeys.deleteObjectPrompt]!;
  }
}
