import 'package:flutter/material.dart';
import 'package:leitmotif/styles.dart';

/// A collection of serif [TextStyle]s.
///
/// The styles are implementing the `Merriweather` font family.
///
/// These styles are included:
///
/// * `caption`
/// * `button`
/// * `body`
/// * `body2`
/// * `header5`
/// * `header6`
class LitSerifStyles {
  /// All fonts should be derived from this very package ('leitmotif')
  static const String package = "leitmotif";

  /// The default serif font family.
  static const String merriweather = "Merriweather";

  /// The default text color for all [TextStyle]s.
  static const Color defaultColor = LitColors.mediumGrey;

  /// The styling applied on small texts.
  ///
  /// ```dart
  /// fontSize: 11.0,
  /// fontWeight: FontWeight.w600,
  /// ```
  static const TextStyle caption = const TextStyle(
    color: defaultColor,
    fontSize: 10.0,
    fontFamily: merriweather,
    package: package,
    fontWeight: FontWeight.w600,
  );

  /// The styling applied on buttons.
  ///
  /// ```dart
  /// fontSize: 14.0,
  /// fontWeight: FontWeight.w600,
  /// letterSpacing: 0.65,
  /// ```
  static const TextStyle button = const TextStyle(
    color: defaultColor,
    fontSize: 13.0,
    fontFamily: merriweather,
    package: package,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.65,
  );

  /// The styling applied on buttons.
  ///
  /// ```dart
  /// fontSize: 14.0,
  /// fontWeight: FontWeight.w600,
  /// ```
  static const TextStyle body = const TextStyle(
    color: defaultColor,
    fontSize: 13.0,
    fontFamily: merriweather,
    package: package,
    fontWeight: FontWeight.w600,
  );

  /// The styling applied on looser body text.
  ///
  /// ```dart
  /// fontSize: 16.0,
  /// fontWeight: FontWeight.w600,
  /// letterSpacing: 0.65,
  /// ```
  static const TextStyle body2 = const TextStyle(
    color: defaultColor,
    fontSize: 15.0,
    fontFamily: merriweather,
    package: package,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.65,
  );

  /// The styling applied on small headers.
  ///
  /// ```dart
  /// fontSize: 16.0,
  /// fontWeight: FontWeight.w600,
  /// letterSpacing: 0.65,
  /// ```
  static const TextStyle header5 = const TextStyle(
    color: defaultColor,
    fontSize: 15.0,
    fontFamily: merriweather,
    package: package,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.65,
  );

  /// The styling applied on small headers.
  ///
  /// ```dart
  /// fontSize: 16.0,
  /// fontWeight: FontWeight.w700,
  /// letterSpacing: 0.65,
  /// ```
  static const TextStyle header6 = const TextStyle(
    color: defaultColor,
    fontSize: 19.0,
    fontFamily: merriweather,
    package: package,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.65,
  );
}
