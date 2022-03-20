import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `widget` displaying a colored divider to seperate
///  similar-looking widgets.
class LitDivider extends StatelessWidget {
  /// The divider's thickness.
  final double thickness;

  /// The divider's color.
  final Color color;

  /// The container's margin.
  final EdgeInsets margin;

  /// Creates a [LitDivider].
  const LitDivider({
    Key? key,
    this.thickness = 2.0,
    this.color = LitColors.grey300,
    this.margin = LitEdgeInsets.spacingY,
  }) : super(key: key);

  /// Returns a 50% border radius.
  BorderRadius get _borderRadius =>
      BorderRadius.all(Radius.circular(thickness / 2));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Container(
        height: thickness,
        decoration: BoxDecoration(
          color: color,
          borderRadius: _borderRadius,
        ),
      ),
    );
  }
}
