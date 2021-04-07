import 'package:flutter/material.dart';

/// Controlls the focus of the currently displayed [Widget] by accessing
/// the [BuildContext].
class LitFocusController {
  final BuildContext context;

  /// Creates a [LitFocusController].
  const LitFocusController(this.context);

  /// Resets the focus on the currently displayed [Widget] by creating a new
  /// [FocusNode] instance which won't be applied to any [Widget]. This will
  /// then defocus the currently edited text field and removes the soft
  /// keyboard from the screen.
  void defocus() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
