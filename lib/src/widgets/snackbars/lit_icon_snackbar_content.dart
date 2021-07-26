import 'dart:math';

import 'package:flutter/material.dart';
import 'package:leitmotif/text.dart';

/// A widget displaying an icon alongside text.
///
/// It's main purpose is to be used on the icon snackbars.
class LitIconSnackbarContent extends StatelessWidget {
  final Color iconBackgroundColor;
  final Color iconColor;
  final IconData iconData;
  final TextStyle textStyle;
  final String text;
  final EdgeInsets iconMargin;

  /// Creates a [LitIconSnackbarContent].
  ///
  /// Provide the required icon snackbar's member values.
  const LitIconSnackbarContent({
    Key? key,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.iconData,
    required this.textStyle,
    required this.text,
    this.iconMargin = const EdgeInsets.all(12.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            _IconContainer(
              constraints: constraints,
              iconBackgroundColor: iconBackgroundColor,
              iconColor: iconColor,
              iconData: iconData,
              iconMargin: iconMargin,
            ),
            _TextContainer(
              constraints: constraints,
              iconMargin: iconMargin,
              text: text,
              textStyle: textStyle,
            ),
          ],
        );
      },
    );
  }
}

/// A widget to display the snackbar's icon using the appropriate spacing.
class _IconContainer extends StatelessWidget {
  final BoxConstraints constraints;
  final double relativeWidth;
  final IconData iconData;
  final EdgeInsets iconMargin;
  final Color iconBackgroundColor;
  final Color iconColor;

  /// Creates a [_IconContainer].
  const _IconContainer({
    Key? key,
    required this.constraints,
    this.relativeWidth = 0.32,
    required this.iconData,
    required this.iconMargin,
    required this.iconBackgroundColor,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth * relativeWidth,
      height: constraints.maxWidth * relativeWidth,
      child: Padding(
        padding: iconMargin,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              constraints.maxWidth * 0.05,
            ),
            color: iconBackgroundColor,
          ),
          child: Icon(
            iconData,
            size: constraints.maxWidth * relativeWidth * 0.3,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

/// A widget to display the snackbar's text using the appropriate spacing.
class _TextContainer extends StatelessWidget {
  final BoxConstraints constraints;
  final double relativeWidth;
  final String text;
  final TextStyle textStyle;
  final EdgeInsets iconMargin;

  /// Creates a [_TextContainer].
  const _TextContainer({
    Key? key,
    required this.constraints,
    this.relativeWidth = 0.68,
    required this.text,
    required this.textStyle,
    required this.iconMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth * relativeWidth,
      child: Padding(
        padding: EdgeInsets.only(
          right: max(iconMargin.left, iconMargin.right),
        ),
        child: ClippedText(
          text,
          maxLines: 2,
          textAlign: TextAlign.left,
          style: textStyle,
        ),
      ),
    );
  }
}
