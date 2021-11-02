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
    this.borderRadius = LitBorderRadius.button,
    this.padding = LitEdgeInsets.none,
    this.margin = LitEdgeInsets.button,
    this.boxShadow = LitBoxShadows.md,
    this.animationDuration = LitAnimationDurations.button,
    this.disabled = false,
    this.constrained = true,
    required this.onPressed,
  }) : super(key: key);

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

  /// Returns an animated scale.
  double get _scale => (1 - (_animationController.value * 0.050));

  /// Returns an animated opacity.
  double get _opacity {
    return widget.disabled ? 0.2 : (1.0 - (0.5 * _animationController.value));
  }

  /// Returns a list of animated colors.
  List<Color> get _animatedColors {
    return [
      Color.lerp(widget.backgroundColor, widget.accentColor, 0.35)!,
      Color.lerp(widget.backgroundColor, widget.accentColor, 0.45)!,
      Color.lerp(widget.backgroundColor, widget.accentColor, 0.55)!,
      widget.backgroundColor,
    ];
  }

  /// Returns a list of static colors.
  List<Color> get _colors => [widget.accentColor, widget.backgroundColor];

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
                child: Container(
                  padding: widget.margin,
                  decoration: BoxDecoration(
                    borderRadius: widget.borderRadius,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _isPressed ? _animatedColors : _colors,
                    ),
                    boxShadow: widget.boxShadow,
                  ),
                  child: widget.child,
                ),
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scale,
                    child: AnimatedOpacity(
                      duration: widget.animationDuration,
                      opacity: _opacity,
                      child: child,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
