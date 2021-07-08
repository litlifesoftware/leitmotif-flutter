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
      home: ExampleHomeScreen(),
    );
  }
}

const String exampleText = "Lorem ipsum dolor sit amet, consetetur sadipscing" +
    " elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore" +
    " magna aliquyam erat, sed diam voluptua. At vero eos et accusam et " +
    "justo duo dolores et ea rebum. Stet clita kasd gubergren";

const String LITUIKIT_DESCR =
    "LitUIKit enables you to create unique user interfaces in less time. " +
        "Built with the framework. Whose Widgets include custom " +
        "implementation of Snackbars, AppBars and Utility Screens " +
        "(e.g. to verify the user's age and to show the application's" +
        " licenses).";

class ExampleHomeScreen extends StatefulWidget {
  ExampleHomeScreen({Key? key}) : super(key: key);

  @override
  _ExampleHomeScreenState createState() => _ExampleHomeScreenState();
}

class _ExampleHomeScreenState extends State<ExampleHomeScreen> {
  bool shouldHideNavigationBar = false;

  void toggleShouldHideNavigationBar() {
    setState(() {
      shouldHideNavigationBar = !shouldHideNavigationBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LitTabView(
      hideNavigationBar: shouldHideNavigationBar,
      tabs: [
        LitNavigableTab(
          tabData: LitBottomNavigationTabData(
            icon: LitIcons.home,
            iconSelected: LitIcons.home_alt,
            index: 0,
          ),
          screen: _ExampleScreen(
            onHideBottomNavigation: toggleShouldHideNavigationBar,
          ),
        ),
        LitNavigableTab(
          tabData: LitBottomNavigationTabData(
            icon: LitIcons.gear,
            iconSelected: LitIcons.gear_solid,
            index: 1,
          ),
          screen: _ExampleScreenTwo(),
        )
      ],
    );
  }
}

class _ExampleScreenTwo extends StatelessWidget {
  const _ExampleScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Screen Two",
          style: LitSansSerifStyles.body,
        ),
      ),
    );
  }
}

class _ExampleScreen extends StatefulWidget {
  final void Function() onHideBottomNavigation;
  const _ExampleScreen({
    Key? key,
    required this.onHideBottomNavigation,
  }) : super(key: key);

  @override
  __ExampleScreenState createState() => __ExampleScreenState();
}

class __ExampleScreenState extends State<_ExampleScreen> {
  late LitSettingsPanelController _settingsPanelController;
  late LitSnackbarController _solidSnackbarController;
  late LitSnackbarController _solidSnackbarControllerDiffAni;
  late LitSnackbarController _transparentSnackbarController;
  late LitNotificationController _notificationController;
  late bool darkMode;
  DateTime? dayOfBirth;
  Color colorPickerBtnColor = Colors.white;
  void showSolidSnackbar() {
    _solidSnackbarController.showSnackBar();
  }

  void showDiffentlyAnimaSnackbar() {
    _solidSnackbarControllerDiffAni.showSnackBar();
  }

  void showTransparentSnackbar() {
    _transparentSnackbarController.showSnackBar();
  }

  Color get buttonTextColor {
    return darkMode ? Colors.white : LitColors.mediumGrey;
  }

  Color get buttonColor {
    return darkMode ? LitColors.mediumGrey : Colors.white;
  }

  void _addNotification() {
    setState(() {
      _notificationController.add(
        LitNotificationData(
          description: "${DateTime.now().toIso8601String()}",
          icon: LitIcons.bolt,
        ),
      );
    });
  }

  void _setColorPickerColor(Color c) {
    setState(() {
      colorPickerBtnColor = c;
    });
  }

