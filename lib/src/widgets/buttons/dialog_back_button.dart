import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class DialogBackButton extends StatelessWidget {
  final double height;
  final double width;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Color color;
  final double iconSize;
  final void Function() onPressed;

  const DialogBackButton({
    Key? key,
    this.height = 50.0,
    this.width = 100.0,
    this.padding = const EdgeInsets.symmetric(
      vertical: 4.0,
      horizontal: 16.0,
    ),
    this.backgroundColor = const Color(0xFFd1cdcd),
    this.color = const Color(0xFFf4f4f7),
    this.iconSize = 18.0,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: onPressed,
      child: Padding(
        padding: padding,
        child: SizedBox(
          height: height,
          width: width,
          child: LitTooltipContainer(
              backgroundColor: backgroundColor,
              text: "${MaterialLocalizations.of(context).backButtonTooltip}",
              child: Icon(
                LitIcons.arrow_left_solid,
                size: iconSize,
                color: color,
              )),
        ),
      ),
    );
  }
}
