import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `buttons` widget allowing to display an animated button on a
/// on a stack view.
class AnimatedActionButton extends StatefulWidget
    implements CustomActionButton {
  /// The button's child.
  final Widget child;

  /// The button's aligment relative to the screen or the surrounding
  /// stack view.
  final Alignment alignment;

  /// The button's background color.
  final Color backgroundColor;

  /// The button's outer padding.
  final EdgeInsets padding;

  /// The button's inner margin.
  final EdgeInsets margin;

  /// The animation's duration.
  final Duration animationDuration;

  /// Handles the button's `onPressed` action.
  final void Function() onPressed;

  /// Creates an [AnimatedActionButton].
  const AnimatedActionButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.alignment = Alignment.bottomRight,
    this.backgroundColor = Colors.white,
    this.padding = defaultPadding,
    this.margin = defaultMargin,
    this.animationDuration = defaultAnimationDuration,
  }) : super(key: key);

  /// The [AnimatedActionButton]'s default animation duration.
  static const defaultAnimationDuration = const Duration(
    milliseconds: 250,
  );

  /// The [AnimatedActionButton]'s default margin.
  static const defaultMargin = const EdgeInsets.symmetric(
    horizontal: 4.0,
    vertical: 0.0,
  );

  /// The [AnimatedActionButton]'s default padding.
  static const defaultPadding = const EdgeInsets.symmetric(
    vertical: LitBottomNavigation.defaultHeight + 8.0,
    horizontal: 32.0,
  );

  @override
  _AnimatedActionButtonState createState() => _AnimatedActionButtonState();
}

class _AnimatedActionButtonState extends State<AnimatedActionButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  /// Returns an animated transform matrix.
  Matrix4 get _transform {
    return Matrix4.translationValues(
        0, 50 * (1 - _animationController.value), 0);
  }

  /// Returns an animated scale value.
  double get _scale {
    return 0.25 + (_animationController.value * 0.75);
  }

  /// The animated opacity.
  double get _opacity => 0.25 + (0.75 * _animationController.value);

  /// States the max vertical transform offset while the animation is playing.
  final double _verticalTransformOffset = 15.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Align(
        alignment: widget.alignment,
        child: Padding(
          padding: widget.padding,
          child: LitTransformAnimatedButton(
            verticalTransform: _verticalTransformOffset,
            horizontalTransform: 0.0,
            child: Padding(
              padding: widget.margin,
              child: widget.child,
            ),
            backgroundColor: widget.backgroundColor,
            onTap: widget.onPressed,
          ),
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        return AnimatedOpacity(
          opacity: _opacity,
          duration: _animationController.duration!,
          child: Transform(
            transform: _transform,
            child: Transform.scale(
              scale: _scale,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
