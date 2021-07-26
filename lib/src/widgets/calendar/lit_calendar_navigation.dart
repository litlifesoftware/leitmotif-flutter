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
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: constraints.maxWidth / 4,
              //decreaseByMonth
              child: _MonthNavigatorButton(
                icon: LitIcons.chevron_left_solid,
                onChange: decreaseByMonth,
              ),
            ),
            SizedBox(
              width: constraints.maxWidth / 4,
              child: LitPlainLabelButton(
                fontSize: 16.0,
                onPressed: onMonthLabelPress,
                label: monthLabel,
              ),
            ),
            SizedBox(
              width: constraints.maxWidth / 4,
              child: LitPlainLabelButton(
                fontSize: 16.0,
                onPressed: onYearLabelPress,
                label: yearLabel,
              ),
            ),
            SizedBox(
              width: constraints.maxWidth / 4,
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
        vertical: 8.0,
        horizontal: 12.0,
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
      accentColor: Color(0xFF919191),
      backgroundColor: Color(0xFFeeeeee),
    );
  }
}
