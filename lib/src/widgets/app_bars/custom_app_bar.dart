import 'package:flutter/material.dart';
import 'package:leitmotif/styles.dart';

/// A Leitmotif `app_bars` abstract widget allowing to implement custom app
/// bars using default styling.
abstract class CustomAppBar extends Widget {
  /// The default height.
  static const double height = 56.0;

  /// The default text style applied on titled app bars.
  static const TextStyle textStyle = LitSansSerifStyles.subtitle2;

  /// The default margin.
  static const EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 16.0);

  /// The default box shadow.
  static const List<BoxShadow> boxShadow = LitBoxShadows.appBar;

  /// The offset required to trigger the `disappear` animation on animated
  /// app bars.
  static const double requiredOffset = 16.0;
}
