import 'package:flutter/material.dart';

class LitLifeSmileyImage extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  final BoxFit fit;
  const LitLifeSmileyImage({
    Key? key,
    this.color = Colors.black,
    this.width = 256.0,
    this.height = 256.0,
    this.fit = BoxFit.scaleDown,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image(
      color: color,
      height: height,
      width: width,
      fit: fit,
      image: AssetImage(
        "assets/images/Plain_Logo_Small.png",
        package: "lit_ui_kit",
      ),
    );
  }
}
