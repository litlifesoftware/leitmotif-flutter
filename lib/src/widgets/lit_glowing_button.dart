import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `buttons` widget displaying a custom-styled action button.
///
/// The default styling will create a pink-glow effect on a pink-colored
/// background.
class LitGlowingButton extends StatelessWidget {
  /// The button's background color.
  final Color backgroundColor;

  /// The button's accent color.
  final Color accentColor;

  /// The button's inner margin.
  final EdgeInsets margin;

  /// The button's border radius.
  final BorderRadius borderRadius;

  /// The button's box shadow offset.
  final Offset boxOffset;

  /// The button's child widget.
  final Widget child;

  /// Handles the `onPressed` action.
  final void Function() onPressed;

  /// Creates a [LitGlowingButton].
  const LitGlowingButton({
    Key? key,
    required this.onPressed,
    this.backgroundColor = LitColors.red580,
    this.accentColor = LitColors.grey380,
    required this.child,
    this.margin = LitEdgeInsets.button,
    this.borderRadius = LitBorderRadius.button,
    this.boxOffset = const Offset(2.0, 2.0),
  }) : super(key: key);

  /// Returns an interpolated background color based on the provided base
  /// background color and the [accentColor].
  Color? get _lerpedBackground => Color.lerp(
        backgroundColor,
        accentColor,
        0.4,
      );

  BoxShadow get _base => BoxShadow(
        blurRadius: 8.0,
        offset: Offset(-boxOffset.dx, -boxOffset.dy),
        color: _lerpedBackground!.withOpacity(0.4),
        spreadRadius: 1.0,
      );
  BoxShadow get _accent => BoxShadow(
        blurRadius: 8.0,
        offset: boxOffset,
        color: _lerpedBackground!.withOpacity(0.7),
        spreadRadius: 1.0,
      );
  @override
  Widget build(BuildContext context) {
    return LitPushedButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            _base,
            _accent,
          ],
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.0, 0.95],
            colors: [backgroundColor, accentColor],
          ),
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: margin,
          child: child,
        ),
      ),
    );
  }
}
