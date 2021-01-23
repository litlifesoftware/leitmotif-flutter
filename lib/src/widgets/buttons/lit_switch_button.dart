import 'package:flutter/material.dart';

/// A [StatelessWidget] which will create a toggleable button.
class LitSwitchButton extends StatelessWidget {
  final bool enabled;
  final void Function(bool) onValueToggle;
  final Color enabledBorderColor;
  final Color disabledBorderColor;
  final String enabledText;
  final String disabledText;
  final TextStyle textStyle;

  /// Creates a [LitSwitchButton].
  ///
  /// The button will toggle the provided [enabled] value by excuting
  /// the [onValueToggle] once it has been pressed. Its
  /// [Color] styles are displayed depended on the current [enabled]
  /// state. The provided [TextStyle] will format the label displaying
  /// the current state as a word using the [enabledText] and [disabledText]
  /// values.
  const LitSwitchButton({
    Key key,
    @required this.enabled,
    @required this.onValueToggle,
    @required this.enabledBorderColor,
    @required this.disabledBorderColor,
    @required this.enabledText,
    @required this.disabledText,
    @required this.textStyle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onValueToggle(!enabled),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
              width: 2.0,
              color: enabled ? enabledBorderColor : disabledBorderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 2.0,
            horizontal: 4.0,
          ),
          child: Text(
            enabled ? enabledText : disabledText,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
