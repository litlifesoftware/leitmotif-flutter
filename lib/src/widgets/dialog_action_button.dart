import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `button` widget primarily designed to be used on dialog widget
/// to trigger an action.
class DialogActionButton extends StatelessWidget {
  /// The button's data required to build the widget.
  final ActionButtonData data;

  /// The button's outter padding.
  final EdgeInsets padding;

  /// Creates a [DialogActionButton].
  const DialogActionButton({
    Key? key,
    required this.data,
    this.padding = LitEdgeInsets.buttonSM,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LitPushedThroughButton(
        onPressed: data.onPressed,
        disabled: data.disabled,
        accentColor: data.accentColor,
        backgroundColor: data.backgroundColor,
        child: ClippedText(
          data.title,
          upperCase: true,
          textAlign: TextAlign.center,
          style: data.style,
        ),
      ),
    );
  }
}
