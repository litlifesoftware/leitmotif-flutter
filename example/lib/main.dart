import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      theme: ThemeData(textTheme: LitSansSerifStyles.theme),
      localizationsDelegates: const [
        LeitmotifLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('de', ''),
      ],
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
  bool dark = false;

  void toggleShouldHideNavigationBar() {
    setState(() {
      shouldHideNavigationBar = !shouldHideNavigationBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("dark parent " + dark.toString());
    return LitTabView(
      dark: dark,
      tabs: [
        LitNavigableTab(
          tabData: LitBottomNavigationItemData(
            icon: LitIcons.home_alt,
            iconAlt: LitIcons.home,
            index: 0,
            title: "home",
          ),
          screen: _ExampleScreen(
            onHideBottomNavigation: toggleShouldHideNavigationBar,
            dark: dark,
            onToggleDark: (value) {
              setState(() {
                dark = !dark;
              });
            },
          ),
        ),
        LitNavigableTab(
          tabData: LitBottomNavigationItemData(
            icon: Icons.font_download,
            iconAlt: Icons.font_download_off_outlined,
            index: 1,
            title: "Sans",
          ),
          screen: _ExampleScreenTwo(),
        ),
        LitNavigableTab(
          tabData: LitBottomNavigationItemData(
            icon: Icons.font_download,
            iconAlt: Icons.font_download_off_outlined,
            index: 2,
            title: "Serif",
          ),
          screen: _ExampleScreenThree(),
        ),
      ],
    );
  }
}

class _ExampleScreenThree extends StatelessWidget {
  const _ExampleScreenThree({Key? key}) : super(key: key);

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
                "Serif",
                style: LitSerifStyles.h4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H1",
                style: LitSerifStyles.h1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H2",
                style: LitSerifStyles.h2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H3",
                style: LitSerifStyles.h3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H4",
                style: LitSerifStyles.h4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H5",
                style: LitSerifStyles.h5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H6",
                style: LitSerifStyles.h6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Subtitle 2",
                style: LitSerifStyles.subtitle2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Subtitle 1",
                style: LitSerifStyles.subtitle1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Body 1",
                style: LitSerifStyles.body1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Body 2",
                style: LitSerifStyles.body2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "BUTTON",
                style: LitSerifStyles.button,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Caption",
                style: LitSerifStyles.caption,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "OVERLINE",
                style: LitSerifStyles.overline,
              ),
            ),
          ],
        ),
      ),
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
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H1",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H2",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H3",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H4",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H5",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "H6",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Subtitle 2",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Subtitle 1",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Body 1",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Body 2",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "BUTTON",
                style: Theme.of(context).textTheme.button,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Caption",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "OVERLINE",
                style: Theme.of(context).textTheme.overline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExampleScreen extends StatefulWidget {
  final bool dark;
  final void Function(bool) onToggleDark;
  final void Function() onHideBottomNavigation;
  const _ExampleScreen({
    Key? key,
    required this.dark,
    required this.onToggleDark,
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
  DateTime? dayOfBirth;
  Color colorPickerBtnColor = Colors.white;
  double _userIconChar = 65;
  bool _showSlider = true;
  late bool _dark;
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
    return _dark ? Colors.white : LitColors.mediumGrey;
  }

  Color get buttonColor {
    return _dark ? LitColors.mediumGrey : Colors.white;
  }

  void setShowSlider(bool value) {
    setState(() {
      _showSlider = value;
    });
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
    dayOfBirth = null;
    _dark = widget.dark;
  }

  @override
  Widget build(BuildContext context) {
    return LitNotificationContainer(
      controller: _notificationController,
      child: LitScaffold(
        backgroundColor: _dark ? LitColors.darkBlue : Colors.white,
        appBar: FixedOnScrollTitledAppbar(
          shouldNavigateBack: false,
          title: "Leitmotif",
          backgroundColor: _dark ? Colors.black : Colors.white,
          scrollController: _scrollController,
          textStyle: LitTextStyles.sansSerif.copyWith(
            color: _dark ? Colors.white : LitColors.mediumGrey,
          ),
        ),
        snackbars: [
          LitIconSnackbar(
            snackBarController: _solidSnackbarController,
            title: "Title",
            text: "This is an informational text to inform the user!",
            iconData: LitIcons.info,
          ),
          LitIconSnackbar(
            snackBarController: _solidSnackbarControllerDiffAni,
            title: "Title",
            text: "Different Snackbar animation!",
            iconData: LitIcons.info,
          ),
          LitTransparentIconSnackbar(
            snackBarController: _transparentSnackbarController,
            title: "Title",
            text: "Transparent Snackbar!",
            iconData: LitIcons.info,
          ),
        ],
        settingsPanel: LitSettingsPanel(
          padding: const EdgeInsets.only(
            bottom: LitBottomNavigation.defaultHeight,
          ),
          controller: _settingsPanelController,
          title: "Settings",
          darkMode: _dark,
          settingsTiles: [
            LitSettingsPanelTile(
              onValueToggled: (value) {
                setState(() {
                  _dark = !_dark;
                });
                widget.onToggleDark(!_dark);
              },
              darkMode: _dark,
              enabled: _dark,
              optionName: "Dark Theme",
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
                        name: String.fromCharCode(_userIconChar.toInt()),
                        color: colorPickerBtnColor,
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
                            },
                          )
                        },
                      ),
                    ),
                    LitSettingCard(
                      value: _showSlider,
                      title: "Show Slider",
                      description:
                          "Show a slider to modify the icon above Show a slider to ",
                      padding: const EdgeInsets.all(16.0),
                      onChanged: (value) {
                        setShowSlider(value);
                      },
                    ),
                    _showSlider
                        ? _LitSliderImpl(
                            userIconChar: _userIconChar,
                            onChangeSlider: _onChangeSlider,
                          )
                        : SizedBox(),
                    _ButtonList(
                      darkMode: _dark,
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
                "Show VerifyAgeScreen",
                upperCase: true,
                style: LitSansSerifStyles.button.copyWith(
                  color: buttonTextColor,
                ),
              ),
              onPressed: () => {
                LitRouteController(context).pushCupertinoWidget(
                  LitVerifyAgeScreen(
                    onSubmit: (date) {
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
            padding: const EdgeInsets.symmetric(vertical: 16.0),
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
            child: JugglingLoadingIndicator(),
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
      onDismiss: () => LitRouteController(context).navigateBack(),
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

class _LitSignupScreenImplementation extends StatefulWidget {
  const _LitSignupScreenImplementation({Key? key})
      : super(
          key: key,
        );

  @override
  State<_LitSignupScreenImplementation> createState() =>
      _LitSignupScreenImplementationState();
}

class _LitSignupScreenImplementationState
    extends State<_LitSignupScreenImplementation> {
  String username = "";
  String pw = "";
  String pwConf = "";

  @override
  Widget build(BuildContext context) {
    return LitSignUpScreen(
      inputValid: LitInputValidator.validateUsername(username) &&
          pw.isNotEmpty &&
          pwConf == pw,
      onSubmit: () {
        LitRouteController(context).navigateBack();
      },
      data: [
        TextFieldData(
          label: "Username",
          icon: LitIcons.person_solid,
          onChange: (val) {
            setState(() {
              username = val;
            });
          },
          invalidHint: "Your username contains invalid characters or is empty.",
          onValidate: (val) {
            return LitInputValidator.validateUsername(val);
          },
        ),
        TextFieldData(
            label: "Password",
            obscureText: true,
            icon: Icons.lock,
            onChange: (val) {
              setState(() {
                pw = val;
              });
            },
            onValidate: (val) {
              return val.isNotEmpty;
            }),
        TextFieldData(
          label: "Confirm",
          obscureText: true,
          icon: Icons.lock,
          onChange: (val) {
            setState(() {
              pwConf = val;
            });
          },
          onValidate: (val) {
            return val == pw;
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
      appName: "Leitmotif",
      art: _Art(large: false),
      appDescription:
          "Flutter Package implementing the Leitmotif Design Languages",
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
                style: LitSansSerifStyles.body2,
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
          data: ActionButtonData(
            onPressed: () {},
            title: "Action Button Label 1",
          ),
        ),
        DialogActionButton(
          data: ActionButtonData(
            onPressed: () {},
            title: "Action Button Label 2",
          ),
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
