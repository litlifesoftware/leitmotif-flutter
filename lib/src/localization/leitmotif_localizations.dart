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
    LeitmotifLocalizationsEN.languageCode: LeitmotifLocalizationsEN.values,
    // 'German' localization
    LeitmotifLocalizationsDE.languageCode: LeitmotifLocalizationsDE.values,
  };

  /// Returns the currently implemented languages inside the localization map
  /// as their key.
  static List<String> get languages => _localizedValues.keys.toList();

  /// Returns a list of all supported locales.
  ///
  /// This list can be provided to the root [MaterialApp] as `supportedLocales`
  /// member value.
  static const supportedLocales = const [
    // English locale (no contry code)
    Locale(LeitmotifLocalizationsEN.languageCode),
    // German (no contry code)
    Locale(LeitmotifLocalizationsDE.languageCode),
  ];

  /// Returns the localized value based on the provided [localizationKey].
  String localizeValue(String localizationKey) {
    return _localizedValues[locale.languageCode]![localizationKey]!;
  }

  String get submitLabel {
    return localizeValue(LeitmotifLocalizationsKeys.submitLabel);
  }

  String get applyLabel {
    return localizeValue(LeitmotifLocalizationsKeys.applyLabel);
  }

  String get cancelLabel {
    return localizeValue(LeitmotifLocalizationsKeys.cancelLabel);
  }

  String get resetLabel {
    return localizeValue(LeitmotifLocalizationsKeys.resetLabel);
  }

  String get dateInputLabel {
    return localizeValue(LeitmotifLocalizationsKeys.dateInputLabel);
  }

  String get colorInputLabel {
    return localizeValue(LeitmotifLocalizationsKeys.colorInputLabel);
  }

  String get ageInputLabel {
    return localizeValue(LeitmotifLocalizationsKeys.ageInputLabel);
  }

  String get ageRequiredLabel {
    return localizeValue(LeitmotifLocalizationsKeys.ageRequiredLabel);
  }

  String get startLabel {
    return localizeValue(LeitmotifLocalizationsKeys.startLabel);
  }

  String get selectLabel {
    return localizeValue(LeitmotifLocalizationsKeys.selectLabel);
  }

  String get dayOfWeek1 {
    return localizeValue(LeitmotifLocalizationsKeys.dayOfWeek1);
  }

  String get dayOfWeek2 {
    return localizeValue(LeitmotifLocalizationsKeys.dayOfWeek2);
  }

  String get dayOfWeek3 {
    return localizeValue(LeitmotifLocalizationsKeys.dayOfWeek3);
  }

  String get dayOfWeek4 {
    return localizeValue(LeitmotifLocalizationsKeys.dayOfWeek4);
  }

  String get dayOfWeek5 {
    return localizeValue(LeitmotifLocalizationsKeys.dayOfWeek5);
  }

  String get dayOfWeek6 {
    return localizeValue(LeitmotifLocalizationsKeys.dayOfWeek6);
  }

  String get dayOfWeek7 {
    return localizeValue(LeitmotifLocalizationsKeys.dayOfWeek7);
  }

  String get january {
    return localizeValue(LeitmotifLocalizationsKeys.january);
  }

  String get february {
    return localizeValue(LeitmotifLocalizationsKeys.february);
  }

  String get march {
    return localizeValue(LeitmotifLocalizationsKeys.march);
  }

  String get april {
    return localizeValue(LeitmotifLocalizationsKeys.april);
  }

  String get may {
    return localizeValue(LeitmotifLocalizationsKeys.may);
  }

  String get june {
    return localizeValue(LeitmotifLocalizationsKeys.june);
  }

  String get july {
    return localizeValue(LeitmotifLocalizationsKeys.july);
  }

  String get august {
    return localizeValue(LeitmotifLocalizationsKeys.august);
  }

  String get september {
    return localizeValue(LeitmotifLocalizationsKeys.september);
  }

  String get october {
    return localizeValue(LeitmotifLocalizationsKeys.october);
  }

  String get november {
    return localizeValue(LeitmotifLocalizationsKeys.november);
  }

  String get december {
    return localizeValue(LeitmotifLocalizationsKeys.december);
  }

  String get yourAgeLabel {
    return localizeValue(LeitmotifLocalizationsKeys.yourAgeLabel);
  }

  String get invalidInputLabel {
    return localizeValue(LeitmotifLocalizationsKeys.invalidInputLabel);
  }

  String get invalidInputBody {
    return localizeValue(LeitmotifLocalizationsKeys.invalidInputBody);
  }

  String get invalidInputExtendedBody {
    return localizeValue(LeitmotifLocalizationsKeys.invalidInputExtendedBody);
  }

  String get verifyAgeScreenSuccessTitle {
    return localizeValue(
        LeitmotifLocalizationsKeys.verifyAgeScreenSuccessTitle);
  }

  String get verifyAgeScreenSuccessSubtitle {
    return localizeValue(
        LeitmotifLocalizationsKeys.verifyAgeScreenSuccessSubtitle);
  }

  String get verifyAgeScreenSuccessBody {
    return localizeValue(LeitmotifLocalizationsKeys.verifyAgeScreenSuccessBody);
  }

  String get verifyAgeScreenDescriptionBody {
    return localizeValue(
        LeitmotifLocalizationsKeys.verifyAgeScreenDescriptionBody);
  }

  String get creditsLabel {
    return localizeValue(LeitmotifLocalizationsKeys.creditsLabel);
  }

  String get fullyTransprentLabel {
    return localizeValue(LeitmotifLocalizationsKeys.fullyTransparentLabel);
  }

  String get licensesLabel {
    return localizeValue(LeitmotifLocalizationsKeys.licensesLabel);
  }

  String get backLabel {
    return localizeValue(LeitmotifLocalizationsKeys.backLabel);
  }

  String get notificationLabel {
    return localizeValue(LeitmotifLocalizationsKeys.notificationLabel);
  }

  String get advancedSettingsLabel {
    return localizeValue(LeitmotifLocalizationsKeys.advancedSettingsLabel);
  }

  String get settingsLabel {
    return localizeValue(LeitmotifLocalizationsKeys.settingsLabel);
  }

  String get nextLabel {
    return localizeValue(LeitmotifLocalizationsKeys.nextLabel);
  }

  String get onboardingLabel {
    return localizeValue(LeitmotifLocalizationsKeys.onboardingLabel);
  }

  String get dismissLabel {
    return localizeValue(LeitmotifLocalizationsKeys.dismissLabel);
  }

  String get signUpLabel {
    return localizeValue(LeitmotifLocalizationsKeys.signUpLabel);
  }

  String get privacyPolicyLabel {
    return localizeValue(LeitmotifLocalizationsKeys.privacyPolicyLabel);
  }

  String get privacyLabel {
    return localizeValue(LeitmotifLocalizationsKeys.privacyLabel);
  }

  String get privateLabel {
    return localizeValue(LeitmotifLocalizationsKeys.privateLabel);
  }

  String get offlineLabel {
    return localizeValue(LeitmotifLocalizationsKeys.offlineLabel);
  }

  String get agreeLabel {
    return localizeValue(LeitmotifLocalizationsKeys.agreeLabel);
  }

  String get deleteLabel {
    return localizeValue(LeitmotifLocalizationsKeys.deleteLabel);
  }

  String get deleteObjectDescriptionText {
    return localizeValue(LeitmotifLocalizationsKeys.deleteDescriptionBodyText);
  }

  String get deleteObjectTitle {
    return localizeValue(LeitmotifLocalizationsKeys.deleteObjectTitle);
  }

  String get confirmDeleteTitle {
    return localizeValue(LeitmotifLocalizationsKeys.confirmDeleteTitle);
  }

  String get deleteObjectPrompt {
    return localizeValue(LeitmotifLocalizationsKeys.deleteObjectPrompt);
  }

  String get composeLabel {
    return localizeValue(LeitmotifLocalizationsKeys.composeLabel);
  }

  String get createLabel {
    return localizeValue(LeitmotifLocalizationsKeys.createLabel);
  }

  String get aboutAppLabel {
    return localizeValue(LeitmotifLocalizationsKeys.aboutAppLabel);
  }

  String get userExpericenceDesignLabel {
    return localizeValue(LeitmotifLocalizationsKeys.userExpericenceDesignLabel);
  }

  String get developmentLabel {
    return localizeValue(LeitmotifLocalizationsKeys.developmentLabel);
  }

  String get photographyLabel {
    return localizeValue(LeitmotifLocalizationsKeys.photographyLabel);
  }

  String get manageBackupLabel {
    return localizeValue(LeitmotifLocalizationsKeys.manageBackupLabel);
  }

  String get startTourLabel {
    return localizeValue(LeitmotifLocalizationsKeys.startTourLabel);
  }

  String get creatorLabel {
    return localizeValue(LeitmotifLocalizationsKeys.creatorLabel);
  }

  String get allLabel {
    return localizeValue(LeitmotifLocalizationsKeys.allLabel);
  }

  String get latestLabel {
    return localizeValue(LeitmotifLocalizationsKeys.latestLabel);
  }

  String get unsavedLabel {
    return localizeValue(LeitmotifLocalizationsKeys.unsavedLabel);
  }

  String get restoreLabel {
    return localizeValue(LeitmotifLocalizationsKeys.restoreLabel);
  }

  String get savedLabel {
    return localizeValue(LeitmotifLocalizationsKeys.savedLabel);
  }

  String get locationLabel {
    return localizeValue(LeitmotifLocalizationsKeys.locationLabel);
  }

  String get publishedLabel {
    return localizeValue(LeitmotifLocalizationsKeys.publishedLabel);
  }

  String get statisticsLabel {
    return localizeValue(LeitmotifLocalizationsKeys.statisticsLabel);
  }

  String get selectBackupTitle {
    return localizeValue(LeitmotifLocalizationsKeys.selectBackupTitle);
  }

  String get restoreFromBackupTitle {
    return localizeValue(LeitmotifLocalizationsKeys.restoreFromBackupTitle);
  }

  String get unsupportedFileTitle {
    return localizeValue(LeitmotifLocalizationsKeys.unsupportedFileTitle);
  }

  String get unsupportedFileDescr {
    return localizeValue(LeitmotifLocalizationsKeys.unsupportedFileDescr);
  }

  String get createdOnLabel {
    return localizeValue(LeitmotifLocalizationsKeys.createdOnLabel);
  }

  String get lessLabel {
    return localizeValue(LeitmotifLocalizationsKeys.lessLabel);
  }

  String get moreLabel {
    return localizeValue(LeitmotifLocalizationsKeys.moreLabel);
  }

  String get todayLabel {
    return localizeValue(LeitmotifLocalizationsKeys.todayLabel);
  }

  String get anotherDayLabel {
    return localizeValue(LeitmotifLocalizationsKeys.anotherDayLabel);
  }

  String get pickFileLabel {
    return localizeValue(LeitmotifLocalizationsKeys.pickFileLabel);
  }

  String get selectedLabel {
    return localizeValue(LeitmotifLocalizationsKeys.selectedLabel);
  }

  String get upToDateLabel {
    return localizeValue(LeitmotifLocalizationsKeys.upToDateLabel);
  }
}
