import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A collection of [TextStyle]s used throughout the LitSoftware apps.
///
/// The [TextStyle]s are able to be used as default value on the constructor
/// if required.
class LitTextStyles {
  /// All fonts should be derived from this package ('lit_ui_kit')
  static const String package = "lit_ui_kit";

  /// The default sans serif font family.
  static const String sansSerifFontFamily = "Montserrat";

  /// The default serif font family.
  static const String serifFontFamily = "Merriweather";

  /// The default monospace font family.
  static const String monospaceFontFamily = "VT323";

  /// The default text color for all [TextStyle]s.
  static const Color color = LitColors.mediumGrey;

  /// The default sans serif [TextStyle].
  static const TextStyle sansSerif = TextStyle(
    color: color,
    fontSize: 14.0,
    fontFamily: sansSerifFontFamily,
    package: package,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle sansSerifTitle = TextStyle(
    color: color,
    fontSize: 16.0,
    fontFamily: sansSerifFontFamily,
    package: package,
    fontWeight: FontWeight.w700,
  );

  /// The default serif [TextStyle].
  static const TextStyle serif = TextStyle(
    color: color,
    fontSize: 14.0,
    fontFamily: serifFontFamily,
    package: package,
    fontWeight: FontWeight.w500,
  );

  /// The default monospace [TextStyle].
  static const TextStyle monospace = TextStyle(
    color: color,
    fontSize: 14.0,
    fontFamily: monospaceFontFamily,
    package: package,
  );
}
