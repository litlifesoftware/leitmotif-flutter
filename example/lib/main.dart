import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

void main() {
  runApp(LeitmotifExample());
}

class LeitmotifExample extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _LeitmotifExampleState createState() => _LeitmotifExampleState();
}

class _LeitmotifExampleState extends State<LeitmotifExample> {
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
      title: 'Leitmotif',
      home: ExampleHomeScreen(),
    );
  }
}

const String exampleText = "Lorem ipsum dolor sit amet, consetetur sadipscing" +
    " elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore" +
    " magna aliquyam erat, sed diam voluptua. At vero eos et accusam et " +
    "justo duo dolores et ea rebum. Stet clita kasd gubergren";

const String LEITMOTIF_DESCR =
    "Leitmotif enables you to create unique user interfaces in less time. " +
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ScrollableColumn(
          padding: const EdgeInsets.symmetric(
            vertical: 32.0,
            horizontal: 16.0,
          ),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Sans Serif",
                style: LitSansSerifStyles.h4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H1",
                style: LitSansSerifStyles.h1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H2",
                style: LitSansSerifStyles.h2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H3",
                style: LitSansSerifStyles.h3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H4",
                style: LitSansSerifStyles.h4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H5",
                style: LitSansSerifStyles.h5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H6",
                style: LitSansSerifStyles.h6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Subtitle 2",
                style: LitSansSerifStyles.subtitle2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Subtitle 1",
                style: LitSansSerifStyles.subtitle1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Body 1",
                style: LitSansSerifStyles.body1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Body 2",
                style: LitSansSerifStyles.body2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "BUTTON",
                style: LitSansSerifStyles.button,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Caption",
                style: LitSansSerifStyles.caption,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "OVERLINE",
                style: LitSansSerifStyles.overline,
              ),
            ),
          ],
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
  late ScrollController _scrollController;
  late bool darkMode;
  DateTime? dayOfBirth;
  Color colorPickerBtnColor = Colors.white;
  double _userIconChar = 65;
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

  void _onChangeSlider(double value) {
    setState(() {
      _userIconChar = value;
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
    _scrollController = ScrollController();
    darkMode = false;
    dayOfBirth = null;
  }

  @override
  Widget build(BuildContext context) {
    return LitNotificationContainer(
      controller: _notificationController,
      child: LitScaffold(
        backgroundColor: darkMode ? LitColors.darkBlue : Colors.white,
        appBar: FixedOnScrollTitledAppbar(
          shouldNavigateBack: false,
          title: "Leitmotif",
          backgroundColor: darkMode ? Colors.black : Colors.white,
          scrollController: _scrollController,
          textStyle: LitTextStyles.sansSerif.copyWith(
            color: darkMode ? Colors.white : LitColors.mediumGrey,
          ),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                LitIcons.gear,
                color: Colors.white,
                size: 16.0,
              ),
            ),
            backgroundColor: LitColors.mediumGrey,
            onPressed: () => {
                  _settingsPanelController.showSettingsPanel(),
                }),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: LitScrollbar(
            child: ScrollableColumn(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              controller: _scrollController,
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
                        username: String.fromCharCode(_userIconChar.toInt()),
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
                    _LitSliderImpl(
                      userIconChar: _userIconChar,
                      onChangeSlider: _onChangeSlider,
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

class _LitSliderImpl extends StatelessWidget {
  final double userIconChar;
  final void Function(double) onChangeSlider;
  const _LitSliderImpl({
    Key? key,
    required this.userIconChar,
    required this.onChangeSlider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      child: LitSlider(
        min: 65,
        max: 90,
        onChanged: onChangeSlider,
        value: userIconChar,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
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
                  LitConfirmAgeScreen(
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
                "Show About Dialog",
                upperCase: true,
                style: LitSansSerifStyles.button.copyWith(
                  color: buttonTextColor,
                ),
              ),
              onPressed: () => {
                showDialog(
                  context: context,
                  builder: (context) {
                    return LitAboutDialog(
                      title: "About",
                      appName: "Leitmotif Example",
                      art: _Art(large: false),
                      infoDescription: LEITMOTIF_DESCR,
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
                "Show LitPrivacyDisclaimerScreen",
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
                      return LitPrivacyDisclaimerScreen(
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
                "Show Static Loading Screen",
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
                      return LitStaticLoadingScreen();
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
          LitTextPageView(
            textItems: [
              TextPageContent(
                subtitle: "Subtitle",
                title: "Title",
                text: "LitTextPageView",
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              height: 54.0,
              width: 54.0,
              child: JugglingLoadingIndicator(),
            ),
          ),
          LitDescriptionTextBox(
            text: "This text is descriping something."
                " "
                "This text is descriping something."
                " "
                "This text is descriping something.",
          ),
          // SizedBox(height: 128.0),
        ],
      ),
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
        TextPageContent(
          subtitle: "Subtitle",
          title: "Title",
          text: exampleText,
        ),
        TextPageContent(
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
      privacyText: LEITMOTIF_DESCR +
          LEITMOTIF_DESCR +
          LEITMOTIF_DESCR +
          LEITMOTIF_DESCR +
          LEITMOTIF_DESCR +
          LEITMOTIF_DESCR,
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
      appTitle: "Leitmotif",
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
        style: LitSansSerifStyles.body2,
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
