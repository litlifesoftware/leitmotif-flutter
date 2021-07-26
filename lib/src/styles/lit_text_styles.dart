import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

const int caption = 0;
const int button = 1;
const int body = 2;
const int body2 = 3;
const int header5 = 4;
const int header6 = 5;

/// The default text color for all [TextStyle]s.
const Color defaultColor = LitColors.mediumGrey;

const double smallBodySize = 11.0;

const double smallerBodySize = 13.0;

const double defaultBodySize = 14.0;

const double captionFontSize = 11.0;

const double buttonTextFontSize = 14.0;

const double defaultSubHeaderSize = 16.0;

const double defaultHeaderSize = 20.0;

const double veryTightSpacing = -0.70;

const double tighterSpacing = 0.0;

const double looseSpacing = 0.65;

const FontWeight light = FontWeight.w500;

const FontWeight regular = FontWeight.w600;

const FontWeight bold = FontWeight.w700;

const FontWeight black = FontWeight.w800;

/// A collection of [TextStyle]s used throughout the LitSoftware apps.
///
/// The [TextStyle]s are able to be used as default value on the constructor
/// if required.
class LitTextStyles {
  /// All fonts should be derived from this very package ('leitmotif')
  static const String package = "leitmotif";

  /// The default sans serif font family.
  static const String montserrat = "Montserrat";

  /// The default serif font family.
  static const String serifFontFamily = "Merriweather";

  /// The default monospace font family.
  static const String monospaceFontFamily = "VT323";

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
    fontWeight: light,
  );

  static const TextStyle sansSerifBodyLargeSpacing = TextStyle(
    color: defaultColor,
    fontSize: defaultBodySize,
    fontFamily: montserrat,
    package: package,
    fontWeight: light,
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
    fontWeight: light,
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
    fontWeight: regular,
    letterSpacing: looseSpacing,
  );

  static const TextStyle sansSerifSubHeaderTighter = TextStyle(
    color: defaultColor,
    fontSize: defaultSubHeaderSize,
    fontFamily: montserrat,
    package: package,
    fontWeight: regular,
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

  /// A [List] of available sans serif styles. To select a specific style, use
  /// the `caption`,`button`, `body`, `body2`, `header5` and `header6`
  /// indicators as index value.
  static const List<TextStyle> sansSerifStyles = [
    // Caption [0]
    const TextStyle(
      color: defaultColor,
      fontSize: captionFontSize,
      fontFamily: montserrat,
      package: package,
      fontWeight: regular,
    ),

    // Button [1]
    const TextStyle(
      color: defaultColor,
      fontSize: buttonTextFontSize,
      fontFamily: montserrat,
      package: package,
      fontWeight: bold,
      letterSpacing: looseSpacing,
    ),

    // Body [2]
    const TextStyle(
      color: defaultColor,
      fontSize: defaultBodySize,
      fontFamily: montserrat,
      package: package,
      fontWeight: regular,
    ),

    // Body 2 [3]
    const TextStyle(
      color: defaultColor,
      fontSize: defaultSubHeaderSize,
      fontFamily: montserrat,
      package: package,
      fontWeight: regular,
      letterSpacing: looseSpacing,
    ),

    // Header 5 [4]
    const TextStyle(
      color: defaultColor,
      fontSize: defaultSubHeaderSize,
      fontFamily: montserrat,
      package: package,
      fontWeight: regular,
      letterSpacing: looseSpacing,
    ),

    // Header 6 [5]
    const TextStyle(
      color: defaultColor,
      fontSize: defaultHeaderSize,
      fontFamily: montserrat,
      package: package,
      fontWeight: bold,
      letterSpacing: looseSpacing,
    ),
  ];
}
