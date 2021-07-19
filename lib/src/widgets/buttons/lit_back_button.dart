import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class LitBackButtonDefaultStyling {
  static const double height = 50.0;
  static const double width = 100.0;
  static const Color iconColor = Colors.white;
  static const Color backgroundColor = LitColors.lightGrey;
  static const IconData icon = LitIcons.arrow_left_solid;
  static const double iconSize = 18.0;
  static const EdgeInsets padding = const EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 3.0,
  );
}

class LitBackButton extends StatefulWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final double iconSize;
  final EdgeInsets padding;
  final bool shouldNavigateBack;
  final void Function()? onInvalidNavigation;
  final void Function()? onTap;
  const LitBackButton({
    Key? key,
    this.height = LitBackButtonDefaultStyling.height,
    this.width = LitBackButtonDefaultStyling.width,
    this.backgroundColor = LitBackButtonDefaultStyling.backgroundColor,
    this.iconColor = LitBackButtonDefaultStyling.iconColor,
    this.icon = LitBackButtonDefaultStyling.icon,
    this.iconSize = LitBackButtonDefaultStyling.iconSize,
    this.padding = LitBackButtonDefaultStyling.padding,
    this.shouldNavigateBack = true,
    this.onInvalidNavigation,
    this.onTap,
  }) : super(key: key);

  @override
  _LitBackButtonState createState() => _LitBackButtonState();
}

class _LitBackButtonState extends State<LitBackButton> {
  void _onTap() {
    // If a callback was provided, execute it.
    if (widget.onTap != null) {
      widget.onTap!();
      // Otherwise navigate back by default.
    } else {
      if (Navigator.canPop(context)) {
        if (widget.shouldNavigateBack) {
          Navigator.of(context).pop();
        } else {
          if (widget.onInvalidNavigation != null) {
            widget.onInvalidNavigation!();
          }
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
          height: widget.height,
          width: widget.width,
          child: LitTooltipContainer(
            backgroundColor: widget.backgroundColor,
            text: "${MaterialLocalizations.of(context).backButtonTooltip}",
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Icon(
                widget.icon,
                size: widget.iconSize,
                color: widget.iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
