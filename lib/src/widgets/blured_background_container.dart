import 'dart:ui';

import 'package:flutter/material.dart';

class BluredBackgroundContainer extends StatelessWidget {
  final Widget child;
  final double blurRadius;
  final BorderRadius borderRadius;

  /// Creates a [BluredBackgroundContainer] [Widget].
  ///
  /// It blurs the provided [child] by applying an [ImageFilter].
  /// The [blurRadius] will control the blur effect.
  const BluredBackgroundContainer({
    Key? key,
    required this.child,
    this.blurRadius = 2.0,
    this.borderRadius: BorderRadius.zero,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurRadius, sigmaY: blurRadius),
        child: child,
      ),
    );
  }
}
