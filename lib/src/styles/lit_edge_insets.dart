import 'package:flutter/material.dart';

/// A Leitmotif `styles` class containing edge insets for various use cases.
class LitEdgeInsets {
  /// No margin applied.
  static const none = const EdgeInsets.all(0.0);

  /// The default margin applied on dialogs.
  static const dialogMargin = const EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 8.0,
  );

  /// The default margin applied on card widgets.
  static const card = const EdgeInsets.symmetric(
    vertical: 16.0,
    horizontal: 16.0,
  );

  /// The default margin applied on button widgets.
  static const button = const EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 14.0,
  );

  /// The default margin applied on small button widgets.
  static const buttonSM = const EdgeInsets.symmetric(
    vertical: 2.0,
    horizontal: 8.0,
  );

  /// The default margin to add spacing on the top of widgets.
  static const spacingTop = const EdgeInsets.only(top: 16.0);
}
