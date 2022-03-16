import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `app_bars` widget displaying an app bar on top of a screen.
///
/// Provides the default implementation of Leitmotif's [CustomAppBar].
class LitAppBar extends StatelessWidget implements CustomAppBar {
  /// The app bar's title.
  ///
  /// Indicates the screen's title.
  final String title;

  /// The title's text style.
  final TextStyle textStyle;

  /// The shadow decoration.
  final List<BoxShadow> boxShadow;

  /// The bar's background color.
  final Color backgroundColor;

  /// The back button's background color.
  final Color backButtonBackgroundColor;

  /// The back button's icon color.
  final Color backButtonIconColor;

  /// The app bar height is depending on the abstract [CustomAppBar] height.
  static final double height = CustomAppBar.height;

  /// The bar's internal margin.
  static final EdgeInsets margin = CustomAppBar.margin;

  /// States whether to allow to navigate back.
  final bool shouldNavigateBack;

  /// Handles the action once navigating back has been denied.
  final void Function()? onInvalidNavigation;

  /// Creates a [LitAppBar].
  const LitAppBar({
    Key? key,
    required this.title,
    this.textStyle = CustomAppBar.textStyle,
    this.boxShadow = CustomAppBar.boxShadow,
    this.backgroundColor = Colors.white,
    this.backButtonBackgroundColor = LitBackButton.defaultBackgroundColor,
    this.backButtonIconColor = LitBackButton.defaultIconColor,
    this.shouldNavigateBack = LitBackButton.defaultShouldNavigateBack,
    this.onInvalidNavigation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: boxShadow,
        ),
        child: SafeArea(
          child: LitAppBarContent(
            backButtonBackgroundColor: backButtonBackgroundColor,
            backButtonIconColor: backButtonIconColor,
            margin: margin,
            onInvalidNavigation: onInvalidNavigation,
            shouldNavigateBack: shouldNavigateBack,
            child: LitAppBarTitleLabel(
              title: title,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
