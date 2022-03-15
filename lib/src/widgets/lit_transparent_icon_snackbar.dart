import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// An animated [LitSnackbar] positioned using the provided [Alignment].
///
/// A transparent [LitSnackbar] implementation displaying a leading [Icon]
/// next to a text.
class LitTransparentIconSnackbar extends StatelessWidget
    implements LitSnackbar {
  final LitSnackbarController snackBarController;
  final String? title;
  final String text;
  final TextStyle textStyle;
  final IconData iconData;
  final Color iconBackgroundColor;

  final Alignment alignment;
  final EdgeInsets padding;
  final double height;
  final double width;

  /// Creates a [LitTransparentIconSnackbar].
  ///
  /// Provide a [controller] and a [iconData] object.
  ///
  /// The snackbar's styling are set to the regular [LitSnackbar]'s default
  /// values.
  const LitTransparentIconSnackbar({
    Key? key,
    required this.snackBarController,
    this.title,
    required this.text,
    this.textStyle = LitSansSerifStyles.body2,
    required this.iconData,
    this.iconBackgroundColor = Colors.white,
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
        iconData: iconData,
        textStyle: textStyle,
        title: title,
        text: text,
      ),
    );
  }

  @override
  LitSnackbarController? get controller => this.snackBarController;
}
