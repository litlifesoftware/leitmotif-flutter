import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A screen widget to display the provided privacy policy text and to enable the user
/// to agree the privacy policy.
class LitPrivacyPolicyScreen extends StatefulWidget {
  /// The screen's title.
  final String title;

  /// The privacy policy text.
  final String privacyText;

  /// The app launcher icon display on the top.
  final String? launcherIconImageUrl;

  /// The 'agree' label.
  final String agreeLabel;

  /// The callback to be executed once the user accepts the privacy policy.
  final void Function() onAgreeCallback;

  /// The attributes of the provided texts.
  final List<PrivacyTag> privacyTags;

  /// The background's decoration.
  final BoxDecoration backgroundDecoration;

  /// Creates a [LitPrivacyPolicyScreen].
  ///
  /// * [title] defines the displayed title text.
  ///
  /// * [privacyText] defines the diplayed privacy text.
  ///
  /// * [launcherIconImageUrl] is the displayed image's location.
  ///
  /// * [agreeLabel] is the text that should be displayed as button label.
  ///
  /// * [onAgreeCallback] is called once the 'agree' button is pressed.
  ///
  /// * [privacyTags] are displayed on the top to state the policies key statements.
  ///
  /// * [backgroundDecoration] sets the decoration of the background layer.
  const LitPrivacyPolicyScreen({
    Key? key,
    this.title = "Privacy",
    required this.privacyText,
    this.launcherIconImageUrl,
    this.agreeLabel = "Agree",
    required this.onAgreeCallback,
    this.privacyTags = const [],
    this.backgroundDecoration = const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: const [
          Colors.white,
          LitColors.lightGrey,
        ],
      ),
    ),
  }) : super(key: key);

  @override
  _LitPrivacyPolicyScreenState createState() => _LitPrivacyPolicyScreenState();
}

class _LitPrivacyPolicyScreenState extends State<LitPrivacyPolicyScreen>
    with TickerProviderStateMixin {
  /// [ScrollController] to animate link an animation to the user's scroll input.
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      appBar: FixedOnScrollAppbar(
        scrollController: _scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            widget.title,
            style: LitTextStyles.sansSerif.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: widget.backgroundDecoration,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: 16.0,
              bottom: 32.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LitConstrainedSizedBox(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: widget.launcherIconImageUrl != null
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [
                          widget.launcherIconImageUrl != null
                              ? SizedBox(
                                  width: constraints.maxWidth * 0.35,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 20.0,
                                            color: Colors.black45,
                                            spreadRadius: 2.0,
                                            offset: Offset(2, 2),
                                          )
                                        ],
                                      ),
                                      child: Image(
                                        image: AssetImage(
                                            "${widget.launcherIconImageUrl}"),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          widget.privacyTags.length > 0
                              ? SizedBox(
                                  width: constraints.maxWidth * 0.65,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 16.0,
                                      top: 16.0,
                                      bottom: 16.0,
                                    ),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16.0),
                                          child: Builder(
                                            builder: (BuildContext context) {
                                              final List<Widget> children = [];
                                              for (final tag
                                                  in widget.privacyTags) {
                                                children.add(
                                                  _PrivacyTagLabel(
                                                    favorable: tag.isConform,
                                                    labelText: "${tag.text}",
                                                  ),
                                                );
                                              }
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: children,
                                              );
                                            },
                                          )),
                                    ),
                                  ))
                              : SizedBox(),
                        ],
                      );
                    },
                  ),
                ),
                _PrivacyTextCard(
                  title: widget.title,
                  privacyText: widget.privacyText,
                ),
                _AgreeButton(
                  label: widget.agreeLabel,
                  onPressed: widget.onAgreeCallback,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AgreeButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const _AgreeButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: LitGradientButton(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            15.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ScaledDownText(
            label,
            style: LitTextStyles.sansSerif.copyWith(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

/// A widget to display the provided [privacyText] on a card background.
class _PrivacyTextCard extends StatelessWidget {
  final String title;
  final String privacyText;

  /// Creates a [_PrivacyTextCard] widget.
  const _PrivacyTextCard({
    Key? key,
    required this.title,
    required this.privacyText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LitElevatedCard(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 8.0,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 265.0,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: ClippedText(title,
                      textAlign: TextAlign.center,
                      style: LitTextStyles.sansSerif.copyWith(
                        color: LitColors.lightGrey,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Text(
                    privacyText,
                    style: LitTextStyles.sansSerif.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: LitColors.mediumGrey,
                      letterSpacing: 0.55,
                      height: 1.30,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

/// A widget to display an individual attribute of the privacy text to provide
/// a short summary.
class _PrivacyTagLabel extends StatelessWidget {
  final String labelText;

  /// States whether or not the attribute favours the user's privacy.
  final bool favorable;
  const _PrivacyTagLabel({
    Key? key,
    required this.labelText,
    required this.favorable,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LitElevatedCard(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClippedText(
            "$labelText",
            style: LitTextStyles.sansSerif.copyWith(
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          Icon(
            favorable ? LitIcons.check : LitIcons.times,
            size: 16.0,
            color: favorable ? HexColor('#B1C6AF') : HexColor('#C4AEBC'),
          ),
        ],
      ),
    );
  }
}

/// An model class to provide structured data display on
/// the [LitPrivacyPolicyScreen].
class PrivacyTag {
  final String text;
  final bool isConform;

  /// Creates a [PrivacyTag].
  ///
  /// The attribute values are displayed on the [LitPrivacyPolicyScreen].
  const PrivacyTag({
    required this.text,
    required this.isConform,
  });
}
