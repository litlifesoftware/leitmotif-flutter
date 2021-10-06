import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// The [LitVerifyAgeScreen]'s `Localization`.
///
/// Contains the localized strings used on the screen.
class LitVerifyAgeScreenLocalization {
  final String title;
  final String subtitle;
  final String errorCardTitle;
  final String errorCardSubtitle;
  final String errorTextBody;
  final String successCardTitle;
  final String successCardSubtitle;
  final String yourAgeLabel;
  final String startButtonLabel;
  final String submitButtonLabel;
  final String descriptionTextBody;
  final String successTextBody;

  /// Creates a [LitVerifyAgeScreenLocalization].
  const LitVerifyAgeScreenLocalization({
    required this.title,
    required this.subtitle,
    required this.errorCardTitle,
    required this.errorCardSubtitle,
    required this.errorTextBody,
    required this.successCardTitle,
    required this.successCardSubtitle,
    required this.yourAgeLabel,
    required this.startButtonLabel,
    required this.submitButtonLabel,
    required this.descriptionTextBody,
    required this.successTextBody,
  });
}

/// A Leitmotif `screen` widget.
///
/// Allows the user to submit an age by providing a date of birth. Verifying the
/// user's age is required in most regions and is generally considered good
/// practice.
///
class LitVerifyAgeScreen extends StatefulWidget {
  /// The default localization.
  ///
  /// Applied on the screen if none [localizationData] has been provided.
  static const LitVerifyAgeScreenLocalization _defaultLocalization =
      LitVerifyAgeScreenLocalization(
    title: "Confirm your Age",
    subtitle: "Are you 13 years old or older?",
    errorCardTitle: "Select",
    errorCardSubtitle: "Select your age",
    errorTextBody:
        "Please check your input. You may not be old enough to use this app.",
    successCardTitle: "Age confirmed",
    successCardSubtitle: "Your age has been confirmed",
    yourAgeLabel: "Your age",
    startButtonLabel: "Start",
    submitButtonLabel: "Submit",
    descriptionTextBody:
        "Your date of birth helps us to confirm that you are old enough"
        "to use this app. This app does not send any information to"
        "anyone. Your age will not be shared.",
    successTextBody: "Thank you for confirming your age. Have a good time!",
  );

  /// The age requirement (in years).
  ///
  /// Defaults to `13`.
  final int ageRequirement;

  /// The screen's localization. Includes labels and text strings displayed on
  /// this screen.
  final LitVerifyAgeScreenLocalization localizationData;

  /// Called once the user submits a valid age.
  ///
  /// The submitted age will be returned using the callback arguement.
  final void Function(DateTime date) onSubmit;

  /// Creates a [LitVerifyAgeScreen].
  ///
  /// Provide a [localizationData] value to apply custom localizations.
  ///
  const LitVerifyAgeScreen({
    Key? key,
    this.ageRequirement = 13,
    required this.onSubmit,
    this.localizationData = _defaultLocalization,
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
        onSubmit: (date) {
          setState(() {
            _dateOfBirth = date;
            print(date.toIso8601String());
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

  /// Gets the user's age in years.
  int get _ageInYears {
    // If the date of birth has not been initialized, return an invalid age.
    if (_dateOfBirth == null) {
      return 0;
    }

    return _dateOfBirth!.convertToAgeInYears;
  }

  /// Checks if the age is valid.
  bool get _isValidAge {
    return _ageInYears >= widget.ageRequirement;
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
          title: widget.localizationData.yourAgeLabel,
          text: widget.localizationData.errorTextBody,
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
                    title: widget.localizationData.title,
                    subtitle: widget.localizationData.subtitle,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: (_dateOfBirth == null || !_isValidAge)
                        ? _InvalidAgeCard(
                            dateOfBirth: _dateOfBirth,
                            ageInYears: _ageInYears,
                            localizationData: widget.localizationData,
                            onSubmit: _onSubmit,
                            isValidAge: _isValidAge,
                          )
                        : _ValidAgeCard(
                            isValidAge: _isValidAge,
                            localizationData: widget.localizationData,
                            onStart: _onStart,
                          ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Text(
                    _dateOfBirth != null ? _dateOfBirth!.toIso8601String() : "",
                  )
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
  final LitVerifyAgeScreenLocalization localizationData;
  final bool isValidAge;
  final void Function() onStart;
  const _ValidAgeCard(
      {Key? key,
      required this.localizationData,
      required this.isValidAge,
      required this.onStart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitTitledActionCard(
      title: localizationData.successCardTitle,
      subtitle: localizationData.successCardSubtitle,
      child: Column(
        children: [
          _InfoDescription(
            localizationData: localizationData,
          ),
          _AgeIndicator(
            isValidAge: isValidAge,
            localizationData: localizationData,
          ),
        ],
      ),
      actionButtonData: [
        ActionButtonData(
          title: "Start",
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
  final LitVerifyAgeScreenLocalization localizationData;
  final DateTime? dateOfBirth;
  final bool isValidAge;
  final int ageInYears;
  final void Function() onSubmit;
  const _InvalidAgeCard({
    Key? key,
    required this.localizationData,
    required this.dateOfBirth,
    required this.isValidAge,
    required this.ageInYears,
    required this.onSubmit,
  }) : super(key: key);
  final EdgeInsets _padding = const EdgeInsets.symmetric(vertical: 8.0);

  @override
  Widget build(BuildContext context) {
    return LitTitledActionCard(
      title: localizationData.errorCardTitle,
      subtitle: localizationData.errorCardSubtitle,
      child: Column(
        children: [
          _InfoDescription(
            localizationData: localizationData,
          ),
          dateOfBirth != null
              ? Padding(
                  padding: _padding,
                  child: _AgeIndicator(
                    isValidAge: isValidAge,
                    localizationData: localizationData,
                  ),
                )
              : SizedBox(),
        ],
      ),
      actionButtonData: [
        ActionButtonData(
          title: localizationData.submitButtonLabel,
          onPressed: onSubmit,
          backgroundColor: Colors.white,
          accentColor: Colors.white,
        ),
      ],
    );
  }
}

class _AgeIndicator extends StatelessWidget {
  final LitVerifyAgeScreenLocalization localizationData;
  final bool isValidAge;
  const _AgeIndicator({
    Key? key,
    required this.localizationData,
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
                    ? localizationData.successTextBody
                    : localizationData.errorTextBody,
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
  final LitVerifyAgeScreenLocalization localizationData;
  const _InfoDescription({
    Key? key,
    required this.localizationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitDescriptionTextBox(
      padding: const EdgeInsets.all(0),
      text: localizationData.descriptionTextBody,
    );
  }
}
