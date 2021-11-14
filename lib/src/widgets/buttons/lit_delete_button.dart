import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `buttons` widget allowing to delete an object by pressing a
/// button.
class LitDeleteButton extends StatelessWidget {
  /// Handles the `onPressed` action.
  final void Function() onPressed;

  /// Creates a [LitDeleteButton].
  const LitDeleteButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitPushedThroughButton(
      accentColor: LitColors.red400,
      backgroundColor: LitColors.red200,
      child: ClippedText(
        LeitmotifLocalizations.of(context).deleteLabel.toUpperCase(),
        style: LitSansSerifStyles.button.copyWith(
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
