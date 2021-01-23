import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:lit_ui_kit/src/util/calendar_controller.dart';
import 'package:lit_ui_kit/src/util/calendar_localization_service.dart';

import 'age_confirmation_controller.dart';

/// A [Widget] to display all weekdays on the calendar view.
///
/// The labels will be used as a legend on the calendar view.
class AgeConfirmationWeekdayLabels extends StatelessWidget {
  final CalendarController calendarController;

  /// Creates a [WeekdayLabels] [Widget].
  const AgeConfirmationWeekdayLabels({
    Key key,
    @required this.calendarController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Builder(builder: (context) {
        List<Widget> labels = List<Widget>();
        List<String> localizedWeekdays =
            CalendarLocalizationService.getLocalizedCalendarWeekdays(
                Localizations.localeOf(context));
        for (int i = 0; i < localizedWeekdays.length; i++) {
          labels.add(
            SizedBox(
              width: (MediaQuery.of(context).size.width - 60) /
                  localizedWeekdays.length,
              child: Text(
                localizedWeekdays[i].substring(0, 3).toUpperCase(),
                textAlign: TextAlign.center,
                style: LitTextStyles.sansSerif.copyWith(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  color: LitColors.mediumGrey.withOpacity(0.4),
                ),
              ),
            ),
          );
        }
        return Row(
          children: labels,
        );
      }),
    );
  }
}
