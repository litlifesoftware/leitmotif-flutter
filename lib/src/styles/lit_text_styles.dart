import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

const int caption = 0;
const int button = 1;
const int body = 3;
const int body2 = 4;
const int header5 = 5;
const int header6 = 6;

/// A collection of [TextStyle]s used throughout the LitSoftware apps.
///
/// The [TextStyle]s are able to be used as default value on the constructor
/// if required.
class LitTextStyles {
  /// All fonts should be derived from this very package ('lit_ui_kit')
  static const String package = "lit_ui_kit";

  /// The default sans serif font family.
  static const String montserrat = "Montserrat";

  /// The default serif font family.
  static const String serifFontFamily = "Merriweather";

  /// The default monospace font family.
  static const String monospaceFontFamily = "VT323";

  /// The default text color for all [TextStyle]s.
  static const Color defaultColor = LitColors.mediumGrey;

  static const double smallBodySize = 11.0;

  static const double smallerBodySize = 13.0;

  static const double defaultBodySize = 14.0;

  static const double captionFontSize = 11.0;

  static const double buttonTextFontSize = 14.0;

  static const double defaultSubHeaderSize = 16.0;

  static const double defaultHeaderSize = 20.0;

  static const double veryTightSpacing = -0.70;

  static const double tighterSpacing = 0.0;

  static const double looseSpacing = 0.65;

  static const FontWeight lightWeight = FontWeight.w500;

  static const FontWeight regular = FontWeight.w600;

  static const FontWeight semiBold = FontWeight.w600;

  static const FontWeight bold = FontWeight.w700;

  /// The default sans serif [TextStyle].
  static const TextStyle sansSerif = TextStyle(
    color: defaultColor,
    fontSize: defaultBodySize,
    fontFamily: montserrat,
    package: package,
    fontWeight: regular,
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
    fontFamily: montserrat,
    package: package,
    fontWeight: lightWeight,
  );

  static const TextStyle sansSerifBodyLargeSpacing = TextStyle(
    color: defaultColor,
    fontSize: defaultBodySize,
    fontFamily: montserrat,
    package: package,
    fontWeight: lightWeight,
    height: 1.30,
  );

  static const TextStyle sansSerifBodyTighter = TextStyle(
    color: defaultColor,
    fontSize: defaultBodySize,
    fontFamily: montserrat,
    package: package,
    fontWeight: regular,
    letterSpacing: tighterSpacing,
  );

  static const TextStyle sanSerifBodySmall = TextStyle(
    color: defaultColor,
    fontSize: smallBodySize,
    fontFamily: montserrat,
    package: package,
    fontWeight: lightWeight,
  );

  static const TextStyle sansSerifBodyTighterSmaller = TextStyle(
    color: defaultColor,
    fontSize: smallerBodySize,
    fontFamily: montserrat,
    package: package,
    fontWeight: regular,
    letterSpacing: tighterSpacing,
  );

  static const TextStyle sansSerifSmallHeader = TextStyle(
    color: defaultColor,
    fontSize: defaultBodySize,
    fontFamily: montserrat,
    package: package,
    fontWeight: bold,
    letterSpacing: looseSpacing,
  );

  static const TextStyle sansSerifSubHeader = TextStyle(
    color: defaultColor,
    fontSize: defaultSubHeaderSize,
    fontFamily: montserrat,
    package: package,
    fontWeight: semiBold,
    letterSpacing: looseSpacing,
  );

  static const TextStyle sansSerifSubHeaderTighter = TextStyle(
    color: defaultColor,
    fontSize: defaultSubHeaderSize,
    fontFamily: montserrat,
    package: package,
    fontWeight: semiBold,
    letterSpacing: tighterSpacing,
  );

  static const TextStyle sansSerifHeader = TextStyle(
    color: defaultColor,
    fontSize: defaultHeaderSize,
    fontFamily: montserrat,
    package: package,
    fontWeight: bold,
    letterSpacing: looseSpacing,
  );

  static const TextStyle sansSerifHeaderTighter = TextStyle(
    color: defaultColor,
    fontSize: defaultHeaderSize,
    fontFamily: montserrat,
    package: package,
    fontWeight: bold,
    letterSpacing: tighterSpacing,
  );

  static const List<TextStyle> sansSerifStyles = [
    // Caption [0]
    TextStyle(
      color: defaultColor,
      fontSize: captionFontSize,
      fontFamily: montserrat,
      package: package,
      fontWeight: regular,
    ),

    // Button [1]
    TextStyle(
      color: defaultColor,
      fontSize: buttonTextFontSize,
      fontFamily: montserrat,
      package: package,
      fontWeight: bold,
      letterSpacing: looseSpacing,
    ),

    // Body [2]
    TextStyle(
      color: defaultColor,
      fontSize: defaultBodySize,
      fontFamily: montserrat,
      package: package,
      fontWeight: bold,
      letterSpacing: looseSpacing,
    ),

    // Body 2 [3]
    TextStyle(
      color: defaultColor,
      fontSize: defaultSubHeaderSize,
      fontFamily: montserrat,
      package: package,
      fontWeight: semiBold,
      letterSpacing: looseSpacing,
    ),

    // Header 5 [4]
    TextStyle(
      color: defaultColor,
      fontSize: defaultSubHeaderSize,
      fontFamily: montserrat,
      package: package,
      fontWeight: semiBold,
      letterSpacing: looseSpacing,
    ),

    // Header 6 [5]
    TextStyle(
      color: defaultColor,
      fontSize: defaultHeaderSize,
      fontFamily: montserrat,
      package: package,
      fontWeight: bold,
      letterSpacing: looseSpacing,
    ),
  ];
}
