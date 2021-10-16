import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `button` widget.
///
/// Displays a tooltip in front of the provided button ([child]) to display
/// hints or additional information.
class LitTooltipContainer extends StatefulWidget {
  /// The button's background color.
  final Color? backgroundColor;

  /// The child button.
  final Widget child;

  /// The tooltip text.
  final String text;

  /// The button border radius.
  final BorderRadius borderRadius;

  /// The padding.
  final EdgeInsets padding;

  /// Creates a [LitTooltipContainer].
  const LitTooltipContainer({
    Key? key,
    required this.backgroundColor,
    required this.child,
    required this.text,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.0)),
    this.padding = const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 16.0,
    ),
  }) : super(key: key);
  @override
  _LitTooltipContainerState createState() => _LitTooltipContainerState();
}

class _LitTooltipContainerState extends State<LitTooltipContainer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  /// Handles the long press `start` action.
  void handleLongPressStart(LongPressStartDetails details) {
    _animationController.forward(from: 0.0);
  }

  /// Handles the long press `end` action.
  void handleLongPressEnd(LongPressEndDetails details) {
    _animationController.reverse(from: 1.0);
  }

  /// Returns an animated box shadow.
  List<BoxShadow> get _animatedBoxShadow {
    return [
      BoxShadow(
        spreadRadius: 2.0 * _animationController.value,
        blurRadius: 8.0 * _animationController.value,
        offset: Offset(
          2 * -_animationController.value,
          2 * -_animationController.value,
        ),
        color: Colors.black.withOpacity(
          (_animationController.value) * 0.6,
        ),
      )
    ];
  }

  /// Returns an animated color.
  Color get _animatedColor {
    return Color.lerp(
        widget.backgroundColor, Colors.black12, _animationController.value)!;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressEnd: handleLongPressEnd,
      onLongPressStart: handleLongPressStart,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return _AnimatedContent(
            animatedBoxShadow: _animatedBoxShadow,
            animatedColor: _animatedColor,
            animationController: _animationController,
            backgroundColor: widget.backgroundColor!,
            borderRadius: widget.borderRadius,
            child: widget.child,
            padding: widget.padding,
            text: widget.text,
          );
        },
        child: _AnimatedContent(
          animatedBoxShadow: _animatedBoxShadow,
          animatedColor: _animatedColor,
          animationController: _animationController,
          backgroundColor: widget.backgroundColor!,
          borderRadius: widget.borderRadius,
          child: widget.child,
          padding: widget.padding,
          text: widget.text,
        ),
      ),
    );
  }
}

/// The [LitTooltipContainer]'s animated content.
class _AnimatedContent extends StatelessWidget {
  final AnimationController animationController;
  final String text;
  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Color animatedColor;
  final List<BoxShadow> animatedBoxShadow;
  const _AnimatedContent({
    Key? key,
    required this.animationController,
    required this.text,
    required this.child,
    required this.borderRadius,
    required this.padding,
    required this.backgroundColor,
    required this.animatedColor,
    required this.animatedBoxShadow,
  }) : super(key: key);

  /// The button's inner padding.
  static const EdgeInsets _margin = const EdgeInsets.symmetric(
    vertical: 2.0,
    horizontal: 4.0,
  );

  /// The button's background color.
  Color get _backgroundColor {
    return Color.lerp(
      backgroundColor,
      Colors.white24,
      1.0,
    )!;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              boxShadow: animatedBoxShadow,
              color: animatedColor,
            ),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: AnimatedOpacity(
            duration: animationController.duration!,
            opacity: animationController.value,
            child: BluredBackgroundContainer(
              blurRadius: 4.0,
              borderRadius: borderRadius,
              child: Container(
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: borderRadius,
                ),
                child: Padding(
                  padding: _margin,
                  child: ClippedText(
                    text.toUpperCase(),
                    style: LitSansSerifStyles.overline.copyWith(
                      color: Color.lerp(
                        backgroundColor,
                        Colors.white70,
                        1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
