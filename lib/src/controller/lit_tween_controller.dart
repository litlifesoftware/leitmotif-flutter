import 'package:flutter/material.dart';

/// A Leitmotif `controller` class allowing to create custom tween animations
/// to animate list view transforms.
class LitTweenController {
  /// The animation controller controlling the animation.
  final AnimationController animationController;

  /// Creates a [LitTweenController].
  const LitTweenController(this.animationController);

  /// Calculates a tween [Animation] based on the provided list index.
  Animation calcTweenAnimation(int index, int max) {
    return Tween<double>(
      begin: 1 - (index / max),
      end: 1.0,
    ).animate(
      animationController,
    );
  }

  /// Calculates a tween opacity based on the iterated provided index.
  double calcTweenOpacity(int index, int max) {
    return calcTweenAnimation(index, max).value;
  }

  /// Creates a list view transform animation using the provided values.
  ///
  /// Returns the generated vertices as a [Matrix4].
  Matrix4 listItemTransform(int index, int max,
      {double x = 0, double y = 0, double z = 0}) {
    return Matrix4.translationValues(
      x != 0 ? -x + (x * calcTweenAnimation(index, max).value) : 0,
      y != 0 ? -y + (y * calcTweenAnimation(index, max).value) : 0,
      z != 0 ? -z + (z * calcTweenAnimation(index, max).value) : 0,
    );
  }
}
