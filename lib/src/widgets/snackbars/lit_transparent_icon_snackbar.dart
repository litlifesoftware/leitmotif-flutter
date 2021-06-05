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
      child: LitIconSnackbarContent(
        iconBackgroundColor: iconBackgroundColor,
        iconColor: iconColor,
        iconData: iconData,
        textStyle: textStyle,
        text: text,
      ),
    );
  }

  @override
  LitSnackbarController? get controller => this.snackBarController;
}
