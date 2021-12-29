import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// The [DiscardDraftDialog]'s `Localization`.
///
/// Contains the localized strings used on this dialog.
class DiscardDraftDialogLocalization {
  /// The dialog's title.
  final String title;

  /// The `discard` button label.
  ///
  /// Defaults to `Discard`.
  final String discardButtonLabel;

  /// The `cancel` button label.
  ///
  /// Defaults to `Cancel`.
  final String cancelButtonLabel;

  /// The description's body.
  ///
  /// Defaults to `There have been unsaved changes detected.`.
  final String descriptionBody;

  /// The confirm text's body.
  ///
  /// Defaults to `Do you want to discard your changes?`.
  final String confirmDiscardBody;

  /// Creates a [DiscardDraftDialogLocalization].
  const DiscardDraftDialogLocalization({
    required this.title,
    required this.discardButtonLabel,
    required this.cancelButtonLabel,
    required this.descriptionBody,
    required this.confirmDiscardBody,
  });
}

/// A `Leitmotif` widget allowing the user to confirm discarding the current
/// draft.
///
/// [onDiscard] is called once the user confirms to discard the draft.
class DiscardDraftDialog extends StatefulWidget {
  /// The dialog's localization.
  final DiscardDraftDialogLocalization? localization;

  final EdgeInsets margin;

  /// The initial animation's duration.
  final Duration animationDuration;

  /// The callback once the discard has been confirmed.
  final void Function() onDiscard;

  /// Creates a [DiscardDraftDialog].
  const DiscardDraftDialog({
    Key? key,
    this.localization,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 8.0,
    ),
    this.animationDuration = const Duration(milliseconds: 230),
    required this.onDiscard,
  }) : super(key: key);
  @override
  _DiscardDraftDialogState createState() => _DiscardDraftDialogState();
}

class _DiscardDraftDialogState extends State<DiscardDraftDialog>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  /// Closes the dialog.
  void _onCancel() {
    LitRouteController(context).closeDialog();
  }

  /// The current animation value.
  double get _animationValue {
    return _animationController.value;
  }

  /// The current animated opacity.
  double get _opacity {
    double minOpacity = 0.5;
    return minOpacity + (_animationValue * (1.0 - minOpacity));
  }

  /// Returns whether custom localizations are available.
  bool get _l10nAvail {
    return widget.localization != null;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animationController.forward();
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
          : LeitmotifLocalizations.of(context).unsavedChangesLabel,
      margin: widget.margin,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? _) {
          return AnimatedOpacity(
            duration: _animationController.duration!,
            opacity: _opacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _Spacing(),
                LitDescriptionTextBox(
                  text: _l10nAvail
                      ? widget.localization!.descriptionBody
                      : LeitmotifLocalizations.of(context).discardDesc,
                  maxLines: 3,
                ),
                ClippedText(
                  _l10nAvail
                      ? widget.localization!.confirmDiscardBody
                      : LeitmotifLocalizations.of(context)
                          .confirmDiscardActionDescr,
                  textAlign: TextAlign.left,
                  style: LitSansSerifStyles.body2,
                  maxLines: 2,
                ),
                _Spacing(),
              ],
            ),
          );
        },
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
                ? widget.localization!.discardButtonLabel
                : LeitmotifLocalizations.of(context).discardLabel,
            accentColor: LitColors.red200,
            backgroundColor: LitColors.red200,
            onPressed: widget.onDiscard,
          ),
        ),
      ],
    );
  }
}

/// A spacing item seperating individual widgets.
class _Spacing extends StatelessWidget {
  final double height = 8.0;
  const _Spacing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
