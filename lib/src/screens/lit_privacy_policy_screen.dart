import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// The [LitPrivacyPolicyScreen]'s `Localization`.
///
/// Contains the localized strings used on the screen.
class LitPrivacyPolicyScreenLocalization {
  final String title;
  final String subtitle;
  final String privateLabel;
  final String offlineLabel;
  final String agreeLabel;

  /// Creates a [LitPrivacyPolicyScreenLocalization].
  const LitPrivacyPolicyScreenLocalization({
    required this.title,
    required this.subtitle,
    required this.privateLabel,
    required this.offlineLabel,
    required this.agreeLabel,
  });
}

/// A Leitmotif `screens` widget allowing to display the app's privacy policy
/// while providing additonal tags to overview the body text.
class LitPrivacyPolicyScreen extends StatefulWidget {
  final LitPrivacyPolicyScreenLocalization? localization;

  /// The privacy policy policy body text.
  final String privacyBody;

  /// The art to display e.g. the app logo.
  final Widget? art;

  /// The callback to be executed once the user accepts the privacy policy.
  final void Function() onAgreeCallback;

  /// The attributes of the provided texts.
  ///
  /// If none provided, the default `private` and `offline` tags are applied.
  /// To disable the tags, provide an empty array.
  final List<PrivacyTagData>? tags;

  /// The background's decoration.
  final BoxDecoration backgroundDecoration;

  /// Creates a [LitPrivacyPolicyScreen].
  const LitPrivacyPolicyScreen({
    Key? key,
    this.localization,
    required this.privacyBody,
    this.art,
    required this.onAgreeCallback,
    this.tags,
    this.backgroundDecoration = const BoxDecoration(
      gradient: LitGradients.greyGradient,
    ),
  }) : super(key: key);

  @override
  _LitPrivacyPolicyScreenState createState() => _LitPrivacyPolicyScreenState();
}

class _LitPrivacyPolicyScreenState extends State<LitPrivacyPolicyScreen>
    with TickerProviderStateMixin {
  /// [ScrollController] to animate link an animation to the user's scroll input.
  late ScrollController _scrollController;

  /// Evaluates whether localizations are provided.
  bool get _l10nAvail => widget.localization != null;

  void _onAgree() {
    Future.delayed(LitAnimationDurations.button).then(
      (_) => widget.onAgreeCallback(),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      appBar: FixedOnScrollTitledAppbar(
        scrollController: _scrollController,
        title: _l10nAvail
            ? widget.localization!.title
            : LeitmotifLocalizations.of(context).privacyPolicyLabel,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: widget.backgroundDecoration,
        child: LitScrollbar(
          child: ScrollableColumn(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            controller: _scrollController,
            children: [
              LitScreenTitle(
                margin: LitEdgeInsets.screen,
                title: _l10nAvail
                    ? widget.localization!.title
                    : LeitmotifLocalizations.of(context).privacyPolicyLabel,
                subtitle: _l10nAvail
                    ? widget.localization!.subtitle
                    : LeitmotifLocalizations.of(context).privacyLabel,
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: LitEdgeInsets.screen.bottom,
                  left: LitEdgeInsets.screen.left,
                  right: LitEdgeInsets.screen.right,
                ),
                child: widget.tags != null
                    ? Builder(
                        builder: (context) {
                          List<Widget> items = [];
                          for (PrivacyTagData tag in widget.tags!) {
                            items.add(
                              _PrivacyTagLabel(
                                condition: tag.isConform,
                                label: tag.text,
                              ),
                            );
                          }
                          return Column(
                            children: items,
                          );
                        },
                      )
                    : Column(
                        children: [
                          _PrivacyTagLabel(
                            condition: true,
                            label:
                                LeitmotifLocalizations.of(context).privateLabel,
                          ),
                          _PrivacyTagLabel(
                            condition: true,
                            label:
                                LeitmotifLocalizations.of(context).offlineLabel,
                          ),
                        ],
                      ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: LitEdgeInsets.screen.bottom,
                  left: LitEdgeInsets.screen.left,
                  right: LitEdgeInsets.screen.right,
                ),
                child: Center(
                  child: LitTitledActionCard(
                    child: Text(
                      widget.privacyBody,
                      style: LitSansSerifStyles.body2,
                    ),
                    actionButtonData: [
                      ActionButtonData(
                        title: _l10nAvail
                            ? widget.localization!.agreeLabel
                            : LeitmotifLocalizations.of(context).agreeLabel,
                        onPressed: _onAgree,
                        backgroundColor: LitColors.red150,
                        accentColor: LitColors.red150,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// A widget to display an individual attribute of the privacy text to provide
/// a short summary.
class _PrivacyTagLabel extends StatelessWidget {
  final String label;

  /// States whether or not the attribute favours the user's privacy.
  final bool condition;
  const _PrivacyTagLabel({
    Key? key,
    required this.label,
    required this.condition,
  }) : super(key: key);

  static const double iconContainerSize = 32.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          children: [
            SizedBox(
              width: constraints.maxWidth - iconContainerSize,
              child: Padding(
                padding: EdgeInsets.only(
                  right: LitEdgeInsets.card.right,
                ),
                child: Text(
                  label.capitalize(),
                  style: LitSansSerifStyles.h6.copyWith(
                    color: LitColors.grey300,
                  ),
                ),
              ),
            ),
            Container(
              height: iconContainerSize,
              width: iconContainerSize,
              decoration: BoxDecoration(
                color: Color(0xFFECFFE9),
                boxShadow: LitBoxShadows.sm,
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              child: Center(
                child: Icon(
                  LitIcons.check,
                  size: 13.0,
                  color: Color(0xFF616161),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
