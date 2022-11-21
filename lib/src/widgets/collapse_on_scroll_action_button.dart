import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// An action button whose label will be collapsed once the provided
/// [requiredScrollOffset] has been reached.
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

  /// States whether to blur the button's background. If so, any box shadow
  /// will be ignored.
  ///
  /// Defaults to `true`.
  final bool blurred;

  /// The button's box shadow.
  final List<BoxShadow> boxShadow;

  /// The button's callback method.
  final void Function() onPressed;

  /// Creates a [CollapseOnScrollActionButton].
  ///
  /// [scrollController] is the [ScrollController] which has been bound to a scrollable view.
  ///
  /// [backgroundColor] is the button's background color.
  ///
  /// [accentColor] is the button's animated accent color.
  ///
  /// Disable the [blurred] flag in order to enforce the box shadow to be
  /// applied.
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
      vertical: 12.0,
      horizontal: 24.0,
    ),
    this.blurred = true,
    this.boxShadow = LitBoxShadows.md,
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
  Color get _animatedAccentColor {
    return Color.lerp(widget.accentColor, widget.backgroundColor,
            _colorAnimation.value) ??
        widget.accentColor;
  }

  /// Create a background accent color using the [_colorAnimation].
  Color get _animatedBackgroundColor {
    return Color.lerp(widget.backgroundColor, widget.accentColor,
            _colorAnimation.value) ??
        widget.backgroundColor;
  }

  /// Reference to the [_animationOnScrollController]'s animation.
  AnimationController get _scrollAnimation {
    return _animationOnScrollController.animationController;
  }

  Color get _textColor => widget.backgroundColor.applyColorByContrast(
        LitColors.white,
        Color.lerp(LitColors.grey500, LitColors.grey380,
                1.0 - _colorAnimation.value) ??
            LitColors.grey500,
      );

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

  /// Returns the animated padding.
  EdgeInsets get _animatedPadding => _scrollAnimation.value != 1.0
      ? widget.padding
      : EdgeInsets.only(
          bottom: (_scrollAnimation.value) * widget.padding.bottom * 1.25,
          left: (_scrollAnimation.value) * widget.padding.left * 1.25,
          right: (_scrollAnimation.value) * widget.padding.right * 1.25,
          top: (_scrollAnimation.value) * widget.padding.top * 1.25,
        );

  double get _animatedIconSize =>
      _scrollAnimation.value != 1.0 ? 14.0 : (_scrollAnimation.value) * 18.0;

  double get _animatedSpacerWidth => _scrollAnimation.value != 1.0 ? 8.0 : 0.0;

  /// Returns the animated [Text] widget.
  Widget get _animatedText => _scrollAnimation.value != 1.0
      ? Text(
          widget.label,
          style: LitSansSerifStyles.button.copyWith(
            color: _textColor,
            fontSize: (1.0 - _scrollAnimation.value) * 16.0,
            letterSpacing: 0.75,
          ),
        )
      : SizedBox();

  @override
  void dispose() {
    _colorAnimation.dispose();
    _animationOnScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: LitBottomNavigation.defaultHeight + 24.0,
          right: 24.0,
        ),
        child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, _) {
            return LitGradientButton(
              padding: _animatedPadding,
              accentColor: _animatedBackgroundColor,
              color: _animatedAccentColor,
              boxShadow: widget.boxShadow,
              blurred: widget.blurred,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    color: _textColor,
                    size: _animatedIconSize,
                  ),
                  SizedBox(width: _animatedSpacerWidth),
                  AnimatedBuilder(
                    animation: _scrollAnimation,
                    builder: (context, _) {
                      return Opacity(
                        opacity: (1.0 - _scrollAnimation.value),
                        child: _animatedText,
                      );
                    },
                  ),
                ],
              ),
              onPressed: widget.onPressed,
            );
          },
        ),
      ),
    );
  }
}
