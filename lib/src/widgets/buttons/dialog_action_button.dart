import 'package:flutter/material.dart';
import 'package:leitmotif/buttons.dart';
import 'package:leitmotif/dialogs.dart';
import 'package:leitmotif/styles.dart';
import 'package:leitmotif/text.dart';

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
  final bool disabled;
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
    this.disabled = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LitPushedThroughButton(
        onPressed: onPressed,
        disabled: disabled,
        accentColor: accentColor,
        backgroundColor: backgroundColor,
        child: ClippedText(
          label,
          upperCase: true,
          textAlign: TextAlign.center,
          style: style,
        ),
      ),
    );
  }
}
