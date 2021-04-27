import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class ConfirmAgeScreen extends StatefulWidget {
  final int ageRequirement;
  final void Function() onSubmit;

  const ConfirmAgeScreen({
    Key? key,
    this.ageRequirement = 13,
    required this.onSubmit,
  }) : super(key: key);
  @override
  _ConfirmAgeScreenState createState() => _ConfirmAgeScreenState();
}

class _ConfirmAgeScreenState extends State<ConfirmAgeScreen> {
  DateTime? _dateOfBirth;

  Size get _deviceSize {
    return MediaQuery.of(context).size;
  }

  void _onPressedSet() {
    LitRouteController(context).showDialogWidget(
      LitDatePickerDialog(
        onBackCallback: () {
          LitRouteController(context).closeDialog();
        },
        onSubmit: (date) {
          setState(() {
            _dateOfBirth = date;
          });

          LitRouteController(context).closeDialog();
        },
        initialDate: _dateOfBirth,
      ),
    );
  }

  int get _ageInYears {
    // If the date of birth has not been initialized, return an invalid age.
    if (_dateOfBirth == null) {
      return 0;
    }
    // Store the current time.
    DateTime now = DateTime.now();
    // Calculate the raw age.
    int age = now.year - _dateOfBirth!.year;
    // Decrease the age depending on the birth's month and day.
    //
    // If the birth's month is after the current calendar month, decrease the
    // age by one.
    if (_dateOfBirth!.month > now.month) {
      age--;
      // Else if the same month is present, check the day value and decrease the
      // age by one if necessary.
    } else if ((now.month == _dateOfBirth!.month) &&
        _dateOfBirth!.day > now.day) {
      age--;
    }
    return age;
  }

  bool get _isValidAge {
    return _ageInYears >= widget.ageRequirement;
  }

  IconData get _displayedIcon {
    return _isValidAge ? LitIcons.check : LitIcons.times;
  }

  Color get _validityColor {
    return Color(_isValidAge ? 0xFFFAFFF5 : 0xFFFFE9E9);
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
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
                          "Confirm your Age",
                          style: LitTextStyles.sansSerifHeader.copyWith(
                            color: Color(0xFF848484),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Are you 13 years old or older?",
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
                        ),
                        SizedBox(
                          height: 48.0,
                        ),
                        _ValidityLabel(
                          icon: _displayedIcon,
                          iconBackgroundColor: _validityColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Your age has been confirmed. Press on 'Submit' to continue.",
                      style: LitTextStyles.sansSerifBody.copyWith(
                        color: Color(0xFF848484),
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 96.0,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: LitPushedThroughButton(
                    backgroundColor: Color(0xFFFAFFF5),
                    borderRadius: 16.0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      "SUBMIT",
                      style: LitTextStyles.sansSerifSmallHeader.copyWith(
                        color: Color(0xFF8D8D8D),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                      ),
                    ),
                    onPressed: widget.onSubmit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _YourAgeInput extends StatefulWidget {
  final void Function() onPressedSet;
  final DateTime? selectedAge;
  final int ageInYears;
  final Color labelBackgroundColor;
  final bool isValid;
  const _YourAgeInput({
    Key? key,
    required this.onPressedSet,
    required this.selectedAge,
    required this.ageInYears,
    required this.labelBackgroundColor,
    required this.isValid,
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
                    child: _LabelText("Your age")),
                SizedBox(
                  width: constraints.maxWidth * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                      onTap: () {},
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
                                            child: Text(
                                              "${widget.ageInYears > 0 ? widget.ageInYears : '?'}",
                                              style: LitTextStyles
                                                  .sansSerifHeader
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
                        onPressed: _onPressed,
                        child: Center(
                          child: Text(
                            "SET",
                            style: LitTextStyles.sansSerifSubHeader.copyWith(
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

class _ValidityLabel extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  const _ValidityLabel({
    Key? key,
    required this.icon,
    required this.iconBackgroundColor,
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
              child: _LabelText("Valid"),
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
