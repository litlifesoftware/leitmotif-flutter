import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// An [CustomActionButton] whose label will be collapsed and expanded depending on the specified
/// scroll controller's offset.
///
/// The icon will be displayed regardless of the current scroll offset.
class CollapseOnScrollActionButton extends StatefulWidget
    implements CustomActionButton {
  /// The [ScrollController] of the widget whose scroll offset should be listened to.
  final ScrollController scrollController;

  /// The button's animated accent color.
  final Color accentColor;

  /// The buttons background colo.
  final Color backgroundColor;

  /// The button's icon displayed all the time.
  final IconData icon;

  /// The button's label collapsed and expanded on scroll.
  final String label;

  /// The collapse animation's duration.
  final Duration collapseDuration;

  /// The scroll offset threshold required to trigger the collapse.
  final double requiredScrollOffset;

  /// The button's padding.
  final EdgeInsets padding;

  /// States whether to blur the button's background.
  final bool blurred;

  /// The button's callback method.
  final void Function() onPressed;

  /// Creates a [CollapseOnScrollActionButton].
  ///
  /// [scrollController] is the [ScrollController] which has been bound to a scrollable view.
  ///
  /// [backgroundColor] is the button's background color.
  ///
  /// [accentColor] is the button's animated accent color.
  const CollapseOnScrollActionButton({
    Key? key,
    required this.scrollController,
    this.backgroundColor = LitColors.lightGrey,
    this.accentColor = LitColors.lightRed,
    required this.icon,
    required this.label,
    this.collapseDuration = const Duration(milliseconds: 500),
    this.requiredScrollOffset = 64.0,
    this.padding = const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 22.0,
    ),
    this.blurred = true,
    required this.onPressed,
  }) : super(key: key);

  @override
  _CollapseOnScrollActionButtonState createState() =>
      _CollapseOnScrollActionButtonState();
}

class _CollapseOnScrollActionButtonState
    extends State<CollapseOnScrollActionButton> with TickerProviderStateMixin {
  /// The color shifting animation.
  late AnimationController _colorAnimation;

  late AnimationOnScrollController _animationOnScrollController;

  /// Create a animated accent color using the [_colorAnimation].
  Color get _accentColor {
    final int contrastingColorValue =
        (0xFFFFFFFF - widget.backgroundColor.value);
    final Color? contrastingColor =
        Color.lerp(Color(contrastingColorValue), widget.backgroundColor, 0.75);
    return Color.lerp(
            widget.backgroundColor, contrastingColor, _colorAnimation.value) ??
        widget.accentColor;
  }

  /// Create a background accent color using the [_colorAnimation].
  Color get _backgroundColor {
    return Color.lerp(widget.backgroundColor, widget.accentColor,
            _colorAnimation.value) ??
        widget.backgroundColor;
  }

  /// Reference to the [_animationOnScrollController]'s animation.
  AnimationController get _scrollAnimation {
    return _animationOnScrollController.animationController;
  }

  @override
  void initState() {
    _colorAnimation = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _colorAnimation.repeat(reverse: true);

    /// Initialize the [_animationOnScrollController].
    _animationOnScrollController = AnimationOnScrollController(
      scrollController: widget.scrollController,
      vsync: this,
      requiredScrollOffset: widget.requiredScrollOffset,
    );

    super.initState();
  }

  @override
  void dispose() {
    _colorAnimation.dispose();
    _animationOnScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: LitBottomNavigation.defaultHeight + 8.0,
            horizontal: 24.0,
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: LitGradientButton(
              padding: widget.padding,
              accentColor: _backgroundColor,
              color: _accentColor,
              blurred: true,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _scrollAnimation,
                    builder: (context, _) {
                      return Opacity(
                        opacity: (1.0 - _scrollAnimation.value),
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: (1.0 - _scrollAnimation.value) * 6.0,
                          ),
                          child: Text(
                            widget.label,
                            style: LitTextStyles.sansSerif.copyWith(
                              color: Colors.white,
                              fontSize: (1.0 - _scrollAnimation.value) * 15.0,
                              letterSpacing: 0.75,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Icon(
                    widget.icon,
                    color: Colors.white,
                    size: 15.0,
                  ),
                ],
              ),
              onPressed: widget.onPressed,
            ),
          ),
        );
      },
    );
  }
}
