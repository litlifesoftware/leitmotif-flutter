import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

//TODO: Document
class LitNavigationButton extends StatelessWidget {
  final LitCalendarNavigationMode mode;
  final EdgeInsets padding;
  final Color backgroundAccentColor;
  final void Function() onPressed;

  const LitNavigationButton({
    Key? key,
    required this.mode,
    this.padding = const EdgeInsets.symmetric(
      vertical: 4.0,
      horizontal: 2.0,
    ),
    this.backgroundAccentColor = const Color(0xFFfbfbfb),
    required this.onPressed,
  }) : super(key: key);

  IconData get _icon {
    switch (mode) {
      case LitCalendarNavigationMode.next:
        return LitIcons.chevron_right_solid;
      case LitCalendarNavigationMode.previous:
        return LitIcons.chevron_left_solid;
      default:
        return LitIcons.chevron_right;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LitPushedThroughButton(
      boxShadow: LitBoxShadows.xs,
      accentColor: backgroundAccentColor,
      padding: padding,
      onPressed: onPressed,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Icon(
          _icon,
          size: 14.0,
          color: LitSansSerifStyles.defaultColor,
        ),
      ),
    );
  }
}

enum LitCalendarNavigationMode { next, previous }
