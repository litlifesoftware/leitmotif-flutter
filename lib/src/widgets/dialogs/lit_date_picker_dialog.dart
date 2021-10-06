import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// The [LitDatePickerDialog]'s `Localization`.
///
/// Contains the localized strings used on the dialog.
class LitDatePickerDialogLocalization {
  /// The date picker's localization.
  final LitDatePickerLocalization pickerLocalization;

  /// The `submit`'s button label.
  final String submitLabel;

  /// Creates a [LitDatePickerDialogLocalization].
  const LitDatePickerDialogLocalization({
    required this.pickerLocalization,
    required this.submitLabel,
  });
}

/// A Leitmotif `dialog` widget.
///
/// Allows the user to submit a date.
///
/// Returns the submitted date as a [DateTime] using the [onSubmit] method
/// allowing further validation on the parent widget.
///
class LitDatePickerDialog extends StatefulWidget {
  /// The localization applied on this dialog.
  final LitDatePickerDialogLocalization localization;

  /// The dialog's title.
  final String? title;

  /// The initial date the calendar will start at.
  ///
  /// If none provided, use [DateTime.now].
  final DateTime? defaultDate;

  /// The dialog's margin.
  final EdgeInsets margin;

  final void Function(DateTime) onSubmit;

  /// Creates a [LitDatePickerDialog].
  const LitDatePickerDialog({
    Key? key,
    this.localization = defaultLocalization,
    this.title,
    this.defaultDate,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    required this.onSubmit,
  }) : super(key: key);
  @override
  _LitDatePickerDialogState createState() => _LitDatePickerDialogState();

  /// The default localization.
  ///
  /// Applied on the screen if none [localization] has been provided.
  static const LitDatePickerDialogLocalization defaultLocalization =
      LitDatePickerDialogLocalization(
    pickerLocalization: LitDatePicker.defaultLocalization,
    submitLabel: "Submit",
  );
}

class _LitDatePickerDialogState extends State<LitDatePickerDialog> {
  /// The currently selected date. `null` as long as none date has been
  /// selected.
  DateTime? selectedDate;

  /// Handles the `select date` action by either resetting the current date
  /// or updating the date using the provided [date] value.
  void _onSelectDate(DateTime? date) {
    if (selectedDate == date) {
      _resetDate();
    } else {
      _setDate(date);
    }
  }

  /// Resets the [selectedDate] value using by setting the state.
  void _resetDate() {
    setState(() {
      selectedDate = null;
    });
  }

  /// Sets the [selectedDate] value using by provided value..

  void _setDate(DateTime? date) {
    setState(() {
      selectedDate = date;
    });
    // print(date.toIso8601String());
  }

  /// Handles the `submit date` action by triggering the parent's callback.
  void _onSubmitDate() {
    widget.onSubmit(selectedDate!);
  }

  /// States whether the currently selected date is invalid.
  bool get _invalidDate {
    return selectedDate == null;
  }

  @override
  Widget build(BuildContext context) {
    return LitTitledDialog(
      titleText:
          widget.title ?? MaterialLocalizations.of(context).dateInputLabel,
      margin: widget.margin,
      child: LitDatePicker(
        defaultDate: widget.defaultDate,
        onSelectDate: _onSelectDate,
        localization: widget.localization.pickerLocalization,
      ),
      actionButtons: [
        DialogActionButton(
          onPressed: _onSubmitDate,
          label: widget.localization.submitLabel,
          disabled: _invalidDate,
        )
      ],
    );
  }
}
