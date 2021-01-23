import 'dart:ui';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:lit_ui_kit/src/util/calendar_controller.dart';

import 'age_confirmation_controller.dart';
import 'age_confirmation_calendar_date_indicators.dart';
import 'age_confirmation_calendar_grid.dart';
import 'age_confirmation_calendar_navigator.dart';
import 'age_confirmation_weekday_labels.dart';

/// A screen widget to verify the user's age.
///
/// The user is asked to input his age and the resulting [DateTime] will be extracted
/// from the calendar view.
class AgeConfirmationScreen extends StatefulWidget {
  /// The callback [Function] called once the selected date of birth is submitted
  /// by the user.
  ///
  /// The method could then in turn trigger an database transaction.
  final void Function(DateTime) onSubmitCallback;

  /// The age the user is required to be in order to use the application.
  ///
  /// The age will be passed in years.
  final int requiredAge;

  /// The [Text] value which will display the screen title.
  final String titleLabel;

  /// The [Text] value which will be displayed on the submit button.
  final String submitButtonLabel;

  /// The [Text] value which will be displayed on the [TransparentInfoBar]
  /// if the user selects a date which is below the required age.
  final String notOldEnoughLabel;

  /// The [Text] value which will be displayed on the [SlidingSnackbar] once
  /// the user tries to select a day which is not in the displayed month.
  final String changeTheMonthLabel;

  /// The [Text] value which will label the month selectors.
  /// E.g. the English label would be `Month`.
  final String monthLabel;

  /// The [Text] value which will label the year selectors.
  /// E.g. the English label would be `Year`.
  final String yearLabel;

  /// Creates an [AgeConfirmationScreen].
  ///
  /// The [requiredAge] may vary across differen regions. Ensure to pass the
  /// corrsponding age for your country.
  ///
  /// For localization purposes each label can display different [String]s.
  /// Pass different argument values to override the default English localization.
  const AgeConfirmationScreen({
    Key key,
    @required this.onSubmitCallback,
    this.requiredAge = 13,
    this.titleLabel = "Set your day of birth",
    this.submitButtonLabel = "Continue with this date",
    this.notOldEnoughLabel = "You may are not old enough to use this app.",
    this.changeTheMonthLabel = "Change the selected month to apply this date.",
    this.monthLabel = "Month",
    this.yearLabel = "Year",
  }) : super(key: key);
  @override
  _AgeConfirmationScreenState createState() => _AgeConfirmationScreenState();
}

