import 'package:flutter/material.dart';
import 'package:lit_ui_kit/buttons.dart';
import 'package:lit_ui_kit/dialogs.dart';
import 'package:lit_ui_kit/styles.dart';
import 'package:lit_ui_kit/text.dart';

/// A button widget primarily designed to be used on the [LitTitledDialog] as
/// a [LitTitledDialog.actionButtons] item.
///
/// It does provide a less customizable [LitPushedThroughButton] basis to
/// match the [LitTitledDialog]'s styling.
class DialogActionButton extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final Color accentColor;
  final Color backgroundColor;
  final TextStyle style;
  final void Function() onPressed;

  /// Creates a [DialogActionButton].
  ///
  /// * [label] is the button's label.
  ///
  /// * [padding] is the button's outer padding.
  ///
  /// * [accentColor] is the gradient's accent color.
  ///
  /// * [backgroundColor] is the gradient's primary color.
  const DialogActionButton({
    Key? key,
    required this.label,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    this.accentColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.style = LitSansSerifStyles.button,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LitPushedThroughButton(
        onPressed: onPressed,
        accentColor: accentColor,
        backgroundColor: backgroundColor,
        child: ClippedText(
          label,
          upperCase: true,
          style: style,
        ),
      ),
    );
  }
}
