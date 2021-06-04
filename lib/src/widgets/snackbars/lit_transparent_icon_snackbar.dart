import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// An animated [LitSnackbar] positioned using the provided [Alignment].
///
/// A transparent [LitSnackbar] implementation displaying a leading [Icon]
/// next to a text.
class LitTransparentIconSnackbar extends StatelessWidget
    implements LitSnackbar {
  final LitSnackbarController snackBarController;
  final String text;
  final TextStyle textStyle;
  final IconData iconData;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Alignment alignment;
  final EdgeInsets padding;
  final double height;
  final double width;

  const LitTransparentIconSnackbar({
    Key? key,
    required this.snackBarController,
    required this.text,
    this.textStyle = LitTextStyles.sansSerif,
    required this.iconData,
    this.iconBackgroundColor = LitColors.mediumGrey,
    this.iconColor = Colors.white,
    this.alignment = Alignment.topRight,
    this.padding = LitSnackbar.defaultPadding,
    this.height = LitSnackbar.defaultHeight,
    this.width = LitSnackbar.defaultWidth,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LitTransparentSnackbar(
        snackBarController: snackBarController,
        width: width,
        height: height,
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
  LitSnackbarController? get controller => this.snackBarController;
}
