import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A screen widget allowing the user to submit his age.
///
/// Age requirements vary depending on the user's location. In most cases, using
/// apps downloaded on app stores require the user to be at least 13 years old.
///
/// The [ConfirmAgeScreen] implements a very basic child protection on the first
/// startup.
class ConfirmAgeScreen extends StatefulWidget {
  /// The age requirement (in years).
  final int ageRequirement;

  /// The message displayed if the user's age don't comply with the age
  /// requirement.
  final String invalidAgeText;

  /// The screen's title.
  final String title;

  /// The screen's subtitle.
  final String subtitle;

  /// Called once the user submits a valid age.
  ///
  /// The submitted age will be returned using the callback arguement.
  final void Function(DateTime date) onSubmit;

  /// The 'set' text label.
  final String setLabel;

  /// The 'submit' text label.
  final String submitLabel;

  /// The 'your age' text label.
  final String yourAgeLabel;

  /// The 'valid' text label.
  final String validLabel;

  final String chooseDateLabel;

  /// Creates a [ConfirmAgeScreen].
  ///
  /// * [ageRequirement] is the required age in years.
  ///
  /// * [invalidAgeText] is the text displayed if the user's age is too
  ///   young. Provide a localized string if preferred.
  ///
  /// * [validAgeMessage] is the text displayed if the user's age is valid.
  ///   Provide a localized string if preferred.
  ///
  /// * [title] is the screen's title.
  ///
  /// * [subtitle] is the screen's subtitle.
  ///
  /// * [setLabel] is the 'set' text.
  ///
  /// * [submitLabel] is the 'submit' text.
  ///
  /// * [yourAgeLabel] is the 'your age' text.
  ///
  /// * [validLabel] is the 'valid' text.
  ///
  /// * [chooseDateLabel] is the [LitDatePickerDialog]'s title.
  const ConfirmAgeScreen({
    Key? key,
    this.ageRequirement = 13,
    this.invalidAgeText =
        "Seems like you are not old enough to use this app. " +
            "Please check your inputted age",
    this.title = "Confirm your Age",
    this.subtitle = "Are you 13 years old or older?",
    required this.onSubmit,
    this.setLabel = "Set",
    this.submitLabel = "Submit",
    this.yourAgeLabel = "Your age",
    this.validLabel = "Valid",
    this.chooseDateLabel = "Choose date",
  }) : super(key: key);
  @override
  _ConfirmAgeScreenState createState() => _ConfirmAgeScreenState();
}

class _ConfirmAgeScreenState extends State<ConfirmAgeScreen> {
  /// The user's date of birth stored as a [DateTime].
  DateTime? _dateOfBirth;

  late LitSnackbarController _snackbarController;

  Size get _deviceSize {
    return MediaQuery.of(context).size;
  }

  /// Shows the [LitDatePickerDialog] to allow user input.
  void _onPressedSet() {
    LitRouteController(context).showDialogWidget(
      LitDatePickerDialog(
        title: widget.chooseDateLabel,
        onBackCallback: () {
          LitRouteController(context).closeDialog();
        },
        onSubmit: (date) {
          if (this.mounted) {
            setState(() {
              _dateOfBirth = date;
            });
            LitRouteController(context).closeDialog();
          }
        },
        initialDate: _dateOfBirth,
      ),
    );
  }

