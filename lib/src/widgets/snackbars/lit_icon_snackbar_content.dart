import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lit_ui_kit/text.dart';

class LitIconSnackbarContent extends StatelessWidget {
  final Color iconBackgroundColor;
  final Color iconColor;
  final IconData iconData;
  final TextStyle textStyle;
  final String text;
  final EdgeInsets iconMargin;
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

class _IconContainer extends StatelessWidget {
  final BoxConstraints constraints;
  final double relativeWidth;
  final IconData iconData;
  final EdgeInsets iconMargin;
  final Color iconBackgroundColor;
  final Color iconColor;
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

class _TextContainer extends StatelessWidget {
  final BoxConstraints constraints;
  final double relativeWidth;
  final String text;
  final TextStyle textStyle;
  final EdgeInsets iconMargin;

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
