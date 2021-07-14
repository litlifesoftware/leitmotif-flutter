import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A screen widget used to inform the user the app's privacy policy.
///
/// The [textItems] are describing the app's privacy features.
/// The texts are displayed on a page view while a lock icon is illustrating
/// the screen's purpose.
class LitPrivacyDisclaimerScreen extends StatelessWidget {
  /// Creates a [LitPrivacyDisclaimerScreen].
  const LitPrivacyDisclaimerScreen({
    Key? key,
    this.nextButtonLabel = "Next",
    this.confirmButtonLabel = "Okay",
    this.textItems = const [
      TextPageContent(
        title: "Private",
        subtitle: "Your data is safe",
        text: "Your data is private and will only remain on your device.",
      ),
      TextPageContent(
        title: "Offline only",
        subtitle: "Your data is safe",
        text: "No one but you will be able to view your content.",
      ),
    ],
    required this.onConfirm,
    this.backgroundDecoration = const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: const [
          Colors.white,
          LitColors.lightBlue,
        ],
      ),
    ),
  }) : super(key: key);

  /// THe 'next' button's label.
  final String nextButtonLabel;

  /// The 'confirm' button's label.
  final String confirmButtonLabel;

  /// The text items describing the apps
  final List<TextPageContent> textItems;

  /// The screen's background decoration.
  final BoxDecoration backgroundDecoration;

  /// Handles the actions once the 'confirm' button has been pressed.
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      body: Stack(
        children: [
          Container(
            decoration: backgroundDecoration,
          ),
          LitTextPageView(
            middleLayer: _Art(),
            textItems: textItems,
            padding: const EdgeInsets.only(
              top: 152.0,
            ),
            nextButtonLabel: nextButtonLabel,
          ),
          AnimatedActionButton(
            onPressed: onConfirm,
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  LitIcons.times,
                  color: LitColors.mediumGrey,
                  size: 14.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    confirmButtonLabel.toUpperCase(),
                    style: LitSansSerifStyles.button,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// A art widgets displaying the lock icon.
class _Art extends StatelessWidget {
  const _Art({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128.0,
      width: 128.0,
      child: LitGradientCard(
        borderRadius: BorderRadius.all(
          Radius.circular(
            32.0,
          ),
        ),
        child: Center(
          child: LitLockIcon(),
        ),
      ),
    );
  }
}
