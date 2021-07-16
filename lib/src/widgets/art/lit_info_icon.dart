import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A art widget displaying a static info icon.
class LitInfoIcon extends StatelessWidget {
  final double height;
  final double width;
  final BoxDecoration decoration;
  final EdgeInsets padding;
  final double iconSize;
  final Color iconColor;

  /// Creates a [LitInfoIcon].
  const LitInfoIcon({
    Key? key,
    this.height = 64.0,
    this.width = 64.0,
    this.decoration = const BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(24.0),
      ),
      boxShadow: LitBoxShadows.sm,
      color: LitColors.mediumGrey,
    ),
    this.padding = const EdgeInsets.all(8.0),
    this.iconSize = 24.0,
    this.iconColor = LitColors.lightGrey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: decoration,
      child: Padding(
        padding: padding,
        child: Center(
          child: Icon(
            LitIcons.info,
            size: iconSize,
            color: this.iconColor,
          ),
        ),
      ),
    );
  }
}
