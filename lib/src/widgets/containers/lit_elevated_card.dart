import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A widget combining layout dependent box constraints and box shadow painting.
///
/// It's box constraints are set using the [landscapeWidthFactor] to reduce the
/// overall size of the container once the device orientation has been changed to
/// landscape.
class LitElevatedCard extends StatelessWidget {
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double landscapeWidthFactor;
  final BorderRadius borderRadius;
  final Color backgroundColor;

  /// The box shadow of the card.
  final List<BoxShadow> boxShadow;

  /// The child widget wrapped by the card.
  final Widget child;
  const LitElevatedCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 14.0,
    ),
    this.margin = const EdgeInsets.symmetric(
      horizontal: 18.0,
      vertical: 12.0,
    ),
    this.landscapeWidthFactor = 0.60,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(
        20.0,
      ),
    ),
    this.boxShadow = const [
      const BoxShadow(
        blurRadius: 6.0,
        color: Colors.black26,
        offset: Offset(-3.0, 2.0),
        spreadRadius: 0.0,
      )
    ],
    this.backgroundColor = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LitConstrainedSizedBox(
      landscapeWidthFactor: landscapeWidthFactor,
      child: Padding(
        padding: padding,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: boxShadow,
            color: backgroundColor,
          ),
          child: Padding(
            padding: margin,
            child: child,
          ),
        ),
      ),
    );
  }
}
