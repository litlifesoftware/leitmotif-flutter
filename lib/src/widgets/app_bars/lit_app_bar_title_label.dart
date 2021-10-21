import 'package:flutter/material.dart';
import 'package:leitmotif/text.dart';

/// A Leitmotif `app_bars` widget displaying a title label.
class LitAppBarTitleLabel extends StatelessWidget {
  /// The title label.
  final String title;

  /// The text style.
  final TextStyle style;

  /// Creates a [LitAppBarTitleLabel].
  const LitAppBarTitleLabel({
    Key? key,
    required this.title,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClippedText(
      title,
      textAlign: Navigator.canPop(context) ? TextAlign.end : TextAlign.center,
      style: style,
    );
  }
}
