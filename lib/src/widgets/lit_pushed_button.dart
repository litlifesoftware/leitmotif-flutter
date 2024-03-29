import 'package:flutter/material.dart';

// TODO: Replace with `LitPushedThroughButton`.
class LitPushedButton extends StatefulWidget {
  final void Function() onPressed;

  /// Handles the button's `onPressed` action.
  final void Function()? onLongPressed;
  final Widget child;
  final bool animateOnStart;
  final Duration animationDuration;
  final double minScale;

  /// States whether to diabled the button's functionality.
  final bool disabled;
  const LitPushedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.animateOnStart = true,
    this.animationDuration = const Duration(milliseconds: 35),
    this.minScale = 0.8,
    this.disabled = false,
    this.onLongPressed,
  }) : super(key: key);
  @override
  _LitPushedButtonState createState() => _LitPushedButtonState();
}

class _LitPushedButtonState extends State<LitPushedButton>
    with TickerProviderStateMixin {
  late AnimationController _pushAnimation;

  double get _diabledOpacity {
    return 0.35;
  }

  void _onPressed() {
    if (this.mounted && !widget.disabled) {
      _pushAnimation
          .reverse()
          .then(
            (_) => _pushAnimation.forward(),
          )
          .then(
        (__) {
          try {
            widget.onPressed();
          } catch (e) {
            print("State unmounted on LitPushedButton.");
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _pushAnimation = AnimationController(
        duration: widget.animationDuration,
        vsync: this,
        value: widget.animateOnStart ? 0.0 : 1.0);
    if (widget.animateOnStart) {
      _pushAnimation.forward();
    }
  }

  @override
  void dispose() {
    _pushAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      onLongPress: widget.onLongPressed,
      child: AnimatedBuilder(
        animation: _pushAnimation,
        builder: (context, _) {
          return Transform.scale(
            scale: widget.minScale +
                (_pushAnimation.value * (1.0 - widget.minScale)),
            child: Opacity(
              opacity: widget.disabled ? _diabledOpacity : 1.0,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
