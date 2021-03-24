import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

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

  Color get buttonTextColor {
    return darkMode ? Colors.white : LitColors.lightGrey;
  }

  Color get buttonBorderColor {
    return darkMode ? Colors.white : LitColors.lightGrey;
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
          onPressed: () => {
                settingsPanelController.showSettingsPanel(),
              }),
      body: ScrollableColumn(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ActionButtons(
          //   darkMode: darkMode,
          //   dayOfBirth: dayOfBirth,
          //   onSubmitCallback: onSubmitDayOfBirth,
          //   onShowSnackbarCallback: showSnackbar,
          //   buttonBorderColor: darkMode ? Colors.white : LitColors.lightGrey,
          //   buttonTextColor: darkMode ? Colors.white : LitColors.mediumGrey,
          // ),
          Column(
            children: [
              dayOfBirth != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: ClippedText(
                        "You were born in ${dayOfBirth.year}",
                        style: LitTextStyles.sansSerif.copyWith(
                          color: buttonTextColor,
                        ),
                      ),
                    )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: LitRoundedOutlinedButton(
                    borderColor: buttonBorderColor,
                    child: ClippedText(
                      "Show Licenses",
                      style: LitTextStyles.sansSerif.copyWith(
                        color: buttonTextColor,
                      ),
                    ),
                    onPressed: () => {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
                            return ApplicationLicensesScreen();
                          }))
                        }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: LitRoundedOutlinedButton(
                    borderColor: buttonBorderColor,
                    child: ClippedText(
                      "Show Custom SnackBar!",
                      style: LitTextStyles.sansSerif.copyWith(
                        color: buttonTextColor,
                      ),
                    ),
                    onPressed: showSnackbar),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: LitRoundedOutlinedButton(
                  borderColor: buttonBorderColor,
                  child: ClippedText(
                    "Show Age Confirmation Screen",
                    style: LitTextStyles.sansSerif.copyWith(
                      color: buttonTextColor,
                    ),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return AgeConfirmationScreen(
                            onSubmitCallback: onSubmitDayOfBirth,
                          );
                        },
                      ),
                    )
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: LitRoundedOutlinedButton(
                  borderColor: buttonBorderColor,
                  child: ClippedText(
                    "Show Introduction Screen",
                    style: LitTextStyles.sansSerif.copyWith(
                      color: buttonTextColor,
                    ),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return LitOnboardingScreen(
                            onStartCallback: () => Navigator.of(context).pop(),
                            instructionCards: [
                              InstructionCard(
                                description:
                                    "This text could describe how to use your app. List all key features.",
                                title: "This is a title",
                              ),
                              InstructionCard(
                                description: "This is an introduction card...",
                                title: "This is a title",
                              ),
                              InstructionCard(
                                description: "This is an introduction card...",
                                title: "This is a title",
                              ),
                            ],
                            onStartButtonText: "start",
                          );
                        },
                      ),
                    )
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: LitRoundedOutlinedButton(
                  borderColor: buttonBorderColor,
                  child: ClippedText(
                    "Show AboutApp dialog",
                    style: LitTextStyles.sansSerif.copyWith(
                      color: buttonTextColor,
                    ),
                  ),
                  onPressed: () => {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AboutAppDialog(
                            title: "About",
                            appName: "LitUIKit Example",
                            launcherImageUrl:
                                "assets/images/launcher_placeholder.png",
                            infoDescription:
                                "LitUIKit enables you to create unique user interfaces in less time. Built with the framework. Whose Widgets include custom implementation of Snackbars, AppBars and Utility Screens (e.g. to verify the user's age and to show the application's licenses).",
                          );
                        })
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: LitRoundedOutlinedButton(
                  borderColor: buttonBorderColor,
                  child: ClippedText(
                    "Show Privacy Policy Screen",
                    style: LitTextStyles.sansSerif.copyWith(
                      color: buttonTextColor,
                    ),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return LitPrivacyPolicyScreen(
                              privacyTags: [
                                PrivacyTag(isConform: true, text: "Private"),
                                PrivacyTag(
                                  text: "Offline",
                                  isConform: true,
                                ),
                              ],
                              launcherIconImageUrl:
                                  "assets/images/launcher_placeholder.png",
                              privacyText:
                                  "LitUIKit enables you to create unique user interfaces in less time. Built with the framework. Whose Widgets include custom implementation of Snackbars, AppBars and Utility Screens (e.g. to verify the user's age and to show the application's licenses)LitUIKit enables you to create unique user interfaces in less time. Built with the framework. Whose Widgets include custom implementation of Snackbars, AppBars and Utility Screens (e.g. to verify the user's age and to show the application's licenses)LitUIKit enables you to create unique user interfaces in less time. Built with the framework. Whose Widgets include custom implementation of Snackbars, AppBars and Utility Screens (e.g. to verify the user's age and to show the application's licenses)LitUIKit enables you to create unique user interfaces in less time. Built with the framework. Whose Widgets include custom implementation of Snackbars, AppBars and Utility Screens (e.g. to verify the user's age and to show the application's licenses)",
                              onAgreeCallback: () {
                                Navigator.pop(context);
                              });
                        },
                      ),
                    )
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: LitRoundedOutlinedButton(
                  borderColor: buttonBorderColor,
                  child: ClippedText(
                    "Show Offline App Disclaimer Screen",
                    style: LitTextStyles.sansSerif.copyWith(
                      color: buttonTextColor,
                    ),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return LitOfflineAppDisclaimerScreen(
                            onConfirm: () => {
                              Navigator.pop(context),
                            },
                          );
                        },
                      ),
                    )
                  },
                ),
              ),
            ],
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
