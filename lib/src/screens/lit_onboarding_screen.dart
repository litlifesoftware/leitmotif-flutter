import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// The [LitOnboardingScreen]'s `Localization`.
///
/// Contains the localized strings used on the screen.
class LitOnboardingScreenLocalization {
  final String title;
  final String nextLabel;

  /// Creates a [LitOnboardingScreenLocalization].
  const LitOnboardingScreenLocalization({
    required this.title,
    required this.nextLabel,
  });
}

/// A Leitmotif `screen` widget allowing to display text items to explaing the
/// use of a app.
class LitOnboardingScreen extends StatefulWidget {
  /// The localization applied.
  ///
  /// If none provided, the default [LeitmotifLocalizations] are used.
  final LitOnboardingScreenLocalization? localization;

  /// The app's art.
  final Widget art;

  /// The text items explaining the app.
  final List<TextPageContent> textItems;

  /// The screen's background decoration.
  final BoxDecoration backgroundDecoration;

  /// Handles the `dismiss` action.
  ///
  /// This could either be navigating back or navigating to a new screen.
  final void Function() onDismiss;

  /// Creates a [LitOnboardingScreen].
  const LitOnboardingScreen({
    Key? key,
    required this.textItems,
    this.localization,
    this.art = const SizedBox(),
    this.backgroundDecoration = const BoxDecoration(
      gradient: LitGradients.pinkWhite,
    ),
    required this.onDismiss,
  }) : super(key: key);

  @override
  _LitOnboardingScreenState createState() => _LitOnboardingScreenState();
}

class _LitOnboardingScreenState extends State<LitOnboardingScreen> {
  late ScrollController _scrollController;

  /// Evaluates whether localizations are provided.
  bool get _l10nAvail {
    return widget.localization != null;
  }

  /// Handles the `dismiss` action.
  void _onDismiss() {
    Future.delayed(AnimatedActionButton.defaultAnimationDuration).then(
      (_) {
        widget.onDismiss();
      },
    );
  }

  static const EdgeInsets _pageViewPadding = const EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 16.0,
  );

  double get _spacingTop {
    return _pageViewPadding.vertical * 2;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      appBar: FixedOnScrollTitledAppbar(
        scrollController: _scrollController,
        title: _l10nAvail
            ? widget.localization!.title
            : LeitmotifLocalizations.of(context).onboardingLabel,
      ),
      body: Stack(
        children: [
          Container(
            decoration: widget.backgroundDecoration,
          ),
          ScrollableColumn(
            controller: _scrollController,
            children: [
              SizedBox(
                height: _spacingTop,
              ),
              widget.art,
              LitTextPageView(
                textItems: widget.textItems,
                padding: _pageViewPadding,
                nextButtonLabel:
                    _l10nAvail ? widget.localization!.nextLabel : null,
              ),
            ],
          ),
          AnimatedActionButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LitIcons.times,
                  size: 11.0,
                  color: LitSansSerifStyles.defaultColor,
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  (_l10nAvail
                          ? widget.localization!.title
                          : LeitmotifLocalizations.of(context).dismissLabel)
                      .toUpperCase(),
                  style: LitSansSerifStyles.button,
                ),
              ],
            ),
            onPressed: _onDismiss,
          ),
        ],
      ),
    );
  }
}
