import 'package:example/action_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

void main() {
  runApp(LitUIKitExample());
}

class LitUIKitExample extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _LitUIKitExampleState createState() => _LitUIKitExampleState();
}

class _LitUIKitExampleState extends State<LitUIKitExample> {
  @override
  void initState() {
    super.initState();
    ImageCacheController(
        assetImages: ["assets/images/launcher_placeholder.png"],
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LitUIKit',
      home: LitUIKitHomescreen(),
    );
  }
}

class LitUIKitHomescreen extends StatefulWidget {
  LitUIKitHomescreen({Key key}) : super(key: key);

  @override
  _LitUIKitHomescreenState createState() => _LitUIKitHomescreenState();
}

class _LitUIKitHomescreenState extends State<LitUIKitHomescreen> {
  SettingsPanelController settingsPanelController;
  LitSnackbarController customSnackBarController;
  bool darkMode;
  DateTime dayOfBirth;

  void onSubmitDayOfBirth(DateTime date) {
    Navigator.pop(context);
    setState(() {
      dayOfBirth = date;
    });
  }

  void showSnackbar() {
    customSnackBarController.showSnackBar();
  }

  @override
  void initState() {
    super.initState();
    settingsPanelController = SettingsPanelController();
    customSnackBarController = LitSnackbarController();

    darkMode = false;
    dayOfBirth = null;
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      backgroundColor: darkMode ? LitColors.darkBlue : Colors.white,
      appBar: LitAppBar(
        title: "LitUIKit Example",
        backgroundColor: darkMode ? LitColors.darkBlue : LitColors.lightGrey,
        textStyle: LitTextStyles.sansSerif
            .copyWith(color: darkMode ? Colors.white : LitColors.mediumGrey),
      ),
      snackBar: IconSnackbar(
          litSnackBarController: customSnackBarController,
          text: "Snack Bar!",
          iconData: LitIcons.info),
      settingsPanel: SettingsPanel(
        controller: settingsPanelController,
        title: "Settings",
        darkMode: darkMode,
        settingsTiles: [
          SettingsTile(
            onValueToggled: (toggledValue) {
              setState(() {
                darkMode = toggledValue;
              });
            },
            darkMode: darkMode,
            enabled: darkMode,
            optionName: "Dark mode",
            iconData: LitIcons.moon_with_stars_solid,
          ),
          SettingsTile(
            onValueToggled: (toggledValue) {
              setState(() {
                darkMode = toggledValue;
              });
            },
            darkMode: darkMode,
            enabled: darkMode,
            optionName: "Dark mode",
            iconData: LitIcons.moon_with_stars_solid,
          ),
          SettingsTile(
            onValueToggled: (toggledValue) {
              setState(() {
                darkMode = toggledValue;
              });
            },
            darkMode: darkMode,
            enabled: darkMode,
            optionName: "Dark mode",
            iconData: LitIcons.moon_with_stars_solid,
          ),
          SettingsTile(
            onValueToggled: (toggledValue) {
              setState(() {
                darkMode = toggledValue;
              });
            },
            darkMode: darkMode,
            enabled: darkMode,
            optionName: "Dark mode",
            iconData: LitIcons.moon_with_stars_solid,
          ),
          SettingsTile(
            onValueToggled: (toggledValue) {
              setState(() {
                darkMode = toggledValue;
              });
            },
            darkMode: darkMode,
            enabled: darkMode,
            optionName: "Dark mode",
            iconData: LitIcons.moon_with_stars_solid,
          ),
          SettingsTile(
            onValueToggled: (toggledValue) {
              setState(() {
                darkMode = toggledValue;
              });
            },
            darkMode: darkMode,
            enabled: darkMode,
            optionName: "Dark mode",
            iconData: LitIcons.moon_with_stars_solid,
          ),
          SettingsTile(
            onValueToggled: (toggledValue) {
              setState(() {
                darkMode = toggledValue;
              });
            },
            darkMode: darkMode,
            enabled: darkMode,
            optionName: "Dark mode",
            iconData: LitIcons.moon_with_stars_solid,
          ),
        ],
      ),
      actionButton: AnimatedActionButton(
          alignment: Alignment.bottomRight,
          child: Icon(
            LitIcons.gear,
            color: Colors.grey,
          ),
          backgroundColor: LitColors.mediumGrey,
          onPressed: () => {settingsPanelController.showSettingsPanel()}),
      body: ScrollableColumn(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ActionButtons(
            darkMode: darkMode,
            dayOfBirth: dayOfBirth,
            onSubmitCallback: onSubmitDayOfBirth,
            onShowSnackbarCallback: showSnackbar,
            buttonBorderColor: darkMode ? Colors.white : LitColors.lightGrey,
            buttonTextColor: darkMode ? Colors.white : LitColors.mediumGrey,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
            child: ClippedText(
              "Do you like this UI Kit? Please leave a star. 👻",
              maxLines: 3,
            ),
          )
        ],
      ),
    );
  }
}
