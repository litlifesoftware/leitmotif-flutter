import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class LitBackButton extends StatefulWidget {
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final EdgeInsets padding;
  final bool shouldNavigateBack;
  final void Function() onInvalidNavigation;
  const LitBackButton({
    Key key,
    @required this.backgroundColor,
    @required this.iconColor,
    this.icon = LitIcons.arrow_left_solid,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 3.0,
    ),
    this.shouldNavigateBack = true,
    this.onInvalidNavigation,
  }) : super(key: key);

  @override
  _LitBackButtonState createState() => _LitBackButtonState();
}

class _LitBackButtonState extends State<LitBackButton> {
  void _onTap() {
    if (Navigator.canPop(context)) {
      if (widget.shouldNavigateBack) {
        Navigator.of(context).pop();
      } else {
        if (widget.onInvalidNavigation != null) {
          widget.onInvalidNavigation();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: _onTap,
        child: SizedBox(
          height: 50.0,
          width: 100.0,
          child: LitTooltipContainer(
            backgroundColor: widget.backgroundColor,
            text: "${MaterialLocalizations.of(context).backButtonTooltip}",
            child: Icon(
              widget.icon,
              size: 18.0,
              color: widget.iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