  /// Handles the 'submit' action by either calling the provided callback
  /// method or showing a snackbar depending on the age's validity.
  void _onPressedSubmit() {
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

  /// Conditionally returns the validity's icon.
  IconData get _displayedIcon {
    return _isValidAge ? LitIcons.check : LitIcons.times;
  }

  /// Conditionally returns the validity's color.
  Color get _validityColor {
    return Color(_isValidAge ? 0xFFFAFFF5 : 0xFFFFE9E9);
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
          text: widget.invalidAgeText,
        ),
      ],
      body: Container(
        height: _deviceSize.height,
        width: _deviceSize.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFE8E8E8),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: _deviceSize.height),
              child: ScrollableColumn(
                constrained: false,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 42.0,
                      bottom: 36.0,
                      left: 24.0,
                      right: 24.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: LitTextStyles.sansSerifHeader.copyWith(
                            color: Color(0xFF848484),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            widget.subtitle,
                            style: LitTextStyles.sansSerifBody.copyWith(
                              color: Color(0xFF848484),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  LitElevatedCard(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 24.0,
                    ),
                    child: Column(
                      children: [
                        _YourAgeInput(
                          selectedAge: _dateOfBirth,
                          onPressedSet: _onPressedSet,
                          ageInYears: _ageInYears,
                          labelBackgroundColor: _validityColor,
                          isValid: _isValidAge,
                          setLabel: widget.setLabel,
                          yourAgeLabel: widget.yourAgeLabel,
                        ),
                        SizedBox(
                          height: 48.0,
                        ),
                        _ValidityLabel(
                          icon: _displayedIcon,
                          iconBackgroundColor: _validityColor,
                          validLabel: widget.validLabel,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  !_isValidAge
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            widget.invalidAgeText,
                            style: LitTextStyles.sansSerifBody.copyWith(
                              color: Color(0xFF848484),
                              letterSpacing: 1.0,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: LitPushedThroughButton(
                  disabled: !_isValidAge,
                  backgroundColor: _validityColor,
                  borderRadius: 16.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    widget.submitLabel.toUpperCase(),
                    style: LitTextStyles.sansSerifStyles[button].copyWith(
                      color: Color(0xFF8D8D8D),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                    ),
                  ),
                  onPressed: _onPressedSubmit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Label and button combination to allow age input.
class _YourAgeInput extends StatefulWidget {
  final void Function() onPressedSet;
  final DateTime? selectedAge;
  final int ageInYears;
  final Color labelBackgroundColor;
  final bool isValid;
  final String setLabel;
  final String yourAgeLabel;
  const _YourAgeInput({
    Key? key,
    required this.onPressedSet,
    required this.selectedAge,
    required this.ageInYears,
    required this.labelBackgroundColor,
    required this.isValid,
    required this.setLabel,
    required this.yourAgeLabel,
  }) : super(key: key);

  @override
  __YourAgeInputState createState() => __YourAgeInputState();
}

class __YourAgeInputState extends State<_YourAgeInput> {
  void _onPressed() {
    widget.onPressedSet();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: constraints.maxWidth * 0.65,
                  child: _LabelText(widget.yourAgeLabel),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      widget.selectedAge != null
                          ? Row(
                              children: [
                                !widget.isValid
                                    ? SizedBox(
                                        width: constraints.maxWidth * 0.10,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                constraints.maxWidth * 0.015,
                                          ),
                                          child: LitBadge(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2.0,
                                              horizontal: 2.0,
                                            ),
                                            backgroundColor:
                                                widget.labelBackgroundColor,
                                            child: Text(
                                              "!",
                                              style: LitTextStyles
                                                  .sansSerifHeader
                                                  .copyWith(
                                                color: LitColors.mediumGrey,
                                                fontSize: 12.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  width: constraints.maxWidth *
                                      (widget.isValid ? 0.35 : 0.25),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: CleanInkWell(
                                      onTap: widget.onPressedSet,
                                      child: SizedBox(
                                        child: Container(
                                          height: 38.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(14.0)),
                                            color: widget.labelBackgroundColor,
                                            border: Border.all(
                                              color: Color(0xFFCBCACA),
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Center(
                                            child: ClippedText(
                                              "${widget.ageInYears > 0 ? widget.ageInYears : '?'}",
                                              style: LitTextStyles
                                                  .sansSerifStyles[header5]
                                                  .copyWith(
                                                color: widget.ageInYears > 0
                                                    ? Color(0xFF5B5B5B)
                                                    : Color(0xFF000000),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : SizedBox(),
                      LitPushedThroughButton(
                        borderRadius: 16.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 30.0,
                        ),
                        onPressed: _onPressed,
                        child: Center(
                          child: ClippedText(
                            widget.setLabel.toUpperCase(),
                            style:
                                LitTextStyles.sansSerifStyles[button].copyWith(
                              color: Color(0xFF5B5B5B),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// Label to display the current 'your age is (in)valid' state.
class _ValidityLabel extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final String validLabel;
  const _ValidityLabel({
    Key? key,
    required this.icon,
    required this.iconBackgroundColor,
    required this.validLabel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.78,
              child: _LabelText(validLabel),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.22,
              child: Container(
                height: constraints.maxWidth * 0.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      constraints.maxWidth * 0.07,
                    ),
                  ),
                  color: iconBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.black38,
                      offset: const Offset(-3, 3),
                      spreadRadius: -1.0,
                    )
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      color: Color(0xFF727272),
                      size: constraints.maxWidth * 0.09,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Styled [Text] using uppercase letters.
class _LabelText extends StatelessWidget {
  final String text;

  const _LabelText(this.text, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: LitTextStyles.sansSerifSubHeader.copyWith(
        color: Color(0xFFAFAFAF),
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }
}
