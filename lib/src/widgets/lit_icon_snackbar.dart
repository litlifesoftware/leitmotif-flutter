import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// An animated [LitSnackbar] positioned using the provided [Alignment].
///
/// A [LitSnackbar] implementation displaying a leading [Icon] next to an
/// text.
class LitIconSnackbar extends StatelessWidget implements LitSnackbar {
  final LitSnackbarController snackBarController;
  final String? title;
  final String text;
  final TextStyle textStyle;
  final IconData iconData;
  final Color iconBackgroundColor;

  final Alignment alignment;
  final EdgeInsets padding;
  //final EdgeInsets margin;
  final double width;

  /// Creates a [LitIconSnackbar] widget.
  ///
  /// Specify the displayed [IconData] and the description text.
  const LitIconSnackbar({
    Key? key,
    required this.snackBarController,
    this.title,
    required this.text,
    this.textStyle = LitSansSerifStyles.caption,
    required this.iconData,
    this.iconBackgroundColor = Colors.white,
    this.alignment = Alignment.topRight,
    this.padding = LitSnackbar.defaultPadding,
    //this.margin = const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
    this.width = LitSnackbar.defaultWidth,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LitBaseSnackbar(
      snackBarController: snackBarController,
      width: width,
      height: LitSnackbar.defaultHeight,
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
