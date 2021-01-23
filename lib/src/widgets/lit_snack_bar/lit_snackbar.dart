import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A custom snackbar widget.
///
/// The snackbar will resemble a notification which will e.g. be shown on the top right of
/// the device's screen.
abstract class LitSnackbar extends Widget {
  final LitSnackbarController controller;

  const LitSnackbar({@required this.controller});
}