class _AgeConfirmationScreenState extends State<AgeConfirmationScreen>
    with TickerProviderStateMixin {
  AnimationController _calendarTransition;
  LitSnackbarController _customSnackBarController;

  AgeConfirmationController _ageConfirmationController;
  CalendarController _calendarController = CalendarController();
  bool _shouldAnimateMonthTransition;
  bool _shouldAnimateYearTransition;

  Locale _locale;

  void _decreaseByMonth() {
    setState(() => _calendarController.decreaseByMonth());
    _calendarTransition.forward(from: 0);
    _shouldAnimateMonthTransition = !_shouldAnimateMonthTransition;
  }

  void _increaseByMonth() {
    setState(() => _calendarController.increaseByMonth());
    _calendarTransition.forward(from: 0);
    _shouldAnimateMonthTransition = !_shouldAnimateMonthTransition;
  }

  void _decreaseByYear() {
    setState(() => _calendarController.decreaseByYear());
    _calendarTransition.forward(from: 0);
    _shouldAnimateYearTransition = !_shouldAnimateYearTransition;
  }

  void _increaseByYear() {
    setState(() => _calendarController.increaseByYear());
    _calendarTransition.forward(from: 0);
    _shouldAnimateYearTransition = !_shouldAnimateYearTransition;
  }

  void onDayCardTap(DateTime iteratedDate) {
    if (iteratedDate.month == _calendarController.templateDate.month) {
      if (_ageConfirmationController.selectedDate == null) {
        if (_ageConfirmationController.sameMonth(
            iteratedDate, _calendarController.templateDate)) {
          setState(() {
            _ageConfirmationController.setSelectedDate(iteratedDate);
          });
        }
      } else {
        if (iteratedDate == _ageConfirmationController.selectedDate) {
          setState(() {
            _ageConfirmationController.selectedDate = null;
          });
        } else {
          setState(() {
            _ageConfirmationController.setSelectedDate(iteratedDate);
          });
        }
      }
    } else {
      _customSnackBarController.showSnackBar();
    }
  }

  @override
  void initState() {
    initializeDateFormatting();
    try {
      _locale = Locale(Platform.localeName);
    } catch (e) {
      _locale = Locale('en', 'US');
    }
    _customSnackBarController = LitSnackbarController();

    _calendarTransition =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _calendarTransition.forward();
    _shouldAnimateMonthTransition = false;
    _shouldAnimateYearTransition = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _ageConfirmationController =
        AgeConfirmationController(requiredAge: widget.requiredAge ?? 13);
  }

  @override
  void dispose() {
    _calendarTransition.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      backgroundColor: Colors.white,
      infoBar: _ageConfirmationController.selectedDate != null &&
              !_ageConfirmationController
                  .dayOfBirthIsValid(_ageConfirmationController.selectedDate)
          ? TransparentInfoBar(
              text: "${widget.notOldEnoughLabel}",
              textStyle: LitTextStyles.sansSerif.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                  color: LitColors.midRed.withOpacity(0.8)),
              iconColor: LitColors.mediumGrey,
            )
          : DummyInfoBar(),
      snackBar: SlidingSnackbar(
        customSnackBarController: _customSnackBarController,
        width: MediaQuery.of(context).size.width / 2,
        height: 80.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "${widget.changeTheMonthLabel}",
              textAlign: TextAlign.left,
              style: LitTextStyles.sansSerif.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w800,
                color: LitColors.mediumGrey.withOpacity(0.4),
              ),
            ),
          ),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.0),
          topLeft: Radius.circular(25.0),
        ),
        alignment: Alignment.topRight,
        padding: const EdgeInsets.symmetric(vertical: 32.0),
      ),
      actionButton: _ageConfirmationController.selectedDate != null &&
              _ageConfirmationController
                  .dayOfBirthIsValid(_ageConfirmationController.selectedDate)
          ? AnimatedActionButton(
              alignment: Alignment.bottomCenter,
              backgroundColor: LitColors.mediumGrey.withOpacity(0.5),
              onPressed: () {
                DateTime age = _ageConfirmationController.selectedDate;
                widget.onSubmitCallback(age);
              },
              child: Text(
                "${widget.submitButtonLabel} (${DateFormat.yMMMd('$_locale').format(_ageConfirmationController.selectedDate)})",
                textAlign: TextAlign.center,
                style: LitTextStyles.sansSerif.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            )
          : DummyActionButton(),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 42.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 16.0,
                        ),
                        child: ScaledDownText(
                          "${widget.titleLabel}",
                          textAlign: TextAlign.center,
                          style: LitTextStyles.sansSerif.copyWith(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w800,
                            color: LitColors.mediumGrey.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ),
                    AgeConfirmationCalendarDateIndicators(
                      parentAnimation: _calendarTransition,
                      calendarController: _calendarController,
                      shouldAnimateMonthTransition:
                          _shouldAnimateMonthTransition,
                      shouldAnimateYearTransition: _shouldAnimateYearTransition,
                      toggleShouldAnimateMonthTransitionCallback: (value) {
                        setState(() {
                          _shouldAnimateMonthTransition = value;
                        });
                      },
                      setShouldAnimateYearTransitionCallback: (value) {
                        setState(() {
                          _shouldAnimateYearTransition = value;
                        });
                      },
                    ),
                    AnimatedBuilder(
                        animation: _calendarTransition,
                        builder: (context, child) {
                          return FadeInTransformContainer(
                              animationController: _calendarTransition,
                              transform: Matrix4.translationValues(
                                  -100 + (100 * _calendarTransition.value),
                                  0,
                                  0),
                              child: Column(
                                children: [
                                  AgeConfirmationWeekdayLabels(
                                    calendarController: _calendarController,
                                  ),
                                  AgeConfirmationCalendarGrid(
                                    calendarController: _calendarController,
                                    ageConfirmationController:
                                        _ageConfirmationController,
                                    decreaseByMonthCallback: _decreaseByMonth,
                                    increaseByMonthCallback: _increaseByMonth,
                                    onDayCardTapCallback: onDayCardTap,
                                  ),
                                ],
                              ));
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: AgeConfirmationCalendarNavigator(
                        unitLabel: "${widget.monthLabel}",
                        decreaseUnitCallback: _decreaseByMonth,
                        increaseUnitCallback: _increaseByMonth,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: AgeConfirmationCalendarNavigator(
                        unitLabel: "${widget.yearLabel}",
                        decreaseUnitCallback: _decreaseByYear,
                        increaseUnitCallback: _increaseByYear,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
