import 'package:flutter/material.dart';
import 'package:leitmotif/containers.dart';

/// A widget displaying an icon alongside text.
///
/// It's main purpose is to be used on the icon snackbars.
class LitIconSnackbarContent extends StatelessWidget {
  final Color iconBackgroundColor;
  final IconData iconData;
  final String? title;
  final String text;
  final TextStyle textStyle;
  final EdgeInsets margin;

  /// Creates a [LitIconSnackbarContent].
  ///
  /// Provide the required icon snackbar's member values.
  const LitIconSnackbarContent({
    Key? key,
    required this.iconBackgroundColor,
    required this.iconData,
    required this.textStyle,
    this.title,
    required this.text,
    this.margin = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: LitDescriptionTextBox(
        icon: iconData,
        title: title,
        text: text,
        style: textStyle,
        maxLines: 2,
        iconBackgroundColor: iconBackgroundColor,
      ),
    );
  }
}
