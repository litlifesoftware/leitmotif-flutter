import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `app_bars` widget allowing to display an app bar, which will
/// only appear once the corresponding scroll view has been scrolled.
///
/// This will increase the total view initially available to the scroll view
/// while preserving the option to navigate back when scrolled down.
class FixedOnScrollAppbar extends StatefulWidget implements CustomAppBar {
  /// The controller attached to a scroll view.
  final ScrollController? scrollController;

  /// The scroll offset required to trigger the app bar to appear.
  final double requiredOffset;

  /// The app bar's background color.
  final Color backgroundColor;

  /// The app bar's box shadow.
  final List<BoxShadow> boxShadow;

  /// The app bar's total height.
  final double height;

  /// The app bar's child.
  final Widget child;

  /// The app bar's margin.
  final EdgeInsets margin;

  /// The back button's background color.
  final Color backButtonBackgroundColor;

  /// The back button's icon color.
  final Color backButtonIconColor;

  /// States whether navigating back should be allowed.
  final bool shouldNavigateBack;

  /// Handles the action once the back button is being pressed while navigation
  /// should not be allowed.
  final void Function()? onInvalidNavigation;

  /// Creates a [FixOnScrollAppbar].
  const FixedOnScrollAppbar({
    Key? key,
    required this.scrollController,
    required this.child,
    this.requiredOffset = CustomAppBar.requiredOffset,
    this.backgroundColor = Colors.white,
    this.boxShadow = CustomAppBar.boxShadow,
    this.height = CustomAppBar.height,
    this.margin = CustomAppBar.margin,
    this.backButtonBackgroundColor = LitBackButton.defaultBackgroundColor,
    this.backButtonIconColor = LitBackButton.defaultIconColor,
    this.shouldNavigateBack = LitBackButton.defaultShouldNavigateBack,
    this.onInvalidNavigation,
  }) : super(key: key);

  @override
  _FixedOnScrollAppbarState createState() => _FixedOnScrollAppbarState();
}

class _FixedOnScrollAppbarState extends State<FixedOnScrollAppbar>
    with TickerProviderStateMixin {
  /// Handles the `on scroll` animation.
  late AnimationOnScrollController _animationOnScrollController;

  @override
  void initState() {
    super.initState();
    _animationOnScrollController = AnimationOnScrollController(
      scrollController: widget.scrollController,
      requiredScrollOffset: widget.requiredOffset,
      direction: AnimationDirection.forward,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationOnScrollController.dispose();
    super.dispose();
  }

  /// Returns the current animation value.
  double get _animationValue {
    return _animationOnScrollController.animationController.value;
  }

  /// Returns an animated transform matrix.
  Matrix4 get _transform {
    final y = -widget.height + (widget.height * _animationValue);
    return Matrix4.translationValues(0, y, 0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationOnScrollController.animationController,
      builder: (context, _) {
        return AnimatedOpacity(
          duration: _animationOnScrollController.animationController.duration!,
          opacity: _animationValue,
          child: Transform(
            transform: _transform,
            child: Container(
              height: widget.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                boxShadow: widget.boxShadow,
              ),
              child: LitAppBarContent(
                backButtonBackgroundColor: widget.backButtonBackgroundColor,
                backButtonIconColor: widget.backButtonIconColor,
                onInvalidNavigation: widget.onInvalidNavigation,
                shouldNavigateBack: widget.shouldNavigateBack,
                margin: widget.margin,
                child: widget.child,
              ),
            ),
          ),
        );
      },
    );
  }
}
