import 'package:flutter/material.dart';

/// A Leitmotif `models` class containing data text inputs.
class TextFieldData {
  /// The field's label.
  final String label;

  /// The hint text displayed, once the validation failed.
  ///
  /// The hint texts are only displayed, if the [onValidate] callback has been
  /// provided.
  final String? invalidHint;

  /// States whether to obscure the inputted text.
  final bool obscureText;

  /// An icon corresponding to the label.
  final IconData? icon;

  /// Handles the input field's `on change` event.
  final void Function(String value) onChange;

  /// Validates the inputted string.
  ///
  /// Returns a boolean validation result.
  final bool Function(String)? onValidate;

  /// Returns the inputted string after a `submit` action has been registered.
  final void Function(String value)? onSubmitted;

  /// Creates a [TextFieldData].
  const TextFieldData({
    required this.label,
    required this.onChange,
    this.icon,
    this.invalidHint,
    this.obscureText = false,
    this.onValidate,
    this.onSubmitted,
  });
}
