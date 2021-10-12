import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// The [LitVerifyAgeScreen]'s `Localization`.
///
/// Contains the localized strings used on the screen.
class LitVerifyAgeScreenLocalization {
  final String title;
  final String subtitle;
  final String selectLabel;
  final String ageInputLabel;
  final String invalidInputBody;
  final String successCardTitle;
  final String successCardSubtitle;
  final String yourAgeLabel;
  final String startLabel;
  final String submitLabel;
  final String descriptionBody;
  final String successBody;

  /// Creates a [LitVerifyAgeScreenLocalization].
  const LitVerifyAgeScreenLocalization({
    required this.title,
    required this.subtitle,
    required this.selectLabel,
    required this.ageInputLabel,
    required this.invalidInputBody,
    required this.successCardTitle,
    required this.successCardSubtitle,
    required this.yourAgeLabel,
    required this.startLabel,
    required this.submitLabel,
    required this.descriptionBody,
    required this.successBody,
  });
}

/// A Leitmotif `screen` widget.
///
/// Allows the user to submit his age by providing a date of birth and returns
/// the submited value using the [onSubmit] callback.
///
/// Verifying the user's age is required in most regions for certain features,
/// but is disabled by default.
class LitVerifyAgeScreen extends StatefulWidget {
  /// The age requirement (in years).
  ///
  /// Defaults to `0` to disable age verification
  final int minAge;

  /// The screen's localization. Includes labels and text strings displayed on
  /// this screen.
  final LitVerifyAgeScreenLocalization? localization;

  final LitDatePickerDialogLocalization? datePickerDialogLocalization;

  /// Called once the user submits a valid age.
  ///
  /// The submitted age will be returned using the callback arguement.
  final void Function(DateTime date) onSubmit;

  /// Creates a [LitVerifyAgeScreen].
  ///
  /// Provide a [localization] value to apply custom localizations.
  ///
  const LitVerifyAgeScreen({
    Key? key,
    this.minAge = 0,
    required this.onSubmit,
    this.localization,
    this.datePickerDialogLocalization,
  }) : super(key: key);
  @override
  _LitVerifyAgeScreenState createState() => _LitVerifyAgeScreenState();
}

class _LitVerifyAgeScreenState extends State<LitVerifyAgeScreen> {
  /// The user's date of birth stored as a [DateTime].
  DateTime? _dateOfBirth;

  late LitSnackbarController _snackbarController;

  Size get _deviceSize {
    return MediaQuery.of(context).size;
  }

  /// Shows the a date picker to allow the user to input his date of birth.
  void _onSubmit() {
    LitRouteController(context).showDialogWidget(
      LitDatePickerDialog(
        //localization: widget.localization.datePickerDialogLocalization,
        onSubmit: (date) {
          setState(() {
            _dateOfBirth = date;
          });
          LitRouteController(context).closeDialog();
          if (!_isValidAge) {
            _snackbarController.showSnackBar();
          }
        },
        defaultDate: _dateOfBirth,
      ),
    );
  }

  /// Handles the 'start' action.
  ///
  /// Triggers the [widget.onSubmit] method once a valid age has been provided.
  void _onStart() {
    if (_isValidAge) {
      widget.onSubmit(_dateOfBirth!);
    } else {
      _snackbarController.showSnackBar();
    }
  }

  /// Gets the user's age in years and verifies the inputted value.
  ///
  /// If the provided date of birth is in the future, the age is invalid.
  int get _ageInYears {
    // If the date of birth has not been initialized, return an invalid age.
    if (_dateOfBirth == null) {
      return -1;
    }

    return _dateOfBirth!.convertToAgeInYears;
  }

  /// Checks if the age is valid.
  bool get _isValidAge {
    return _ageInYears >= widget.minAge;
  }

  bool get _l10nAvail {
    return widget.localization != null;
  }

