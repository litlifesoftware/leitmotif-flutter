import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class LitSettingsPanelTile extends StatelessWidget {
  final void Function(bool) onValueToggled;
  final bool enabled;
  final bool darkMode;
  final String optionName;
  final IconData iconData;
  final String disabledLabel;
  final String enabledLabel;

  /// Creates a new [LitSettingsPanelTile].
  ///
  /// It will be used to display the various settings which
  /// can be toggled on the [LitSettingsPanel].
  const LitSettingsPanelTile({
    Key? key,
    required this.onValueToggled,
    required this.darkMode,
    required this.enabled,
    required this.optionName,
    required this.iconData,
    this.disabledLabel = "off",
    this.enabledLabel = "on",
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        return Row(
          children: [
            SizedBox(
              width: (boxConstraints.maxWidth) * 0.25,
              child: Icon(
                iconData,
                color: darkMode ? Colors.white : LitColors.mediumGrey,
                size: 18.0,
              ),
            ),
            SizedBox(
              width: (boxConstraints.maxWidth) * 0.5,
              child: ClippedText(
                optionName,
                style: LitTextStyles.sansSerif.copyWith(
                  color: darkMode ? Colors.white : LitColors.mediumGrey,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
                width: (boxConstraints.maxWidth) * 0.25,
                child: LitSwitchButton(
                  enabled: enabled,
                  onValueToggle: onValueToggled,
                  enabledBorderColor: LitColors.mintGreen.withOpacity(0.7),
                  disabledBorderColor: LitColors.darkRed.withOpacity(0.5),
                  disabledText: disabledLabel,
                  enabledText: enabledLabel,
                  textStyle: LitTextStyles.sansSerif.copyWith(
                    color: darkMode ? Colors.white : LitColors.mediumGrey,
                    fontSize: 14.0,
                  ),
                ))
          ],
        );
      },
    );
  }
}
