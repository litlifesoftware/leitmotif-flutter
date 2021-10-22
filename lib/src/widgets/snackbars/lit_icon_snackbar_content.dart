import 'package:flutter/material.dart';
import 'package:leitmotif/containers.dart';
import 'package:leitmotif/localization.dart';

/// A Leitmotif `snackbars` widget providing the content on a snackbar.
class LitIconSnackbarContent extends StatelessWidget {
  /// The icon's background color.
  final Color iconBackgroundColor;

  /// The displayed icon.
  final IconData iconData;

  /// The snackbar's title.
  final String? title;

  /// The snackbar's text.
  final String text;

  /// The content's text style.
  final TextStyle textStyle;

  final int maxLines;

  /// The content's inner margin.
  final EdgeInsets margin;

  /// Creates a [LitIconSnackbarContent].
  const LitIconSnackbarContent({
    Key? key,
    required this.iconBackgroundColor,
    required this.iconData,
    required this.textStyle,
    required this.text,
    this.maxLines = 2,
    this.title,
    this.margin = const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: LitDescriptionTextBox(
        icon: iconData,
        title: title ?? LeitmotifLocalizations.of(context).notificationLabel,
        text: text,
        style: textStyle,
        maxLines: maxLines,
        iconBackgroundColor: iconBackgroundColor,
      ),
    );
  }
}
