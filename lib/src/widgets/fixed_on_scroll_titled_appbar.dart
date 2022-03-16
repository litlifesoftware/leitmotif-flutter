import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `app_bars` widget allowing to display an app bar, which will
/// only appear once the corresponding scroll view has been scrolled.
///
/// The app bar content will display a string labeling the current screen.
class FixedOnScrollTitledAppbar extends StatelessWidget
    implements CustomAppBar {
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

  /// The app bar's title.
  final String title;

  final TextStyle textStyle;

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

  /// Creates a [FixedOnScrollTitledAppbar].
  const FixedOnScrollTitledAppbar({
    Key? key,
    required this.scrollController,
    required this.title,
    this.requiredOffset = CustomAppBar.requiredOffset,
    this.backgroundColor = Colors.white,
    this.boxShadow = CustomAppBar.boxShadow,
    this.height = CustomAppBar.height,
    this.textStyle = CustomAppBar.textStyle,
    this.margin = CustomAppBar.margin,
    this.backButtonBackgroundColor = LitBackButton.defaultBackgroundColor,
    this.backButtonIconColor = LitBackButton.defaultIconColor,
    this.shouldNavigateBack = LitBackButton.defaultShouldNavigateBack,
    this.onInvalidNavigation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FixedOnScrollAppbar(
      scrollController: scrollController,
      backButtonBackgroundColor: backButtonBackgroundColor,
      backButtonIconColor: backButtonIconColor,
      backgroundColor: backgroundColor,
      boxShadow: boxShadow,
      height: height,
      onInvalidNavigation: onInvalidNavigation,
      margin: margin,
      shouldNavigateBack: shouldNavigateBack,
      child: LitAppBarTitleLabel(
        style: textStyle,
        title: title,
      ),
    );
  }
}
