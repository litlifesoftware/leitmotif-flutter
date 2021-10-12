import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// The [LitDatePickerDialog]'s `Localization`.
///
/// Contains the localized strings used on the dialog.
class LitDatePickerDialogLocalization {
  /// The date picker's localization.
  final LitDatePickerLocalization? pickerLocalization;

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
  final LitDatePickerDialogLocalization? localization;

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
    this.localization,
    this.title,
    this.defaultDate,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    required this.onSubmit,
  }) : super(key: key);
  @override
  _LitDatePickerDialogState createState() => _LitDatePickerDialogState();
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
          widget.title ?? LeitmotifLocalizations.of(context).dateInputLabel,
      margin: widget.margin,
      child: LitDatePicker(
        defaultDate: widget.defaultDate,
        onSelectDate: _onSelectDate,
        localization: widget.localization != null
            ? widget.localization!.pickerLocalization!
            : LitDatePickerLocalization(
                dayOfWeek1: LeitmotifLocalizations.of(context).dayOfWeek1,
                dayOfWeek2: LeitmotifLocalizations.of(context).dayOfWeek2,
                dayOfWeek3: LeitmotifLocalizations.of(context).dayOfWeek3,
                dayOfWeek4: LeitmotifLocalizations.of(context).dayOfWeek4,
                dayOfWeek5: LeitmotifLocalizations.of(context).dayOfWeek5,
                dayOfWeek6: LeitmotifLocalizations.of(context).dayOfWeek6,
                dayOfWeek7: LeitmotifLocalizations.of(context).dayOfWeek7,
                january: LeitmotifLocalizations.of(context).january,
                february: LeitmotifLocalizations.of(context).february,
                march: LeitmotifLocalizations.of(context).march,
                april: LeitmotifLocalizations.of(context).april,
                may: LeitmotifLocalizations.of(context).may,
                june: LeitmotifLocalizations.of(context).june,
                july: LeitmotifLocalizations.of(context).july,
                august: LeitmotifLocalizations.of(context).august,
                september: LeitmotifLocalizations.of(context).september,
                october: LeitmotifLocalizations.of(context).october,
                november: LeitmotifLocalizations.of(context).november,
                december: LeitmotifLocalizations.of(context).december,
                cancelButtonLabel:
                    LeitmotifLocalizations.of(context).cancelLabel,
              ),
      ),
      actionButtons: [
        DialogActionButton(
          onPressed: _onSubmitDate,
          label: widget.localization != null
              ? widget.localization!.submitLabel
              : LeitmotifLocalizations.of(context).submitLabel,
          disabled: _invalidDate,
        )
      ],
    );
  }
}
