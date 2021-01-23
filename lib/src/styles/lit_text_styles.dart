import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A collection of [TextStyle]s used throughout the LitSoftware apps.
///
/// The [TextStyle]s are able to be used as default value on the constructor
/// if required.
class LitTextStyles {
  static const TextStyle sansSerif = TextStyle(
    color: LitColors.mediumGrey,
    fontSize: 14.0,
    fontFamily: "Montserrat",
    package: "lit_ui_kit",
    fontWeight: FontWeight.w600,
  );

  static const TextStyle serif = TextStyle(
    color: LitColors.mediumGrey,
    fontSize: 14.0,
    fontFamily: "Merriweather",
    package: "lit_ui_kit",
    fontWeight: FontWeight.w500,
  );

  static const TextStyle monospace = TextStyle(
    color: LitColors.mediumGrey,
    fontSize: 14.0,
    fontFamily: "VT323",
    package: "lit_ui_kit",
  );
}
