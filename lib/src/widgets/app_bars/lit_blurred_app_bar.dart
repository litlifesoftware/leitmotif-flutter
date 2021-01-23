import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A [CustomAppBar] which will blur all content underneath.
///
/// This effect requires the content to be placed without any additional
/// [Padding] on the [LitScaffold]. Note that this will force the content
/// to be on the same vertical level as the [LitBlurredAppBar]. Therefore
/// [ListView]s displayed on the [LitScaffold] should be provided adjusted
/// with [Padding] on them.
class LitBlurredAppBar extends StatelessWidget implements CustomAppBar {
  final String title;
  final TextStyle textStyle;
  final bool darkMode;

  /// The app bar height is depending on the abstract [CustomAppBar] height.
  static final height = CustomAppBar.height;

  /// Creates a [LitBlurredAppBar].
  ///
  /// Define the [textStyle] value for a custom [TextStyle].
  ///
  /// Define the [darkMode] value for a different color scheme.
  const LitBlurredAppBar({
    Key key,
    @required this.title,
    this.textStyle = LitTextStyles.sansSerif,
    this.darkMode = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          BluredBackgroundContainer(
            blurRadius: 5.0,
            child: Container(
              height: height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: darkMode
                    ? Colors.black.withOpacity(0.2)
                    : LitColors.mediumGrey.withOpacity(0.1),
              ),
              child: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ClippedText(
                      "$title",
                      style: textStyle.copyWith(
                        color: darkMode ? Colors.white : LitColors.mediumGrey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Navigator.canPop(context)
              ? Container(
                  height: height,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SafeArea(
                        child: LitBackButton(
                      backgroundColor:
                          darkMode ? Colors.black : LitColors.lightGrey,
                      iconColor:
                          darkMode ? LitColors.mediumGrey : Colors.white60,
                    )),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
