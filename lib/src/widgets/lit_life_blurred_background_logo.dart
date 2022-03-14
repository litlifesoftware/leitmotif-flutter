import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class LitLifeBlurredBackgroundLogo extends StatelessWidget {
  final double height;
  final double width;
  final double blurRadius;
  final BorderRadius borderRadius;
  final EdgeInsets margin;
  const LitLifeBlurredBackgroundLogo({
    Key? key,
    this.height = 142.0,
    this.width = 142.0,
    this.blurRadius = 12.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(42.0)),
    this.margin = const EdgeInsets.all(28.0),
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
          color: const Color(0x66FFFFFF),
        ),
        child: Padding(
          padding: margin,
          child: LitLifeSmileyImage(
            color: Color(
              0xFFB2AAAA,
            ),
          ),
        ),
      ),
    );
  }
}
