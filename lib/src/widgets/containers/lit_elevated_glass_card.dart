import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A widget to display an blurred and elevated background.
///
/// For being blurred, the background should be semi-transparent. But for being elevated, the
/// background should be solid. To achieve both, a semi transparent, blurred background is stacked
/// on top of a solid, elevated background. This will require to provide a middle layer in order
/// to apply the blur effect ([middleLayer]).
class LitElevatedGlassCard extends StatelessWidget {
  /// The card's padding.
  final EdgeInsets padding;

  /// The card's border radius.
  final BorderRadius borderRadius;

  /// The card's child.
  final Widget child;

  /// The widget to apply the blur effect on.
  final Widget middleLayer;

  /// The card's transformation. This may also be set using an animation.
  final Matrix4 transform;
  final List<BoxShadow> boxShadow;

  /// Creates a [LitElevatedGlassCard].
  ///
  /// * [padding] is the padding applied to the card.
  ///
  /// * [borderRadius] is the card's border radius.
  ///
  /// * [child] is the child widget displayed in the card.
  ///
  /// * [middleLayer] is the layer on which the blur effect is applied.
  ///
  /// * [transform] is the matrix transformation applied to the cards. The transformation will
  ///   not be applied on the [middleLayer].
  ///
  /// * [boxShadow] is shadow on the card's background.
  const LitElevatedGlassCard({
    Key? key,
    required this.padding,
    required this.borderRadius,
    required this.child,
    this.middleLayer = const SizedBox(),
    required this.transform,
    this.boxShadow = const [
      BoxShadow(
        blurRadius: 10.0,
        color: Colors.black38,
        offset: Offset(-4.0, 2.0),
        spreadRadius: -2.0,
      )
    ],
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform(
          transform: transform,
          child: Padding(
            padding: padding,
            child: Align(
              alignment: Alignment.center,
              child: LitElevatedCard(
                margin: const EdgeInsets.all(0.0),
                padding: const EdgeInsets.all(0.0),
                backgroundColor: Colors.white,
                borderRadius: borderRadius,
                boxShadow: boxShadow,
                child: Opacity(
                  opacity: 0.0,
                  child: child,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: middleLayer,
        ),
        Transform(
          transform: transform,
          child: Padding(
            padding: padding,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: Colors.white54,
                ),
                child: BluredBackgroundContainer(
                  blurRadius: 8.0,
                  borderRadius: borderRadius,
                  child: LitElevatedCard(
                    margin: const EdgeInsets.all(0.0),
                    padding: const EdgeInsets.all(0.0),
                    backgroundColor: Colors.transparent,
                    boxShadow: [],
                    borderRadius: borderRadius,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
