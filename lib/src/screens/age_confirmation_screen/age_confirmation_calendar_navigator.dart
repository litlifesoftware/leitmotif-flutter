import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A [Widget] to enable the user to change the currently displayed month in the
/// calendar view by increasing or decreasing the a time unit (eg. by month or year).
class AgeConfirmationCalendarNavigator extends StatelessWidget {
  final String unitLabel;
  final void Function() decreaseUnitCallback;
  final void Function() increaseUnitCallback;

  /// Creates a [AgeConfirmationCalendarNavigator].
  const AgeConfirmationCalendarNavigator({
    Key key,
    @required this.unitLabel,
    @required this.decreaseUnitCallback,
    @required this.increaseUnitCallback,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: LitPushedThroughButton(
            child: Icon(LitIcons.chevron_left_solid,
                size: 22.0, color: LitColors.mediumGrey),
            backgroundColor: Colors.white,
            accentColor: Colors.black,
            onPressed: decreaseUnitCallback,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              unitLabel,
              textAlign: TextAlign.center,
              style: LitTextStyles.sansSerif.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: LitColors.mediumGrey,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: LitPushedThroughButton(
            child: Icon(LitIcons.chevron_right_solid,
                size: 22.0, color: LitColors.mediumGrey),
            backgroundColor: Colors.white,
            accentColor: Colors.black,
            onPressed: increaseUnitCallback,
          ),
        )
      ],
    );
  }
}
