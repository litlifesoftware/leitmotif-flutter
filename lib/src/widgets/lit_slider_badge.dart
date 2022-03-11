import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class LitTextBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;
  const LitTextBadge({
    Key? key,
    required this.label,
    this.backgroundColor = LitColors.mediumGrey,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.w700,
    this.fontSize = 10.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LitBadge(
      backgroundColor: backgroundColor,
      child: ClippedText(
        "$label",
        style: LitTextStyles.sansSerif.copyWith(
          color: textColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
