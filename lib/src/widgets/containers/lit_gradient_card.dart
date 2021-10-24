import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A widget combining layout dependent box constraints and gradient style painting.
///
/// It's box constraints are set using the [landscapeWidthFactor] to reduce the
/// overall size of the container once the device orientation has been changed to
/// landscape.
class LitGradientCard extends StatelessWidget {
  /// The outer spacing. Defaults to an empty padding.
  final EdgeInsets padding;

  /// The inner spacing. Defaults to an empty margin.
  final EdgeInsets margin;

  /// The factor on which the landscape width will be determined. Defaults to `0.6`.
  final double landscapeWidthFactor;

  /// The box shadow of the card.
  final List<BoxShadow> boxShadow;

  /// The border radius of the card.
  final BorderRadius borderRadius;

  /// The gradient's begin alignment.
  final Alignment begin;

  /// The gradient's end alignment.
  final Alignment end;

  /// The gradient's colors.
  final List<Color> colors;

  /// The child widget wrapped by the card.
  final Widget? child;

  /// Creates a [LitGradientCard].
  ///
  /// Pass a [padding] and [margin] object to create spacing outside and inside the
  /// card. The [landscapeWidthFactor] should be set to `1.0` if there should be no
  /// difference between landscape and portrait mode layouting.
  const LitGradientCard({
    Key? key,
    this.padding = const EdgeInsets.all(0.0),
    this.margin = const EdgeInsets.all(0.0),
    this.landscapeWidthFactor = 0.60,
    this.boxShadow = const [
      const BoxShadow(
        blurRadius: 4.0,
        color: Colors.black26,
        offset: Offset(-2, 2.0),
        spreadRadius: 1.0,
      )
    ],
    this.borderRadius = const BorderRadius.all(
      Radius.circular(
        22.0,
      ),
    ),
    this.begin = Alignment.topRight,
    this.end = Alignment.bottomLeft,
    this.colors = const [
      Colors.white,
      LitColors.grey50,
    ],
    this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LitConstrainedSizedBox(
      landscapeWidthFactor: landscapeWidthFactor,
      child: Padding(
        padding: padding,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: boxShadow,
            borderRadius: borderRadius,
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: colors,
            ),
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
