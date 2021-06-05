import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:lit_ui_kit/src/widgets/snackbars/lit_icon_snackbar_content.dart';

/// An animated [LitSnackbar] positioned using the provided [Alignment].
///
/// A [LitSnackbar] implementation displaying a leading [Icon] next to an
/// text.
class LitIconSnackbar extends StatelessWidget implements LitSnackbar {
  final LitSnackbarController snackBarController;
  final String text;
  final TextStyle textStyle;
  final IconData iconData;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Alignment alignment;
  final EdgeInsets padding;
  final double width;

  /// Creates a [LitIconSnackbar] widget.
  ///
  /// Specify the displayed [IconData] and the description text.
  const LitIconSnackbar({
    Key? key,
    required this.snackBarController,
    required this.text,
    this.textStyle = LitTextStyles.sansSerif,
    required this.iconData,
    this.iconBackgroundColor = LitColors.mediumGrey,
    this.iconColor = Colors.white,
    this.alignment = Alignment.topRight,
    this.padding = LitSnackbar.defaultPadding,
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
