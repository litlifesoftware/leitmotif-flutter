import 'package:flutter/material.dart';
import 'package:leitmotif/styles.dart';

/// A Leitmotif `model` class storing data to provide required to build buttons.
class ActionButtonData {
  final String title;
  final Color accentColor;
  final Color backgroundColor;
  final void Function() onPressed;

  /// Creates a [ActionButtonData].
  const ActionButtonData({
    required this.title,
    this.accentColor = Colors.white,
    this.backgroundColor = LitColors.grey50,
    required this.onPressed,
  });
}
