import 'package:flutter/material.dart';
import 'package:leitmotif/containers.dart';
import 'package:leitmotif/styles.dart';

/// A Leitmotif `buttons` widget displaying an interactive button, which will
/// be animated while being pressed.
class LitPushedThroughButton extends StatefulWidget {
  /// The button's child.
  final Widget child;

  /// The button's background color.
  final Color backgroundColor;

  /// The button's accent color.
  final Color accentColor;

  /// The button's border radius.
  final BorderRadius borderRadius;

  /// The button's external padding.
  final EdgeInsets padding;

  /// The button's internal margin.
  final EdgeInsets margin;

  /// The button's box shadow.
  final List<BoxShadow> boxShadow;

  /// The duration each animation cycle will last.
  final Duration animationDuration;

  /// States whether to disable the button.
  ///
  /// If so, the button is semi-transparent and the `onPressed` has no effect.
  final bool disabled;

  /// States whether to constrain the button.
  ///
  /// If the button is not constrained, it's width will fill the entire space
  /// available.
  final bool constrained;

  /// Handles the button's `onPressed` action.
  final void Function() onPressed;

  /// Create a [LitPushedThroughButton].
  const LitPushedThroughButton({
    Key? key,
    required this.child,
    this.backgroundColor = LitColors.grey100,
    this.accentColor = Colors.white,
    this.borderRadius = defaultBorderRadius,
    this.padding = defaultPadding,
    this.margin = defaultMargin,
    this.boxShadow = LitBoxShadows.md,
    this.animationDuration = defaultDuration,
    this.disabled = false,
    this.constrained = true,
    required this.onPressed,
  }) : super(key: key);

  static const defaultDuration = const Duration(milliseconds: 120);
  static const defaultPadding = const EdgeInsets.all(0.0);
  static const defaultMargin =
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0);
  static const defaultBorderRadius =
      const BorderRadius.all(const Radius.circular(16.0));

  @override
  _LitPushedThroughButtonState createState() => _LitPushedThroughButtonState();
}

class _LitPushedThroughButtonState extends State<LitPushedThroughButton>
    with TickerProviderStateMixin {
  /// States whether or not the button is currently pressed.
  bool _isPressed = false;

  /// The [AnimationController] responsible for the button animation.
  late AnimationController _animationController;

  /// Handles the `onPressed` action by playing the animation and executing the
  /// provided callback method.
  void _onPressed() {
    if (!widget.disabled) {
      try {
        setState(() {
          _isPressed = true;
        });
        _animationController
            .forward(from: 0)
            .then(
              (value) => _animationController.reverse(),
            )
            .then(
              (value) => setState(
                () {
                  _isPressed = false;
                },
              ),
            );
      } catch (e) {
        _isPressed = false;
      }
      widget.onPressed();
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: widget.constrained
              ? constraints
              : BoxConstraints(
                  minWidth: constraints.maxWidth,
                ),
          child: Padding(
            padding: widget.padding,
            child: CleanInkWell(
              onTap: _onPressed,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return _AnimatedButtonContent(
                    accentColor: widget.accentColor,
                    animationController: _animationController,
                    backgroundColor: widget.backgroundColor,
                    borderRadius: widget.borderRadius,
                    boxShadow: widget.boxShadow,
                    disabled: widget.disabled,
                    isPressed: _isPressed,
                    child: widget.child,
                    margin: widget.margin,
                    duration: widget.animationDuration,
                  );
                },
                child: _AnimatedButtonContent(
                  accentColor: widget.accentColor,
                  animationController: _animationController,
                  backgroundColor: widget.backgroundColor,
                  borderRadius: widget.borderRadius,
                  boxShadow: widget.boxShadow,
                  disabled: widget.disabled,
                  isPressed: _isPressed,
                  child: widget.child,
                  margin: widget.margin,
                  duration: widget.animationDuration,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// The [LitPushedThroughButton]'s animated content.
class _AnimatedButtonContent extends StatelessWidget {
  final AnimationController animationController;
  final bool disabled;
  final bool isPressed;
  final Color accentColor;
  final Color backgroundColor;
  final List<BoxShadow> boxShadow;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final Widget child;
  final Duration duration;
  const _AnimatedButtonContent({
    Key? key,
    required this.animationController,
    required this.disabled,
    required this.isPressed,
    required this.accentColor,
    required this.backgroundColor,
    required this.boxShadow,
    required this.margin,
    required this.borderRadius,
    required this.child,
    required this.duration,
  }) : super(key: key);

  /// The animated scale.
  double get _scale {
    return (1 - (animationController.value * 0.050));
  }

  /// The animated opacity.
  double get _opacity {
    return disabled ? 0.2 : 1.0;
  }

  /// The animated colors.
  List<Color> get _animatedColors {
    return [
      Color.lerp(backgroundColor, accentColor, 0.35)!,
      Color.lerp(backgroundColor, accentColor, 0.45)!,
      Color.lerp(backgroundColor, accentColor, 0.55)!,
      backgroundColor,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _scale,
      child: Opacity(
        opacity: _opacity,
        child: AnimatedContainer(
          duration: duration,
          padding: margin,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:
                  isPressed ? _animatedColors : [accentColor, backgroundColor],
            ),
            boxShadow: boxShadow,
          ),
          child: child,
        ),
      ),
    );
  }
}
