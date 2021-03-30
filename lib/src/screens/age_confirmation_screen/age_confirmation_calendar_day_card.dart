import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:lit_ui_kit/src/util/calendar_controller.dart';

/// A [Widget] to display a day of in the [CalendarGrid].
class AgeConfirmationCalendarDayCard extends StatelessWidget {
  final DateTime? selectedDate;
  final DateTime? templateDate;
  final DateTime iteratedDate;
  final double padding;
  final bool Function(DateTime, DateTime) sameMonth;
  final bool Function(DateTime) isValid;
  final void Function(DateTime) onPressed;
  final CalendarController calendarController;

  /// Creates a [AgeConfirmationCalendarDayCard].
  const AgeConfirmationCalendarDayCard({
    Key? key,
    required this.selectedDate,
    required this.templateDate,
    required this.iteratedDate,
    required this.padding,
    required this.sameMonth,
    required this.isValid,
    required this.onPressed,
    required this.calendarController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(iteratedDate),
      child: SizedBox(
        width: (MediaQuery.of(context).size.width - padding) /
            calendarController.weekdays.length,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Opacity(
                opacity: isValid(iteratedDate) ? 1.0 : 0.4,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      color: selectedDate == iteratedDate
                          ? isValid(selectedDate!)
                              ? LitColors.mediumGrey.withOpacity(0.4)
                              : LitColors.lightRed
                          : Colors.white,
                      boxShadow: [
                        sameMonth(iteratedDate, templateDate!)
                            ? BoxShadow(
                                color: Colors.black38,
                                blurRadius: 24,
                                offset: Offset(-2, -2),
                                spreadRadius: 1,
                              )
                            : BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12,
                                offset: Offset(2, 2),
                                spreadRadius: 1,
                              ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        selectedDate == iteratedDate
                            ? isValid(selectedDate!)
                                ? "${iteratedDate.day}"
                                : "!"
                            : "${iteratedDate.day}",
                        textAlign: TextAlign.center,
                        style: LitTextStyles.sansSerif.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color:

                              /// If its the month displayed on the view
                              sameMonth(iteratedDate, templateDate!)

                                  /// If the selectedDate is equal to the iteratedDate
                                  ? selectedDate == iteratedDate

                                      /// And the age is valid
                                      ? isValid(selectedDate!)
                                          ? Colors.white
                                          : LitColors.darkRed
                                      : LitColors.mediumGrey
                                  : LitColors.mediumGrey.withOpacity(0.35),
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
