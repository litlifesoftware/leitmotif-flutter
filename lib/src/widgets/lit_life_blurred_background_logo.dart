import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class LitLifeBlurredBackgroundLogo extends StatelessWidget {
  final double height;
  final double width;
  final double blurRadius;
  final Color backgroundColor;
  final Color color;
  final BorderRadius borderRadius;
  final EdgeInsets margin;
  const LitLifeBlurredBackgroundLogo({
    Key? key,
    this.height = 142.0,
    this.width = 142.0,
    this.blurRadius = 16.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(52.0)),
    this.margin = const EdgeInsets.all(28.0),
    this.backgroundColor = const Color(0x66FFFFFF),
    this.color = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BluredBackgroundContainer(
      borderRadius: borderRadius,
      blurRadius: blurRadius,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: backgroundColor,
        ),
        child: Padding(
          padding: margin,
          child: Icon(
            LitIcons.llsw_smiley,
            color: color,
            size: 82.0,
          ),
        ),
      ),
    );
  }
}
