import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `buttons` widget allowing to delete an object by pressing a
/// button.
class LitDeleteButton extends StatelessWidget {
  final TextAlign textAlign;

  final TextStyle textStyle;

  final bool upperCase;

  final bool showIcon;

  /// Handles the `onPressed` action.
  final void Function() onPressed;

  /// Creates a [LitDeleteButton].
  const LitDeleteButton({
    Key? key,
    this.textAlign = TextAlign.left,
    this.textStyle = LitSansSerifStyles.button,
    this.upperCase = true,
    this.showIcon = false,
    required this.onPressed,
  }) : super(key: key);

  /// The button's accent color.
  static const accentColor = LitColors.red150;

  /// The button's background color.
  static const backgroundColor = LitColors.red200;

  MainAxisAlignment get _rowAlignment {
    switch (textAlign) {
      case TextAlign.center:
        return MainAxisAlignment.center;
      case TextAlign.left:
        return MainAxisAlignment.start;
      case TextAlign.end:
        return MainAxisAlignment.end;
      default:
        return MainAxisAlignment.start;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LitPushedThroughButton(
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      child: showIcon
          ? Row(
              mainAxisAlignment: _rowAlignment,
              children: [
                Icon(
                  LitIcons.trash_bin,
                  color: textStyle.color,
                  size: textStyle.fontSize,
                ),
                SizedBox(width: 8.0),
                ClippedText(
                  LeitmotifLocalizations.of(context).deleteLabel,
                  style: textStyle,
                  textAlign: textAlign,
                  upperCase: upperCase,
                ),
              ],
            )
          : _Text(
              textAlign: textAlign,
              textStyle: textStyle,
              upperCase: upperCase,
            ),
      onPressed: onPressed,
    );
  }
}

class _Text extends StatelessWidget {
  final TextAlign textAlign;
  final TextStyle textStyle;
  final bool upperCase;
  const _Text({
    Key? key,
    required this.textAlign,
    required this.textStyle,
    required this.upperCase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClippedText(
      LeitmotifLocalizations.of(context).deleteLabel,
      style: textStyle,
      textAlign: textAlign,
      upperCase: upperCase,
    );
  }
}
