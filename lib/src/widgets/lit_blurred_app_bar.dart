import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `app_bars` widget displaying a app bar, whose background is
/// blurred. This allows to apply a visual effect on top of the currently
/// displayed screen's content.
class LitBlurredAppBar extends StatelessWidget implements CustomAppBar {
  /// The app bar's height.
  final double height;

  /// The background's blur radius.
  final double blurRadius;

  /// The app bar's title.
  final String title;

  /// The app bar's title style.
  final TextStyle textStyle;

  /// States whether to allow to navigate back.
  final bool shouldNavigateBack;

  /// Handles the action once navigating back has been denied.
  final void Function()? onInvalidNavigation;

  /// Creates a [LitBlurredAppBar].
  const LitBlurredAppBar({
    Key? key,
    this.height = CustomAppBar.height,
    this.blurRadius = 4.0,
    required this.title,
    this.textStyle = CustomAppBar.textStyle,
    this.shouldNavigateBack = LitBackButton.defaultShouldNavigateBack,
    this.onInvalidNavigation,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: BluredBackgroundContainer(
        blurRadius: blurRadius,
        child: Container(
          height: height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: LitColors.semiTransparent,
          ),
          child: LitAppBarContent(
            backButtonBackgroundColor: LitBackButton.defaultBackgroundColor,
            backButtonIconColor: LitBackButton.defaultIconColor,
            margin: CustomAppBar.margin,
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
