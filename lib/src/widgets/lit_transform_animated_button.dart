import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class LitTransformAnimatedButton extends StatefulWidget {
  final Widget child;
  final void Function() onTap;
  final Color backgroundColor;
  final double verticalTransform;
  final double horizontalTransform;
  final Duration animationDuration;

  /// Creates a [TransformAnimationButton].
  ///
  /// The provided child [Widget] will be wrapped inside a
  /// styled and transformed button. Its [Animation] will be
  /// handled using its own [State] and [AnimationController].
  const LitTransformAnimatedButton({
    Key? key,
    required this.child,
    required this.onTap,
    required this.backgroundColor,
    required this.verticalTransform,
    required this.horizontalTransform,
    this.animationDuration = LitAnimationDurations.buttonRepeat,
  }) : super(key: key);
  @override
  _LitTransformAnimatedButtonState createState() =>
      _LitTransformAnimatedButtonState();
}

class _LitTransformAnimatedButtonState extends State<LitTransformAnimatedButton>
    with TickerProviderStateMixin {
  late AnimationController _animationContr;

  /// Returns an animated transform matrix.
  Matrix4 get _transform {
    final x = 1 - _animationContr.value * widget.horizontalTransform;
    final y = 1 - _animationContr.value * widget.verticalTransform;
    return Matrix4.translationValues(
      x,
      y,
      0,
    );
  }

  @override
  void initState() {
    super.initState();
    _animationContr = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat(
        reverse: true,
      );
  }

  @override
  void dispose() {
    _animationContr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationContr,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 64.0),
        child: LitPushedThroughButton(
          child: widget.child,
          onPressed: widget.onTap,
          backgroundColor: widget.backgroundColor,
          accentColor: widget.backgroundColor,
        ),
      ),
      builder: (context, child) {
        return Transform(
          transform: _transform,
          child: child,
        );
      },
    );
  }
}