  @override
  void initState() {
    super.initState();
    _snackbarController = LitSnackbarController();
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      snackbars: [
        LitIconSnackbar(
          iconData: LitIcons.info,
          snackBarController: _snackbarController,
          title: _l10nAvail
              ? widget.localization!.yourAgeLabel
              : LeitmotifLocalizations.of(context).yourAgeLabel,
          text: _l10nAvail
              ? widget.localization!.invalidInputBody
              : LeitmotifLocalizations.of(context).invalidInputBody,
        ),
      ],
      body: Container(
        height: _deviceSize.height,
        width: _deviceSize.width,
        decoration: BoxDecoration(
          gradient: LitGradients.greyGradient,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: _deviceSize.height,
              ),
              child: ScrollableColumn(
                constrained: false,
                crossAxisAlignment: CrossAxisAlignment.start,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                children: [
                  LitScreenTitle(
                    title: _l10nAvail
                        ? widget.localization!.title
                        : LeitmotifLocalizations.of(context).ageInputLabel,
                    subtitle: _l10nAvail
                        ? widget.localization!.subtitle
                        : LeitmotifLocalizations.of(context).ageRequiredLabel,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: (_dateOfBirth == null || !_isValidAge)
                        ? _InvalidAgeCard(
                            dateOfBirth: _dateOfBirth,
                            ageInYears: _ageInYears,
                            l10nAvail: _l10nAvail,
                            localization: widget.localization,
                            onSubmit: _onSubmit,
                            isValidAge: _isValidAge,
                          )
                        : _ValidAgeCard(
                            isValidAge: _isValidAge,
                            l10nAvail: _l10nAvail,
                            localization: widget.localization,
                            onStart: _onStart,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A [LitTitledActionCard] providing feedback after inputting a valid age.
class _ValidAgeCard extends StatelessWidget {
  final LitVerifyAgeScreenLocalization? localization;
  final bool isValidAge;
  final bool l10nAvail;
  final void Function() onStart;
  const _ValidAgeCard(
      {Key? key,
      required this.localization,
      required this.isValidAge,
      required this.l10nAvail,
      required this.onStart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitTitledActionCard(
      title: l10nAvail
          ? localization!.successCardTitle
          : LeitmotifLocalizations.of(context).verifyAgeScreenSuccessTitle,
      subtitle: l10nAvail
          ? localization!.successCardSubtitle
          : LeitmotifLocalizations.of(context).verifyAgeScreenSuccessSubtitle,
      child: Column(
        children: [
          _InfoDescription(
            l10nAvail: l10nAvail,
            localization: localization,
          ),
          _AgeIndicator(
            isValidAge: isValidAge,
            l10nAvail: l10nAvail,
            localization: localization,
          ),
        ],
      ),
      actionButtonData: [
        ActionButtonData(
          title: l10nAvail
              ? localization!.startLabel
              : LeitmotifLocalizations.of(context).startLabel,
          onPressed: onStart,
          backgroundColor: Colors.white,
          accentColor: Colors.white,
        ),
      ],
    );
  }
}

/// A [LitTitledActionCard] allowing the user to input the date of birth.
class _InvalidAgeCard extends StatelessWidget {
  final LitVerifyAgeScreenLocalization? localization;
  final bool l10nAvail;

  final DateTime? dateOfBirth;
  final bool isValidAge;
  final int ageInYears;
  final void Function() onSubmit;
  const _InvalidAgeCard({
    Key? key,
    required this.localization,
    required this.l10nAvail,
    required this.dateOfBirth,
    required this.isValidAge,
    required this.ageInYears,
    required this.onSubmit,
  }) : super(key: key);
  final EdgeInsets _padding = const EdgeInsets.symmetric(vertical: 8.0);

  @override
  Widget build(BuildContext context) {
    return LitTitledActionCard(
      title: l10nAvail
          ? localization!.selectLabel
          : LeitmotifLocalizations.of(context).selectLabel,
      subtitle: l10nAvail
          ? localization!.ageInputLabel
          : LeitmotifLocalizations.of(context).ageInputLabel,
      child: Column(
        children: [
          _InfoDescription(
            l10nAvail: l10nAvail,
            localization: localization,
          ),
          dateOfBirth != null
              ? Padding(
                  padding: _padding,
                  child: _AgeIndicator(
                    l10nAvail: l10nAvail,
                    isValidAge: isValidAge,
                    localization: localization,
                  ),
                )
              : SizedBox(),
        ],
      ),
      actionButtonData: [
        ActionButtonData(
          title: l10nAvail
              ? localization!.submitLabel
              : LeitmotifLocalizations.of(context).submitLabel,
          onPressed: onSubmit,
        ),
      ],
    );
  }
}

class _AgeIndicator extends StatelessWidget {
  final LitVerifyAgeScreenLocalization? localization;
  final bool l10nAvail;
  final bool isValidAge;
  const _AgeIndicator({
    Key? key,
    required this.localization,
    required this.l10nAvail,
    required this.isValidAge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            SizedBox(
              width: constraints.maxWidth - 32.0 - 8.0,
              child: Text(
                isValidAge
                    ? l10nAvail
                        ? localization!.descriptionBody
                        : LeitmotifLocalizations.of(context)
                            .verifyAgeScreenSuccessBody
                    : l10nAvail
                        ? localization!.descriptionBody
                        : LeitmotifLocalizations.of(context).invalidInputBody,
                style: LitSansSerifStyles.body2,
              ),
            ),
            SizedBox(width: 8.0),
            _ValidityIconContainer(
              isValid: isValidAge,
            ),
          ],
        );
      },
    );
  }
}

class _ValidityIconContainer extends StatelessWidget {
  final bool isValid;
  static const double _height = 32.0;
  static const double _width = 32.0;
  static const BorderRadius _borderRadius =
      const BorderRadius.all(Radius.circular(12.0));
  static const Color _bgColorValid = Color(0xFFECFFE9);
  static const Color _bgColorInvalid = Color(0xFFF2E4E4);
  static const double _iconSize = 13.0;
  static const Color _iconColor = Color(0xFF616161);
  static const IconData _iconValid = LitIcons.check;
  static const IconData _iconInvalid = LitIcons.times;

  const _ValidityIconContainer({
    Key? key,
    required this.isValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        color: isValid ? _bgColorValid : _bgColorInvalid,
        boxShadow: LitBoxShadows.sm,
        borderRadius: _borderRadius,
      ),
      child: Center(
        child: Icon(
          isValid ? _iconValid : _iconInvalid,
          size: _iconSize,
          color: _iconColor,
        ),
      ),
    );
  }
}

/// A Flutter widget displaying a text for what backups are used for.
class _InfoDescription extends StatelessWidget {
  final LitVerifyAgeScreenLocalization? localization;
  final bool l10nAvail;

  const _InfoDescription({
    Key? key,
    required this.localization,
    required this.l10nAvail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitDescriptionTextBox(
      padding: const EdgeInsets.all(0),
      text: l10nAvail
          ? localization!.descriptionBody
          : LeitmotifLocalizations.of(context).verifyAgeScreenDescriptionBody,
    );
  }
}
