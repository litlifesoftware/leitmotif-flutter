import 'package:flutter/material.dart';
import 'package:leitmotif/styles.dart';

/// A Leitmotif `model` class storing data to provide required to build buttons.
class ActionButtonData {
  // TODO: Rename to 'label'.
  final String title;
  final TextStyle style;
  final IconData? icon;
  final Color accentColor;
  final Color backgroundColor;
  final bool disabled;
  final void Function() onPressed;

  /// Creates a [ActionButtonData].
  const ActionButtonData({
    required this.title,
    this.icon,
    this.style = LitSansSerifStyles.button,
    this.accentColor = Colors.white,
    this.backgroundColor = LitColors.grey50,
    this.disabled = false,
    required this.onPressed,
  });
}
