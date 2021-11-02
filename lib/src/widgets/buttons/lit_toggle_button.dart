import 'package:flutter/material.dart';
import 'package:leitmotif/containers.dart';
import 'package:leitmotif/styles.dart';

/// A Leitmotif `buttons` widget displaying a toggle button which can have two
/// states (`enabled` and `disabled`).
///
/// It's value should be toggled on the parent widget using the [onChanged]
/// callback.
class LitToggleButton extends StatefulWidget {
  /// The current value.
  final bool value;

  /// The thumb size.
  final double size;

  /// The background's `enabled` color.
  final Color colorEnabled;

  /// The background's `disabled` color.
  final Color colorDisabled;

  /// The animation duration.
  final Duration animationDuration;

  /// The callback setting the parent's state.
  final void Function(bool) onChanged;

  /// Creates a [LitToggleButton].
  const LitToggleButton({
    Key? key,
    required this.onChanged,
    required this.value,
    this.size = 28.0,
    this.colorEnabled = LitColors.red200,
    this.colorDisabled = LitColors.green200,
    this.animationDuration = LitAnimationDurations.button,
  }) : super(key: key);

  @override
  _LitToggleButtonState createState() => _LitToggleButtonState();
}

class _LitToggleButtonState extends State<LitToggleButton>
    with TickerProviderStateMixin {
  late bool _enabled;
  late AnimationController animationController;

  /// Handles the `onPressed` action.
  ///
  /// Animates the button state transition and executes the provided callback.
  void onPressed() {
    if (_enabled) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    widget.onChanged(!_enabled);
    setState(() {
      _enabled = !_enabled;
    });
  }

  /// Returns an animated transform matrix.
  Matrix4 get _transform {
    final x = widget.size * animationController.value;
    return Matrix4.translationValues(x, 0, 0);
  }

  /// Returns an animated color lerp.
  Color get _color => Color.lerp(
      widget.colorEnabled, widget.colorDisabled, animationController.value)!;

  /// Returns an animated opacity.
  ///
  /// Creates a motion blur effect.
  double get _opacity => (animationController.isAnimating)
      ? (0.25 + 0.75 * animationController.value)
      : 1.0;

  /// Returns a 50% border radius.
  BorderRadius get _borderRadius =>
      BorderRadius.all(Radius.circular(widget.size / 2));

  @override
  void initState() {
    super.initState();
    _enabled = widget.value;
    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    if (widget.value) animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: _Thumb(
        borderRadius: _borderRadius,
        size: widget.size,
      ),
      builder: (context, child) {
        return CleanInkWell(
          onTap: onPressed,
          child: Container(
            height: widget.size,
            width: widget.size * 2,
            decoration: BoxDecoration(
              borderRadius: _borderRadius,
              color: _color,
            ),
            child: Row(
              children: [
                Transform(
                  transform: _transform,
                  child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: animationController.duration!,
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// The [LitToggleButton]'s thumb.
class _Thumb extends StatelessWidget {
  final double size;
  final BorderRadius borderRadius;
  const _Thumb({
    Key? key,
    required this.size,
    required this.borderRadius,
  }) : super(key: key);

  static const color = LitColors.grey50;
  static const boxShadow = LitBoxShadows.sm;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        color: color,
      ),
    );
  }
}
