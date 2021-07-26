import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Flutter widget that displays a [LitTitledDialog] allowing the user to
/// either discard his unsaved draft or to cancel the discard process.
///
/// The [onDiscard] method is called once the user confirms to discard the
/// draft.
class DiscardDraftDialog extends StatefulWidget {
  /// The text dialog's title.
  final String titleText;

  /// The 'discard' button's label.
  final String discardButtonLabel;

  /// The 'cancel' button's label.
  final String cancelButtonLabel;

  /// The info description.
  final String infoDescription;

  /// The discard action description.
  final String discardText;

  final Duration animationDuration;

  /// The callback once the discard has been confirmed.
  final void Function() onDiscard;

  /// Creates a [DiscardDraftDialog].
  ///
  /// Pass a [onDiscard] to provide logic in order to discard the changes.
  const DiscardDraftDialog({
    Key? key,
    this.titleText = "Unsaved changes",
    this.discardButtonLabel = "Discard",
    this.cancelButtonLabel = "Cancel",
    this.infoDescription = "There have been unsaved changes detected.",
    this.discardText = "Do you want to discard your changes?",
    this.animationDuration = const Duration(milliseconds: 230),
    required this.onDiscard,
  }) : super(key: key);
  @override
  _DiscardDraftDialogState createState() => _DiscardDraftDialogState();
}

class _DiscardDraftDialogState extends State<DiscardDraftDialog>
    with TickerProviderStateMixin {
  late AnimationController _appearAnimationController;

  /// Closes the dialog.
  void _onCancel() {
    LitRouteController(context).closeDialog();
  }

  double get _animationValue {
    return _appearAnimationController.value;
  }

  @override
  void initState() {
    super.initState();
    _appearAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _appearAnimationController.forward();
  }

  @override
  void dispose() {
    _appearAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitTitledDialog(
      titleText: widget.titleText,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      actionButtons: [
        DialogActionButton(
          label: widget.cancelButtonLabel,
          onPressed: _onCancel,
        ),
        DialogActionButton(
          label: widget.discardButtonLabel,
          onPressed: widget.onDiscard,
          accentColor: LitColors.lightGrey,
          backgroundColor: LitColors.mediumGrey,
          style: LitSansSerifStyles.button.copyWith(
            color: Colors.white,
          ),
        ),
      ],
      child: AnimatedBuilder(
        animation: _appearAnimationController,
        builder: (BuildContext context, Widget? _) {
          return AnimatedOpacity(
            duration: _appearAnimationController.duration!,
            opacity: 0.5 + (_animationValue * 0.5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return ExclamationRectangle(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 8.0,
                                ),
                                height: constraints.maxWidth,
                                width: constraints.maxWidth,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              widget.infoDescription,
                              textAlign: TextAlign.left,
                              style: LitSansSerifStyles.body2.copyWith(
                                color: LitColors.lightGrey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    child: Text(
                      widget.discardText,
                      textAlign: TextAlign.left,
                      style: LitSansSerifStyles.body2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
