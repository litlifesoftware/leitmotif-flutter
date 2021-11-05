import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A screen widget used to inform the user the app's privacy policy.
///
/// The [textItems] are describing the app's privacy features.
/// The texts are displayed on a page view while a lock icon is illustrating
/// the screen's purpose.
class LitPrivacyDisclaimerScreen extends StatelessWidget {
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
      gradient: LitGradients.pinkWhite,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      body: Stack(
        children: [
          Container(
            decoration: backgroundDecoration,
          ),
          ScrollableColumn(
            children: [
              SizedBox(height: 32.0),
              _Art(),
              SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LitTextPageView(
                  //middleLayer: ,
                  textItems: textItems,

                  nextButtonLabel: nextButtonLabel,
                ),
              ),
            ],
          ),
          AnimatedActionButton(
            onPressed: onConfirm,
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LitIcons.times,
                  color: LitColors.mediumGrey,
                  size: 12.0,
                ),
                SizedBox(width: 6.0),
                ClippedText(
                  confirmButtonLabel.toUpperCase(),
                  style: LitSansSerifStyles.button,
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
        colors: [Colors.white, LitColors.lightGrey],
        borderRadius: BorderRadius.all(
          Radius.circular(
            128.0 / 2.5,
          ),
        ),
        child: Center(
          child: LitLockIcon(),
        ),
      ),
    );
  }
}
