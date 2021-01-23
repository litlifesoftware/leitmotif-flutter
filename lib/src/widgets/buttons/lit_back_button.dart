import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class LitBackButton extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final EdgeInsets padding;
  const LitBackButton({
    Key key,
    @required this.backgroundColor,
    @required this.iconColor,
    this.icon = LitIcons.arrow_left_solid,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 3.0,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: Navigator.canPop(context)
            ? () => Navigator.of(context).pop()
            : () => {},
        child: SizedBox(
          height: 50.0,
          width: 100.0,
          child: LitTooltipContainer(
            backgroundColor: backgroundColor,
            // onPressed: () => Navigator.of(context).pop(),
            text: "${MaterialLocalizations.of(context).backButtonTooltip}",
            child: Icon(
              icon,
              size: 18.0,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
