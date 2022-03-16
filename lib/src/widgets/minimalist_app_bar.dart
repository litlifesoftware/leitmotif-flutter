import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `app_bars` widget displaying a minimalist app bar, which will
/// only show a back button for basic navigation.
class MinimalistAppBar extends StatelessWidget implements CustomAppBar {
  /// The app bar's height.
  final double height;

  /// The app bar's margin.
  final EdgeInsets margin;

  /// The back button's background color.
  final Color backButtonBackgroundColor;

  /// The back button's icon color.
  final Color backButtonIconColor;

  /// Creates a [MinimalistAppBar].
  const MinimalistAppBar({
    Key? key,
    this.height = CustomAppBar.height,
    this.margin = CustomAppBar.margin,
    this.backButtonBackgroundColor = LitBackButton.defaultBackgroundColor,
    this.backButtonIconColor = LitBackButton.defaultIconColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: margin,
        child: Stack(
          children: [
            Container(
              height: height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
            Navigator.of(context).canPop()
                ? Container(
                    height: height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SafeArea(
                        child: LitBackButton(
                          backgroundColor: backButtonBackgroundColor,
                          iconColor: backButtonIconColor,
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