  @override
  void initState() {
    super.initState();
    _settingsPanelController = LitSettingsPanelController()
      ..addListener(widget.onHideBottomNavigation);
    _solidSnackbarController = LitSnackbarController();
    _solidSnackbarControllerDiffAni = LitSnackbarController(
      animationType: SnackbarAnimationType.bottomToTop,
    );
    _transparentSnackbarController = LitSnackbarController();
    _notificationController = LitNotificationController();
    darkMode = false;
    dayOfBirth = null;
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      backgroundColor: darkMode ? LitColors.darkBlue : Colors.white,
      appBar: LitAppBar(
        title: "LitUIKit Example",
        backgroundColor: darkMode ? Colors.black : Colors.white,
        textStyle: LitTextStyles.sansSerif.copyWith(
          color: darkMode ? Colors.white : LitColors.mediumGrey,
        ),
        elevated: darkMode,
      ),
      snackbars: [
        LitIconSnackbar(
          snackBarController: _solidSnackbarController,
          text: "Snackbar!",
          iconData: LitIcons.info,
        ),
        LitIconSnackbar(
          snackBarController: _solidSnackbarControllerDiffAni,
          text: "Different Snackbar animation!",
          iconData: LitIcons.info,
        ),
        LitTransparentIconSnackbar(
          snackBarController: _transparentSnackbarController,
          text: "Transparent Snackbar!",
          iconData: LitIcons.info,
        ),
      ],
      settingsPanel: LitSettingsPanel(
        controller: _settingsPanelController,
        title: "Settings",
        darkMode: darkMode,
        settingsTiles: [
          LitSettingsPanelTile(
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
          LitSettingsPanelTile(
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
          LitSettingsPanelTile(
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
          LitSettingsPanelTile(
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
          LitSettingsPanelTile(
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
          LitSettingsPanelTile(
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
          LitSettingsPanelTile(
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
          alignment: Alignment.bottomLeft,
          child: Icon(
            LitIcons.gear,
            color: Colors.white,
            size: 18.0,
          ),
          backgroundColor: LitColors.mediumGrey,
          onPressed: () => {
                _settingsPanelController.showSettingsPanel(),
              }),
      body: LitNotificationContainer(
        controller: _notificationController,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: LitScrollbar(
            child: ScrollableColumn(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    dayOfBirth != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 32.0),
                            child: ClippedText(
                              "You were born in ${dayOfBirth!.year}",
                              style: LitTextStyles.sansSerif.copyWith(
                                color: buttonTextColor,
                              ),
                            ),
                          )
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 32.0,
                      ),
                      child: LitUserIcon(
                        primaryColor: colorPickerBtnColor,
                        onPressed: () => {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return _LitColorPickerDialogImpl(
                                  color: colorPickerBtnColor,
                                  onApply: (c) {
                                    _setColorPickerColor(c);
                                  },
                                );
                              })
                        },
                      ),
                    ),
                    _ButtonList(
                      darkMode: darkMode,
                      addNotification: _addNotification,
                      buttonColor: buttonColor,
                      buttonTextColor: buttonTextColor,
                      showSolidSnackbar: showSolidSnackbar,
                      showDifferentlyAnimaSnackbar: showDiffentlyAnimaSnackbar,
                      showTransparentSnackbar: showTransparentSnackbar,
                      colorPickerBtnColor: colorPickerBtnColor,
                      setColorPickerBtnColor: _setColorPickerColor,
                    ),
                    LitSettingsFooter(
                      children: [
                        LitPlainLabelButton(
                          label: "Option 1",
                          onPressed: showSolidSnackbar,
                        ),
                        LitPlainLabelButton(
                          label: "Option 1",
                          onPressed: showTransparentSnackbar,
                        ),
                        LitPlainLabelButton(
                          label: "Option 1",
                          onPressed: showDiffentlyAnimaSnackbar,
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonList extends StatelessWidget {
  final bool darkMode;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color colorPickerBtnColor;
  final void Function() addNotification;
  final void Function() showSolidSnackbar;
  final void Function() showDifferentlyAnimaSnackbar;
  final void Function() showTransparentSnackbar;
  final void Function(Color c) setColorPickerBtnColor;
  const _ButtonList({
    Key? key,
    required this.darkMode,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.addNotification,
    required this.showSolidSnackbar,
    required this.showDifferentlyAnimaSnackbar,
    required this.showTransparentSnackbar,
    required this.colorPickerBtnColor,
    required this.setColorPickerBtnColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32.0),
        LitRoundedElevatedButton(
          color: buttonColor,
          child: ClippedText(
            "Add notification",
            upperCase: true,
            style: LitSansSerifStyles.button.copyWith(
              color: buttonTextColor,
            ),
          ),
          onPressed: addNotification,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: LitRoundedElevatedButton(
              color: buttonColor,
              child: ClippedText(
                "Show Licenses",
                upperCase: true,
                style: LitSansSerifStyles.button.copyWith(
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
          child: LitRoundedElevatedButton(
              color: buttonColor,
              child: ClippedText(
                "Show Solid SnackBar!",
                upperCase: true,
                style: LitSansSerifStyles.button.copyWith(
                  color: buttonTextColor,
                ),
              ),
              onPressed: showSolidSnackbar),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: LitRoundedElevatedButton(
            color: buttonColor,
            child: ClippedText(
              "Show Differently anima. SnackBar!",
              upperCase: true,
              style: LitSansSerifStyles.button.copyWith(
                color: buttonTextColor,
              ),
            ),
            onPressed: showDifferentlyAnimaSnackbar,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: LitRoundedElevatedButton(
              color: buttonColor,
              child: ClippedText(
                "Show Transparent SnackBar!",
                upperCase: true,
                style: LitSansSerifStyles.button.copyWith(
                  color: buttonTextColor,
                ),
              ),
              onPressed: showTransparentSnackbar),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: LitRoundedElevatedButton(
            color: buttonColor,
            child: ClippedText(
              "Show Confirm Age Screen",
              upperCase: true,
              style: LitSansSerifStyles.button.copyWith(
                color: buttonTextColor,
              ),
            ),
            onPressed: () => {
              LitRouteController(context).pushCupertinoWidget(
                ConfirmAgeScreen(
                  onSubmit: (date) {
                    print("ConfirmAgeScreen-submitted date: $date");
                    LitRouteController(context).pop();
                  },
                ),
              ),
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: LitRoundedElevatedButton(
            color: buttonColor,
            child: ClippedText(
              "Show Onboarding Screen",
              upperCase: true,
              style: LitSansSerifStyles.button.copyWith(
                color: buttonTextColor,
              ),
            ),
            onPressed: () => {
              LitRouteController(context)
                  .pushCupertinoWidget(_LitOnboardingScreenImplementation())
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: LitRoundedElevatedButton(
            color: buttonColor,
            child: ClippedText(
              "Show AboutApp dialog",
              upperCase: true,
              style: LitSansSerifStyles.button.copyWith(
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
                    art: _Art(large: false),
                    infoDescription: LITUIKIT_DESCR,
                  );
                },
              )
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: LitRoundedElevatedButton(
            color: buttonColor,
            child: ClippedText(
              "Show LitTitledDialog",
              upperCase: true,
              style: LitSansSerifStyles.button.copyWith(
                color: buttonTextColor,
              ),
            ),
            onPressed: () => {
              showDialog(
                  context: context,
                  builder: (context) {
                    return _LitTitledDialogImpl();
                  })
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: LitRoundedElevatedButton(
            color: colorPickerBtnColor,
            child: ClippedText(
              "Show LitColorPickerDialog",
              upperCase: true,
              style: LitSansSerifStyles.button.copyWith(
                color: buttonTextColor,
              ),
            ),
            onPressed: () => {
              showDialog(
                  context: context,
                  builder: (context) {
                    return _LitColorPickerDialogImpl(
                      color: colorPickerBtnColor,
                      onApply: setColorPickerBtnColor,
                    );
                  })
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: LitRoundedElevatedButton(
            color: buttonColor,
            child: ClippedText(
              "Show Discard Draft Dialog",
              upperCase: true,
              style: LitSansSerifStyles.button.copyWith(
                color: buttonTextColor,
              ),
            ),
            onPressed: () => {
              showDialog(
                  context: context,
                  builder: (context) {
                    return DiscardDraftDialog(
                      onDiscard: () {
                        LitRouteController(context).closeDialog();
                      },
                    );
                  })
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: LitRoundedElevatedButton(
            color: buttonColor,
            child: ClippedText(
              "Show Privacy Policy Screen",
              upperCase: true,
              style: LitSansSerifStyles.button.copyWith(
                color: buttonTextColor,
              ),
            ),
            onPressed: () => {
              LitRouteController(context)
                  .pushCupertinoWidget(_LitPrivacyScreenImplementation())
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: LitRoundedElevatedButton(
            color: buttonColor,
            child: ClippedText(
              "Show Offline App Disclaimer Screen",
              upperCase: true,
              style: LitSansSerifStyles.button.copyWith(
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
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: LitRoundedElevatedButton(
            color: buttonColor,
            child: ClippedText(
              "Show Startup Screen",
              upperCase: true,
              style: LitSansSerifStyles.button.copyWith(
                color: buttonTextColor,
              ),
            ),
            onPressed: () => {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) {
                    return LitStartupScreen();
                  },
                ),
              )
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: LitRoundedElevatedButton(
            color: buttonColor,
            child: ClippedText(
              "Show Signup Screen",
              upperCase: true,
              style: LitSansSerifStyles.button.copyWith(
                color: buttonTextColor,
              ),
            ),
            onPressed: () => {
              LitRouteController(context)
                  .pushCupertinoWidget(_LitSignupScreenImplementation())
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: LitRoundedElevatedButton(
            color: buttonColor,
            child: ClippedText(
              "Show Credits Screen",
              upperCase: true,
              style: LitSansSerifStyles.button.copyWith(
                color: buttonTextColor,
              ),
            ),
            onPressed: () => {
              LitRouteController(context).pushCupertinoWidget(
                _LitCreditsScreenImplementation(
                  darkMode: darkMode,
                ),
              )
            },
          ),
        ),
        SizedBox(height: 128.0),
      ],
    );
  }
}

class _LitOnboardingScreenImplementation extends StatelessWidget {
  const _LitOnboardingScreenImplementation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitOnboardingScreen(
      art: _Art(large: false),
      title: "Onboading",
      textItems: const [
        OnboardingText(
          subtitle: "Subtitle",
          title: "Title",
          text: exampleText,
        ),
        OnboardingText(
          subtitle: "Subtitle",
          title: "Title",
          text: "Second Text Item",
        ),
      ],
      onExit: () => LitRouteController(context).navigateBack(),
    );
  }
}

class _LitPrivacyScreenImplementation extends StatelessWidget {
  const _LitPrivacyScreenImplementation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitPrivacyPolicyScreen(
      privacyTags: [
        PrivacyTag(isConform: true, text: "Private"),
        PrivacyTag(
          text: "Offline",
          isConform: true,
        ),
      ],
      art: _Art(large: false),
      privacyText: LITUIKIT_DESCR,
      onAgreeCallback: () {
        Navigator.pop(context);
      },
    );
  }
}

class _LitSignupScreenImplementation extends StatelessWidget {
  const _LitSignupScreenImplementation({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return LitSignUpScreen(
      onSubmit: () {
        LitRouteController(context).pop();
      },
      inputFields: [
        LitTextField(
          label: "Username",
          icon: LitIcons.person_solid,
          onChange: (value) {
            print("Hello, $value");
          },
        ),
        LitTextField(
          label: "Username",
          icon: LitIcons.person_solid,
          onChange: (value) {
            print("Hello, $value");
          },
        ),
      ],
    );
  }
}

class _LitCreditsScreenImplementation extends StatelessWidget {
  final bool darkMode;
  const _LitCreditsScreenImplementation({
    Key? key,
    required this.darkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitCreditsScreen(
      darkMode: darkMode,
      appTitle: "LitUIKit",
      art: _Art(large: false),
      credits: [
        CreditData(
          role: "Made by",
          names: [
            "LitLifeSoftware",
          ],
        ),
        CreditData(
          role: "Design",
          names: [
            "Michael Grigorenko",
          ],
        ),
        CreditData(
          role: "Development",
          names: [
            "Michael Grigorenko",
          ],
        ),
        CreditData(
          role: "Flutter Framework",
          names: [
            "Google LLC.",
            "Flutter Contributors",
            "Skia Contributors",
            "Dart Contributors",
          ],
        ),
      ],
    );
  }
}

class _Art extends StatelessWidget {
  final bool large;
  const _Art({
    Key? key,
    required this.large,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: large ? 200.0 : 100.0,
          height: large ? 200.0 : 100.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                const Radius.circular(25.0),
              ),
              color: const Color(0xFFC4C4C4),
            ),
            child: Center(
              child: Text(
                "Provide art",
                textAlign: TextAlign.center,
                style: LitTextStyles.sansSerifBodyTighterSmaller,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LitTitledDialogImpl extends StatelessWidget {
  const _LitTitledDialogImpl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitTitledDialog(
      child: Center(
          child: Text(
        "Example title with a description",
        style: LitSansSerifStyles.body,
      )),
      titleText: "A dialog",
      actionButtons: [
        DialogActionButton(
          onPressed: () {},
          label: "Action Button Label 1",
        ),
        DialogActionButton(
          onPressed: () {},
          label: "Action Button Label 2",
        )
      ],
    );
  }
}

class _LitColorPickerDialogImpl extends StatelessWidget {
  final Color color;
  final void Function(Color c) onApply;

  const _LitColorPickerDialogImpl({
    Key? key,
    required this.color,
    required this.onApply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitColorPickerDialog(
      initialColor: color,
      onApplyColor: onApply,
    );
  }
}
