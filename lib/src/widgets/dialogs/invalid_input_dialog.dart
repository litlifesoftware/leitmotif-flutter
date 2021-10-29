import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class InvalidInputDialogLocalization {
  final String title;
  final String infoBody;
  final String dismissLabel;

  const InvalidInputDialogLocalization({
    required this.title,
    required this.infoBody,
    required this.dismissLabel,
  });
}

/// A Leitmotif `dialogs` widget allowing to display an information text
/// stating that user input errors are present.
class InvalidInputDialog extends StatefulWidget {
  /// The dialog's localization.
  final InvalidInputDialogLocalization? localization;

  /// Handles the `dismiss` action.
  ///
  /// Closes the dialog by default.
  final void Function()? onDismiss;

  /// Creates an [InvalidInputDialog].
  const InvalidInputDialog({
    Key? key,
    this.localization,
    this.onDismiss,
  }) : super(key: key);

  @override
  State<InvalidInputDialog> createState() => _InvalidInputDialogState();
}

class _InvalidInputDialogState extends State<InvalidInputDialog>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  /// Evaluates whether localizations are provided
  bool get _l10nAvail => widget.localization != null;

  bool get _dismissCallbackAvail => widget.onDismiss != null;

  /// Handles the `onDismiss` action.
  void _onDismiss() {
    if (_dismissCallbackAvail) {
      _onDismiss();
    } else {
      LitRouteController(context).closeDialog();
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: LitAnimationDurations.dialogContentAppear,
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitTitledDialog(
      titleText: _l10nAvail
          ? widget.localization!.title
          : LeitmotifLocalizations.of(context).invalidInputLabel,
      margin: LitEdgeInsets.dialogMargin,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? _) {
          return AnimatedOpacity(
            duration: _animationController.duration!,
            opacity: _animationController.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                LitDescriptionTextBox(
                  text: _l10nAvail
                      ? widget.localization!.infoBody
                      : LeitmotifLocalizations.of(context)
                          .invalidInputExtendedBody,
                  maxLines: 3,
                ),
              ],
            ),
          );
        },
      ),
      actionButtons: [
        DialogActionButton(
          label: _l10nAvail
              ? widget.localization!.dismissLabel
              : LeitmotifLocalizations.of(context).dismissLabel,
          onPressed: _onDismiss,
        ),
      ],
    );
  }
}
