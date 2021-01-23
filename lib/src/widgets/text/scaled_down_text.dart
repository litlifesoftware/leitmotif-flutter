import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// Wrapps the [Text] widget inside a scaled down [FittedBox] to  ensure the Text
/// will be displayed on all screens without any pixel overflow or clipping.
/// This could be needed if titles and headlines are displayed. Note that the
/// wrapped [ScaledDownText] must receive definite boundaries by e.g. a SizedBox
/// with a fixed width.
///
/// Use this text widget whenever you need to display a large single lined [String]
/// e.g. a title.
class ScaledDownText extends StatelessWidget {
  final String value;
  final TextStyle style;
  final TextAlign textAlign;

  /// Creates a [ScaledDownText] widget.
  ///
  /// Pass a [TextStyle] to style the text.

  const ScaledDownText(
    this.value, {
    Key key,
    this.style = LitTextStyles.sansSerif,
    this.textAlign = TextAlign.left,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        value,
        style: style,
        textAlign: textAlign,

        /// There will only be one line.
        maxLines: 1,

        /// Then scaling down the text, there won't
        /// the opportunity of mulitiple text lines.
        /// Therefore there won't be a text wrap and
        /// no soft wrap.
        softWrap: false,
      ),
    );
  }
}
