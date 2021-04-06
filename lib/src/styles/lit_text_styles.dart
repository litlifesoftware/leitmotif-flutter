import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A collection of [TextStyle]s used throughout the LitSoftware apps.
///
/// The [TextStyle]s are able to be used as default value on the constructor
/// if required.
class LitTextStyles {
  /// All fonts should be derived from this very package ('lit_ui_kit')
  static const String package = "lit_ui_kit";

  /// The default sans serif font family.
  static const String sansSerifFontFamily = "Montserrat";

  /// The default serif font family.
  static const String serifFontFamily = "Merriweather";

  /// The default monospace font family.
  static const String monospaceFontFamily = "VT323";

  /// The default text color for all [TextStyle]s.
  static const Color defaultColor = LitColors.mediumGrey;

  static const double smallBodySize = 11.0;

  static const double smallerBodySize = 13.0;

  static const double defaultBodySize = 14.0;

  static const double defaultSubHeaderSize = 16.0;

  static const double defaultHeaderSize = 20.0;

  static const double veryTightSpacing = -0.70;

  static const double tighterSpacing = 0.0;

  static const double looseSpacing = 0.35;

  static const FontWeight lightWeight = FontWeight.w500;

  static const FontWeight bodyWeight = FontWeight.w600;

  static const FontWeight subHeaderWeight = FontWeight.w600;

  static const FontWeight headerWeight = FontWeight.w700;

  /// The default sans serif [TextStyle].
  static const TextStyle sansSerif = TextStyle(
    color: defaultColor,
    fontSize: defaultBodySize,
    fontFamily: sansSerifFontFamily,
    package: package,
    fontWeight: bodyWeight,
  );

  /// The default serif [TextStyle].
  static const TextStyle serif = TextStyle(
    color: defaultColor,
    fontSize: defaultBodySize,
    fontFamily: serifFontFamily,
    package: package,
    fontWeight: FontWeight.w500,
  );

  /// The default monospace [TextStyle].
  static const TextStyle monospace = TextStyle(
    color: defaultColor,
    fontSize: defaultBodySize,
    fontFamily: monospaceFontFamily,
    package: package,
  );

  static const TextStyle sansSerifBody = TextStyle(
    color: defaultColor,
    fontSize: defaultBodySize,
    fontFamily: sansSerifFontFamily,
    package: package,
    fontWeight: lightWeight,
  );

  static const TextStyle sansSerifBodyLargeSpacing = TextStyle(
    color: defaultColor,
    fontSize: defaultBodySize,
    fontFamily: sansSerifFontFamily,
    package: package,
    fontWeight: lightWeight,
    height: 1.30,
  );

  static const TextStyle sansSerifBodyTighter = TextStyle(
    color: defaultColor,
    fontSize: defaultBodySize,
    fontFamily: sansSerifFontFamily,
    package: package,
    fontWeight: bodyWeight,
    letterSpacing: tighterSpacing,
  );

  static const TextStyle sanSerifBodySmall = TextStyle(
    color: defaultColor,
    fontSize: smallBodySize,
    fontFamily: sansSerifFontFamily,
    package: package,
    fontWeight: lightWeight,
  );

  static const TextStyle sansSerifBodyTighterSmaller = TextStyle(
    color: defaultColor,
    fontSize: smallerBodySize,
    fontFamily: sansSerifFontFamily,
    package: package,
    fontWeight: bodyWeight,
    letterSpacing: tighterSpacing,
  );

  static const TextStyle sansSerifSmallHeader = TextStyle(
    color: defaultColor,
    fontSize: defaultBodySize,
    fontFamily: sansSerifFontFamily,
    package: package,
    fontWeight: headerWeight,
    letterSpacing: looseSpacing,
  );

  static const TextStyle sansSerifSubHeader = TextStyle(
    color: defaultColor,
    fontSize: defaultSubHeaderSize,
    fontFamily: sansSerifFontFamily,
    package: package,
    fontWeight: subHeaderWeight,
    letterSpacing: looseSpacing,
  );

  static const TextStyle sansSerifSubHeaderTighter = TextStyle(
    color: defaultColor,
    fontSize: defaultSubHeaderSize,
    fontFamily: sansSerifFontFamily,
    package: package,
    fontWeight: subHeaderWeight,
    letterSpacing: tighterSpacing,
  );

  static const TextStyle sansSerifHeader = TextStyle(
    color: defaultColor,
    fontSize: defaultHeaderSize,
    fontFamily: sansSerifFontFamily,
    package: package,
    fontWeight: headerWeight,
    letterSpacing: looseSpacing,
  );

  static const TextStyle sansSerifHeaderTighter = TextStyle(
    color: defaultColor,
    fontSize: defaultHeaderSize,
    fontFamily: sansSerifFontFamily,
    package: package,
    fontWeight: headerWeight,
    letterSpacing: tighterSpacing,
  );
}
