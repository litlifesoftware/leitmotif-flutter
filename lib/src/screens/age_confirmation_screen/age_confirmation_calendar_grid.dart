import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:lit_ui_kit/src/util/calendar_controller.dart';

import 'age_confirmation_controller.dart';
import 'age_confirmation_calendar_day_card.dart';

/// The calendar view used on the [AgeConfirmationScreen].
class AgeConfirmationCalendarGrid extends StatelessWidget {
  final void Function() decreaseByMonthCallback;
  final void Function() increaseByMonthCallback;

  final void Function(DateTime) onDayCardTapCallback;
  final AgeConfirmationController? ageConfirmationController;
  final CalendarController calendarController;
  const AgeConfirmationCalendarGrid({
    Key? key,
    required this.decreaseByMonthCallback,
    required this.increaseByMonthCallback,
    required this.onDayCardTapCallback,
    required this.ageConfirmationController,
    required this.calendarController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          decreaseByMonthCallback();
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          increaseByMonthCallback();
        }
      },
      child: Builder(builder: (context) {
        final List<Row> weekList = <Row>[];
        int count = 0;
        for (int i = 0;
            i <
                calendarController.derivateDates.length /
                    calendarController.weekdays.length;
            i++) {
          final List<Widget> dayList = <Widget>[];

          for (int i = 0; i < calendarController.weekdays.length; i++) {
            //print(count);
            final DateTime iteratedDate =
                calendarController.derivateDates[count];
            dayList.add(
              AgeConfirmationCalendarDayCard(
                selectedDate: ageConfirmationController!.selectedDate,
                templateDate: calendarController.templateDate,
                iteratedDate: iteratedDate,
                padding: 60.0,
                sameMonth: ageConfirmationController!.sameMonth,
                isValid: ageConfirmationController!.dayOfBirthIsValid,
                onPressed: onDayCardTapCallback,
                calendarController: calendarController,
              ),
            );
            if (count < (calendarController.derivateDates.length - 1)) {
              count++;
            }
            // print(count);
            // print(derivateDateList.length - 1);
          }
          weekList.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: dayList,
          ));
        }
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 30.0,
          ),
          child: Column(
            children: weekList,
          ),
        );
      }),
    );
  }
}
