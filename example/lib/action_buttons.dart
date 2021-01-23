import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class ActionButtons extends StatelessWidget {
  final bool darkMode;
  final DateTime dayOfBirth;
  final void Function(DateTime) onSubmitCallback;
  final void Function() onShowSnackbarCallback;
  final Color buttonBorderColor;
  final Color buttonTextColor;
  const ActionButtons({
    Key key,
    @required this.darkMode,
    @required this.dayOfBirth,
    @required this.onSubmitCallback,
    @required this.onShowSnackbarCallback,
    @required this.buttonBorderColor,
    @required this.buttonTextColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
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
              onPressed: onShowSnackbarCallback),
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
                      onSubmitCallback: onSubmitCallback,
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
                    return IntroductionScreen(
                      onStartCallback: () => Navigator.of(context).pop(),
                      appTitle: ScaledDownText(
                        "LitUIKit",
                        style: LitTextStyles.sansSerif,
                      ),
                      instructionCards: [
                        InstructionCard(
                          description:
                              "This text could describe how to use your app. List all key features.",
                          title: ScaledDownText("This is a title",
                              style: LitTextStyles.sansSerif),
                        ),
                        InstructionCard(
                          description: "This is an introduction card...",
                          title: ScaledDownText("This is a title",
                              style: LitTextStyles.sansSerif),
                        ),
                        InstructionCard(
                          description: "This is an introduction card...",
                          title: ScaledDownText("This is a title",
                              style: LitTextStyles.sansSerif),
                        ),
                      ],
                      onStartButtonText: "start",
                      onStartButtonBorderColor: Colors.white,
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
              "Show Privacy Screen",
              style: LitTextStyles.sansSerif.copyWith(
                color: buttonTextColor,
              ),
            ),
            onPressed: () => {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) {
                    return PrivacyAgreementScreen(
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
                            "This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions.This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions. This is a text stating privacy conditions.",
                        onAgreeCallback: () {
                          Navigator.pop(context);
                        });
                  },
                ),
              )
            },
          ),
        ),
      ],
    );
  }
}
