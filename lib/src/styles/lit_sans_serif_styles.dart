import 'package:flutter/material.dart';
import 'package:leitmotif/styles.dart';

/// A collection of sans serif [TextStyle]s.
///
/// The styles are implementing the `Material Design` styles using different
/// default values and the `Montserrat` font family.
///
/// These styles are included:
///
/// * `overline`
/// * `caption`
/// * `button`
/// * `body1`
/// * `body2`
/// * `subtitle1`
/// * `subtitle2`
/// * `h6`
/// * `h5`
/// * `h3`
/// * `h2`
/// * `h1`
class LitSansSerifStyles {
  /// All fonts should be derived from this very package ('leitmotif')
  static const String _package = "leitmotif";

  /// The default sans serif font family.
  static const String _montserrat = "Montserrat";

  /// The default text color for all [TextStyle]s.
  static const Color defaultColor = LitColors.grey400;

  /// The styling applied on small overline text.
  ///
  /// Use this styling in combination with uppercase letters: `OVERLINE`.
  ///
  /// ```dart
  /// fontSize: 10.0,
  /// fontWeight: FontWeight.w400,
  /// letterSpacing: 0.5,
  /// ```
  ///
  static const overline = const TextStyle(
    color: defaultColor,
    fontFamily: _montserrat,
    package: _package,
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  /// The styling applied on small caption text.
  ///
  /// ```dart
  /// fontSize: 11.0,
  /// fontWeight: FontWeight.w400,
  /// ```
  ///
  static const caption = const TextStyle(
    color: defaultColor,
    fontFamily: _montserrat,
    package: _package,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  );

  /// The styling applied on buttons.
  /// Use this styling in combination with uppercase letters: `BUTTON`.
  /// ```dart
  /// fontSize: 14.0,
  /// fontWeight: FontWeight.w700,
  /// letterSpacing: 0.8,
  /// ```
  ///
  static const button = const TextStyle(
    color: defaultColor,
    fontFamily: _montserrat,
    package: _package,
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
  );

  /// The styling applied on default body text.
  /// ```dart
  /// fontSize: 14.0,
  /// fontWeight: FontWeight.w500,
  /// ```
  ///
  static const body2 = const TextStyle(
    color: defaultColor,
    fontFamily: _montserrat,
    package: _package,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  /// The styling applied on looser body text.
  /// ```dart
  /// fontSize: 16.0,
  /// fontWeight: FontWeight.w500,
  /// letterSpacing: 0.65,
  /// ```
  ///
  static const body1 = const TextStyle(
    color: defaultColor,
    fontFamily: _montserrat,
    package: _package,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.65,
  );

  /// The styling applied on small subtitles.
  /// ```dart
  /// fontSize: 14.0,
  /// fontWeight: FontWeight.w600,
  /// letterSpacing: 0.1,
  /// ```
  ///
  static const subtitle2 = const TextStyle(
    color: defaultColor,
    fontFamily: _montserrat,
    package: _package,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.20,
  );

  /// The styling applied on larger subtitles.
  /// ```dart
  /// fontSize: 16.0,
  /// fontWeight: FontWeight.w500,
  /// letterSpacing: 0.2,
  /// ```
  ///
  static const subtitle1 = const TextStyle(
    color: defaultColor,
    fontFamily: _montserrat,
    package: _package,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
  );

  /// The styling applied on h6 heading.
  /// ```dart
  /// fontSize: 20.0,
  /// fontWeight: FontWeight.w700,
  /// letterSpacing: 0.65,
  /// ```
  ///
  static const h6 = const TextStyle(
    color: defaultColor,
    fontFamily: _montserrat,
    package: _package,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.65,
  );

  /// The styling applied on h5 heading.
  /// ```dart
  /// fontSize: 22.0,
  /// fontWeight: FontWeight.w700,
  /// letterSpacing: 0.65,
  /// ```
  ///
  static const h5 = const TextStyle(
    color: defaultColor,
    fontFamily: _montserrat,
    package: _package,
    fontSize: 22.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.65,
  );

  /// The styling applied on h4 heading.
  /// ```dart
  /// fontSize: 32.0,
  /// fontWeight: FontWeight.w700,
  /// letterSpacing: 1.5,
  /// ```
  ///
  static const h4 = const TextStyle(
    package: _package,
    color: defaultColor,
    fontFamily: _montserrat,
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.5,
  );

  /// The styling applied on h3 heading.
  /// ```dart
  /// fontSize: 48.0,
  /// fontWeight: FontWeight.w600,
  /// letterSpacing: 0.0,
  /// ```
  ///
  static const h3 = const TextStyle(
    package: _package,
    color: defaultColor,
    fontFamily: _montserrat,
    fontSize: 48.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
  );

  /// The styling applied on h2 heading.
  /// ```dart
  /// fontSize: 60.0,
  /// fontWeight: FontWeight.w500,
  /// letterSpacing: -0.5,
  /// ```
  ///
  static const h2 = const TextStyle(
    package: _package,
    color: defaultColor,
    fontFamily: _montserrat,
    fontSize: 60.0,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
  );

  /// The styling applied on h1 heading.
  /// ```dart
  /// fontSize: 92.0,
  /// fontWeight: FontWeight.w400,
  /// letterSpacing: -1.0,
  /// ```
  ///
  static const h1 = const TextStyle(
    package: _package,
    color: defaultColor,
    fontFamily: _montserrat,
    fontSize: 92.0,
    fontWeight: FontWeight.w400,
    letterSpacing: -1.0,
  );

  /// A `TextTheme` based on the [LitSansSerifStyles].
  static const theme = const TextTheme(
    bodyText1: body1,
    bodyText2: body2,
    button: button,
    caption: caption,
    headline1: h1,
    headline2: h2,
    headline3: h3,
    headline4: h4,
    headline5: h5,
    headline6: h6,
    overline: overline,
    subtitle1: subtitle1,
    subtitle2: subtitle2,
  );
}
