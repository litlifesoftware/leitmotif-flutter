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

  /// Create a [PushedThroughButton] [Widget].
  const LitPushedThroughButton({
    Key key,
    @required this.child,
    @required this.backgroundColor,
    @required this.accentColor,
    @required this.onPressed,
    this.borderRadius = 15,
  }) : super(key: key);

  @override
  _LitPushedThroughButtonState createState() => _LitPushedThroughButtonState();
}

class _LitPushedThroughButtonState extends State<LitPushedThroughButton>
    with TickerProviderStateMixin {
  /// States whether or not the button is currently pressed.
  /// It will not be pressed by default.
  bool _isPressed;

  /// The [AnimationController] responsible for the button animation.
  AnimationController _animationController;

  /// Handles the actions once the button is pressed down by the user.
  ///
  /// Set the state to indicate the button is pressed, animate it and
  /// execute the actual callback [Function] provided.
  void _onTapDown(PointerDownEvent details) {
    setState(() {
      _isPressed = true;
    });
    _animationController.forward(from: 0);
    widget.onPressed();
  }

  /// Handles the actions once the button is pressed up by the user.
  ///
  /// Set the state to indicate the button is not pressed and play the
  /// animation in reverse.
  void _onTapUp(PointerUpEvent details) {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse(from: 1);
  }

  @override
  void initState() {
    super.initState();
    _isPressed = false;
    _animationController = AnimationController(
        duration: Duration(
          milliseconds: 400,
        ),
        vsync: this);
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
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _isPressed
                              ? widget.backgroundColor
                              : Color.lerp(widget.backgroundColor,
                                  widget.accentColor, 0.1),
                          _isPressed
                              ? Color.lerp(widget.backgroundColor,
                                  widget.accentColor, 0.05)
                              : widget.backgroundColor,
                          _isPressed
                              ? Color.lerp(widget.backgroundColor,
                                  widget.accentColor, 0.05)
                              : widget.backgroundColor,
                          Color.lerp(widget.backgroundColor,
                              widget.backgroundColor, _isPressed ? .2 : .5),
                        ],
                        stops: [
                          0.0,
                          .3,
                          .6,
                          1.0,
                        ]),
                    boxShadow: _isPressed
                        ? null
                        : [
                            BoxShadow(
                              blurRadius: 15.0,
                              offset: Offset(-2, -2),
                              color: Color.lerp(widget.backgroundColor,
                                  widget.backgroundColor, 0.6),
                              spreadRadius: 2.0,
                            ),
                            BoxShadow(
                                blurRadius: 15.0,
                                offset: Offset(2, 2),
                                color: Color.lerp(widget.backgroundColor,
                                    widget.accentColor, 0.3),
                                spreadRadius: 2.0)
                          ],
                  ),
                  child: widget.child,
                ),
              );
            }));
  }
}
