import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// Prevents the [Text] widget from clipping by
/// setting an overflow property. The text can
/// either be on one line or on mulitple lines.
/// This will be needed to avoid pixel overflow
/// if very long strings are displayed on small
/// devices e.g. displaying a long first or last
/// name inside constrained widgets.
class ClippedText extends StatelessWidget {
  final String value;
  final TextStyle style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;
  final bool softWrap;
  const ClippedText(
    this.value, {
    Key key,
    this.style = LitTextStyles.sansSerif,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: style,
      textAlign: textAlign ?? TextAlign.left,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines ?? 1,

      /// The soft wrap will determine whether or not
      /// the text should continue on the next break.
      /// The text should wrap by default.
      softWrap: softWrap ?? true,
    );
  }
}
