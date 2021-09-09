import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class LitCalendarNavigation extends StatelessWidget {
  final void Function() decreaseByMonth;
  final void Function() increaseByMonth;
  final void Function() onMonthLabelPress;
  final void Function() onYearLabelPress;
  final String yearLabel;
  final String monthLabel;
  const LitCalendarNavigation({
    Key? key,
    required this.decreaseByMonth,
    required this.increaseByMonth,
    required this.onMonthLabelPress,
    required this.onYearLabelPress,
    required this.yearLabel,
    required this.monthLabel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 46,
              height: 42,
              //decreaseByMonth
              child: _MonthNavigatorButton(
                icon: LitIcons.chevron_left_solid,
                onChange: decreaseByMonth,
              ),
            ),
            _TimeUnitSelection(
              constraints: BoxConstraints(
                minWidth: constraints.minWidth,
                maxHeight: constraints.minWidth - (46 * 2),
                maxWidth: constraints.maxWidth - (46 * 2),
                minHeight: constraints.minHeight,
              ),
              monthLabel: monthLabel,
              yearLabel: yearLabel,
              onMonthPress: onMonthLabelPress,
              onYearPress: onYearLabelPress,
            ),
            SizedBox(
              width: 46,
              height: 42,

              //decreaseByMonth
              child: _MonthNavigatorButton(
                icon: LitIcons.chevron_right_solid,
                onChange: increaseByMonth,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _TimeUnitSelection extends StatelessWidget {
  final BoxConstraints constraints;
  final String monthLabel;
  final String yearLabel;
  final void Function() onMonthPress;
  final void Function() onYearPress;
  const _TimeUnitSelection({
    Key? key,
    required this.constraints,
    required this.monthLabel,
    required this.yearLabel,
    required this.onMonthPress,
    required this.onYearPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: LitColors.lightGrey.withOpacity(0.1),
            child: SizedBox(
              width: constraints.maxWidth * 0.5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: LitPlainLabelButton(
                  fontSize: 16.0,
                  onPressed: onMonthPress,
                  label: monthLabel,
                ),
              ),
            ),
          ),
          Container(
            color: LitColors.lightGrey.withOpacity(0.2),
            child: SizedBox(
              width: constraints.maxWidth * 0.5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: LitPlainLabelButton(
                  fontSize: 16.0,
                  onPressed: onYearPress,
                  label: yearLabel,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthNavigatorButton extends StatelessWidget {
  final IconData icon;
  final void Function() onChange;
  const _MonthNavigatorButton({
    Key? key,
    required this.icon,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitPushedThroughButton(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 2.0,
      ),
      onPressed: onChange,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Icon(
          icon,
          size: 14.0,
          color: LitColors.mediumGrey,
        ),
      ),
      // accentColor: Color(0xFF919191),
      // backgroundColor: Color(0xFFeeeeee),
    );
  }
}
