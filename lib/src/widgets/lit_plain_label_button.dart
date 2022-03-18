import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `buttons` widget allowing to trigger the provided [onPressed]
/// callback when being pressed.
class LitPlainLabelButton extends StatefulWidget {
  /// The button's label.
  final String label;

  /// States whether to disable the button's functionality.
  final bool disabled;

  /// The button label's text style.
  final TextStyle textStyle;

  /// The label's alignment.
  final TextAlign textAlign;

  /// The label's font size.
  ///
  /// This will override the provided [textStyle]'s font size.
  final double fontSize;

  /// The label's text color.
  ///
  /// This will override the provided [textStyle]'s color.
  final Color color;

  /// The accent color.
  final Color accentColor;

  /// The outer padding.
  final EdgeInsets padding;

  /// The animation duration.
  final Duration animationDuration;

  /// Handles the `onPressed` action of this button.
  final void Function() onPressed;

  /// Creates a [LitPlainLabelButton].
  const LitPlainLabelButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.fontSize = 16.0,
    this.textStyle = LitSansSerifStyles.button,
    this.color = LitColors.grey380,
    this.accentColor = Colors.white,
    this.textAlign = TextAlign.center,
    this.disabled = false,
    this.padding = const EdgeInsets.only(
      top: 8.0,
      bottom: 8.0,
    ),
    this.animationDuration = LitAnimationDurations.button,
  }) : super(key: key);

  @override
  _LitPlainLabelButtonState createState() => _LitPlainLabelButtonState();
}

class _LitPlainLabelButtonState extends State<LitPlainLabelButton>
    with TickerProviderStateMixin {
  /// Controls the button animation.
  late AnimationController _animationController;

  /// Handles the `onPressed` action and executes the provided callback.
  void _onPressed() {
    if (!widget.disabled) {
      _animationController.reverse().then(
        (_) {
          _animationController.forward();
        },
      ).then(
        (_) {
          widget.onPressed();
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animationController.forward();
  }

  TextStyle get _style {
    return widget.textStyle.copyWith(
      fontSize: widget.fontSize,
      color: Color.lerp(
        widget.accentColor,
        widget.color,
        _animationController.value,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CleanInkWell(
      onTap: _onPressed,
      child: Padding(
        padding: widget.padding,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return ClippedText(
              widget.label.toUpperCase(),
              textAlign: widget.textAlign,
              style: _style,
            );
          },
        ),
      ),
    );
  }
}
