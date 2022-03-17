import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// The [ConfirmDeleteDialog]'s `Localization`.
///
/// Contains the localized strings used on this dialog.
class ConfirmDeleteDialogLocalization {
  /// The dialog's title.
  final String title;

  /// The `delete` button label.
  final String deleteButtonLabel;

  /// The `cancel` button label.
  final String cancelButtonLabel;

  /// The description's title.
  final String descriptionTitle;

  /// The description's body.
  ///
  /// Explains the details of this action.
  final String descriptionBodyText;

  /// The confirm text's body.
  final String confirmBodyText;

  /// Creates a [ConfirmDeleteDialogLocalization].
  const ConfirmDeleteDialogLocalization({
    required this.cancelButtonLabel,
    required this.confirmBodyText,
    required this.deleteButtonLabel,
    required this.descriptionBodyText,
    required this.descriptionTitle,
    required this.title,
  });
}

/// A Leitmotif `dialogs` widget allowing to delete an object using the
/// provided [widget.onDelete] callback.
///
/// Provides a localized description explaining the consequences of deleting
/// an object.
class ConfirmDeleteDialog extends StatefulWidget {
  final ConfirmDeleteDialogLocalization? localization;
  final void Function() onDelete;
  final void Function()? onCancel;
  const ConfirmDeleteDialog({
    Key? key,
    required this.onDelete,
    this.localization,
    this.onCancel,
  }) : super(key: key);

  @override
  State<ConfirmDeleteDialog> createState() => _ConfirmDeleteDialogState();
}

class _ConfirmDeleteDialogState extends State<ConfirmDeleteDialog> {
  bool get _l10nAvail => widget.localization != null;

  /// Deletes the object using the provided `onDelete` callback and closes the
  /// dialog.
  void _onDelete() async {
    widget.onDelete();
    LitRouteController(context).closeDialog();
  }

  /// Handles the `onCancel` action by either closing the dialog or by calling
  /// the provided callback (if available).
  void _onCancel() async {
    widget.onCancel != null
        ? widget.onCancel!()
        : LitRouteController(context).closeDialog();
  }

  @override
  Widget build(BuildContext context) {
    return LitTitledDialog(
      titleText: _l10nAvail
          ? widget.localization!.title
          : LeitmotifLocalizations.of(context).confirmDeleteTitle,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LitDescriptionTextBox(
              title: _l10nAvail
                  ? widget.localization!.descriptionTitle
                  : LeitmotifLocalizations.of(context).deleteObjectTitle,
              text: _l10nAvail
                  ? widget.localization!.descriptionBodyText
                  : LeitmotifLocalizations.of(context)
                      .deleteObjectDescriptionText,
              maxLines: 3,
            ),
            Text(
              _l10nAvail
                  ? widget.localization!.confirmBodyText
                  : LeitmotifLocalizations.of(context).deleteObjectPrompt,
              textAlign: TextAlign.left,
              style: LitSansSerifStyles.caption,
            ),
          ],
        ),
      ),
      actionButtons: [
        DialogActionButton(
          data: ActionButtonData(
            title: _l10nAvail
                ? widget.localization!.cancelButtonLabel
                : LeitmotifLocalizations.of(context).cancelLabel,
            onPressed: _onCancel,
          ),
        ),
        DialogActionButton(
          data: ActionButtonData(
            title: _l10nAvail
                ? widget.localization!.deleteButtonLabel
                : LeitmotifLocalizations.of(context).deleteLabel,
            backgroundColor: LitDeleteButton.backgroundColor,
            accentColor: LitDeleteButton.accentColor,
            onPressed: _onDelete,
          ),
        ),
      ],
    );
  }
}
