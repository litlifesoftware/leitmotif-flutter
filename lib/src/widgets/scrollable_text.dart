import 'package:flutter/material.dart';

/// A scrollable text widget allowing the whole text to be readable while
/// fitting on one line.
///
/// Provide a [ScrollController] instance to manipulate the text's scroll
/// position.
class ScrollableText extends StatelessWidget {
  /// The text data.
  final String data;

  final TextStyle? style;
  final ScrollController? controller;
  final TextAlign? textAlign;

  /// Creates a [ScrollableText].
  const ScrollableText(
    this.data, {
    Key? key,
    this.style,
    this.controller,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      child: Text(
        data,
        maxLines: 1,
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}
