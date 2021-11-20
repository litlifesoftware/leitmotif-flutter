import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `button` widget allowing to either navigate back or forth on a
/// calendar view.
class LitNavigationButton extends StatelessWidget {
  final LitLinearNavigationMode mode;
  final EdgeInsets padding;
  final Color backgroundAccentColor;
  final void Function() onPressed;

  /// Creates a [LitNavigationButton].
  const LitNavigationButton({
    Key? key,
    required this.mode,
    this.padding = const EdgeInsets.symmetric(
      vertical: 4.0,
      horizontal: 2.0,
    ),
    this.backgroundAccentColor = LitColors.grey50,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitPushedThroughButton(
      boxShadow: LitBoxShadows.xs,
      accentColor: backgroundAccentColor,
      padding: padding,
      onPressed: onPressed,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: LinearNavigationIcon(
          mode: mode,
        ),
      ),
    );
  }
}
