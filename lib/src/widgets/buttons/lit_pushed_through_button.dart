import 'package:flutter/material.dart';

/// A button which will be animated on pressing it.
///
/// The button will scale down and up while it is being pressed to give visual
/// feedback while the user interacts with it. The animation will make the button
/// look like it is going back and forth on the screen.
class LitPushedThroughButton extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final Color accentColor;
  final void Function() onPressed;
  final double borderRadius;
  final EdgeInsets margin;
  final List<BoxShadow> boxShadow;
  final Duration animationDuration;

  final bool disabled;

  /// Create a [PushedThroughButton] [Widget].
  const LitPushedThroughButton({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.accentColor = Colors.grey,
    required this.onPressed,
    this.borderRadius = 15.0,
    this.margin = const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 14.0,
    ),
    this.boxShadow = const [
      const BoxShadow(
        blurRadius: 8.0,
        offset: Offset(-4, 4),
        color: Colors.black26,
        spreadRadius: 1.0,
      ),
    ],
    this.animationDuration = const Duration(
      milliseconds: 400,
    ),
    this.disabled = false,
  }) : super(key: key);

  @override
  _LitPushedThroughButtonState createState() => _LitPushedThroughButtonState();
}

class _LitPushedThroughButtonState extends State<LitPushedThroughButton>
    with TickerProviderStateMixin {
  /// States whether or not the button is currently pressed.
  /// It will not be pressed by default.
  late bool _isPressed;

  /// The [AnimationController] responsible for the button animation.
  late AnimationController _animationController;

  /// Handles the actions once the button is pressed down by the user.
  ///
  /// Set the state to indicate the button is pressed, animate it and
  /// execute the actual callback [Function] provided.
  void _onTapDown(PointerDownEvent details) {
    try {
      setState(() {
        _isPressed = true;
      });
      _animationController.forward(from: 0);
    } catch (e) {
      _isPressed = true;
    }
    if (!widget.disabled) {
      widget.onPressed();
    }
  }

  /// Handles the actions once the button is pressed up by the user.
  ///
  /// Set the state to indicate the button is not pressed and play the
  /// animation in reverse.
  void _onTapUp(PointerUpEvent details) {
    try {
      setState(() {
        _isPressed = false;
      });
      _animationController.reverse(from: 1);
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    _isPressed = false;
    _animationController =
        AnimationController(duration: widget.animationDuration, vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onTapDown,
      onPointerUp: _onTapUp,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: (1 - (_animationController.value * 0.125)),
            child: Opacity(
              opacity: widget.disabled ? 0.2 : 1.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: widget.margin,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _isPressed
                            ? widget.backgroundColor
                            : Color.lerp(widget.backgroundColor,
                                widget.accentColor, 0.35)!,
                        _isPressed
                            ? Color.lerp(widget.backgroundColor,
                                widget.accentColor, 0.45)!
                            : widget.backgroundColor,
                        _isPressed
                            ? Color.lerp(widget.backgroundColor,
                                widget.accentColor, 0.55)!
                            : widget.backgroundColor,
                        Color.lerp(
                          widget.backgroundColor,
                          widget.backgroundColor,
                          _isPressed ? 0.20 : 0.50,
                        )!,
                      ],
                      stops: [
                        0.0,
                        0.3,
                        0.6,
                        1.0,
                      ]),
                  boxShadow: _isPressed ? [] : widget.boxShadow,
                ),
                child: widget.child,
              ),
            ),
          );
        },
      ),
    );
  }
}
