import 'package:flutter/material.dart';
import 'package:lit_ui_kit/styles.dart';

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
  /// All fonts should be derived from this very package ('lit_ui_kit')
  static const String _package = "lit_ui_kit";

  /// The default sans serif font family.
  static const String _montserrat = "Montserrat";

  /// The default text color for all [TextStyle]s.
  static const Color defaultColor = LitColors.mediumGrey;

  /// The styling applied on small overline text.
  ///
  /// Use this styling in combination with uppercase letters: `OVERLINE`.
  ///
  /// ```dart
  /// fontSize: 10.0,
  /// fontWeight: FontWeight.w400,
  /// ```
  ///
  static const TextStyle overline = const TextStyle(
    color: defaultColor,
    fontFamily: _montserrat,
    package: _package,
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
  );

  /// The styling applied on small caption text.
  ///
  /// ```dart
  /// fontSize: 11.0,
  /// fontWeight: FontWeight.w400,
  /// ```
  ///
  static const TextStyle caption = const TextStyle(
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
  static const TextStyle button = const TextStyle(
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
  static const TextStyle body2 = const TextStyle(
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
  static const TextStyle body1 = const TextStyle(
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
  /// fontWeight: FontWeight.w500,
  /// letterSpacing: 0.1,
  /// ```
  ///
  static const TextStyle subtitle2 = const TextStyle(
    color: defaultColor,
    fontFamily: _montserrat,
    package: _package,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  /// The styling applied on larger subtitles.
  /// ```dart
  /// fontSize: 16.0,
  /// fontWeight: FontWeight.w500,
  /// letterSpacing: 0.2,
  /// ```
  ///
  static const TextStyle subtitle1 = const TextStyle(
    color: defaultColor,
    fontFamily: _montserrat,
    package: _package,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  /// The styling applied on h6 heading.
  /// ```dart
  /// fontSize: 20.0,
  /// fontWeight: FontWeight.w700,
  /// letterSpacing: 0.65,
  /// ```
  ///
  static const TextStyle h6 = const TextStyle(
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
  static const TextStyle h5 = const TextStyle(
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
  static const TextStyle h4 = const TextStyle(
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
  static const TextStyle h3 = const TextStyle(
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
  static const TextStyle h2 = const TextStyle(
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
  static const TextStyle h1 = const TextStyle(
    package: _package,
    color: defaultColor,
    fontFamily: _montserrat,
    fontSize: 92.0,
    fontWeight: FontWeight.w400,
    letterSpacing: -1.0,
  );
}
