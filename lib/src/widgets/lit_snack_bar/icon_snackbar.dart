import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A [LitSnackbar] displaying a leading [Icon].
///
/// It will return a [SlidingSnackbar] whose [SlidingSnackbar.child] will
/// be set to a [Row] containing the provided [Icon] and an information text.
class IconSnackbar extends StatelessWidget implements LitSnackbar {
  final LitSnackbarController litSnackBarController;
  final String text;
  final TextStyle textStyle;
  final IconData iconData;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Alignment alignment;
  final EdgeInsets padding;
  final double width;

  /// Creates a [IconSnackbar] widget.
  ///
  /// Specify the displayed [IconData] and the description text.
  const IconSnackbar({
    Key key,
    @required this.litSnackBarController,
    @required this.text,
    this.textStyle = LitTextStyles.sansSerif,
    @required this.iconData,
    this.iconBackgroundColor = LitColors.mediumGrey,
    this.iconColor = Colors.white,
    this.alignment = Alignment.topRight,
    this.padding = const EdgeInsets.symmetric(
      vertical: 32.0,
    ),
    this.width = 250,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SlidingSnackbar(
        customSnackBarController: litSnackBarController,
        width: width,
        height: 80.0,
        alignment: alignment,
        padding: padding,
        child: LayoutBuilder(builder: (context, builder) {
          return Row(
            children: [
              SizedBox(
                width: (width) * 0.3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: iconBackgroundColor,
                        ),
                        child: Icon(
                          iconData,
                          size: (width * 0.3) * 0.3,
                          color: iconColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: (width) * 0.7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClippedText(
                    text,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: textStyle,
                  ),
                ),
              ),
            ],
          );
        }));
  }

  @override
  LitSnackbarController get controller => this.litSnackBarController;
}
