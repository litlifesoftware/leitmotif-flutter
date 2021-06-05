import 'package:flutter/material.dart';
import 'package:lit_ui_kit/styles.dart';

/// A collection of sans serif [TextStyle]s.
///
/// The styles are implementing the `Material Design` styles using different
/// default values and the `Montserrat` font family.
///
/// These styles are included:
///
/// * `caption`
/// * `button`
/// * `body`
/// * `body2`
/// * `header5`
/// * `header6`
class LitSansSerifStyles {
  /// All fonts should be derived from this very package ('lit_ui_kit')
  static const String package = "lit_ui_kit";

  /// The default sans serif font family.
  static const String montserrat = "Montserrat";

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
    fontSize: 11.0,
    fontFamily: montserrat,
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
    fontSize: 14.0,
    fontFamily: montserrat,
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
    fontSize: 14.0,
    fontFamily: montserrat,
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
    fontSize: 16.0,
    fontFamily: montserrat,
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
    fontSize: 16.0,
    fontFamily: montserrat,
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
    fontSize: 20.0,
    fontFamily: montserrat,
    package: package,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.65,
  );
}
