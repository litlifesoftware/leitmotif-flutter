import 'package:flutter/material.dart';

/// A Leitmotif `styles` class containing edge insets for various use cases.
class LitEdgeInsets {
  /// No margin/padding applied.
  static const none = const EdgeInsets.all(0.0);

  /// The default margin/padding applied on dialogs.
  static const dialogMargin = const EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 8.0,
  );

  /// The default margin/padding applied on screen widgets.
  static const screen = const EdgeInsets.symmetric(
    vertical: 16.0,
    horizontal: 16.0,
  );

  /// The default margin/padding applied on card widgets.
  static const allS = const EdgeInsets.symmetric(
    vertical: 16.0,
    horizontal: 16.0,
  );

  /// The default margin/padding applied on card widgets.
  static const card = const EdgeInsets.symmetric(
    vertical: 16.0,
    horizontal: 16.0,
  );

  /// The default margin/padding applied on button widgets.
  static const button = const EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 14.0,
  );

  /// The default margin/padding applied on small button widgets.
  static const buttonSM = const EdgeInsets.symmetric(
    vertical: 2.0,
    horizontal: 8.0,
  );

  /// The default margin/padding to add spacing on the top of widgets.
  static const spacingTop = const EdgeInsets.only(top: 16.0);

  /// The default margin/padding to add spacing on the top and bottom widgets.
  static const spacingY = const EdgeInsets.symmetric(vertical: 16.0);
}
