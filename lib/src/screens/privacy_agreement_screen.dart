import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A screen widget to display the provided privacy policy text and to enable the user
/// to agree the privacy policy.
class PrivacyAgreementScreen extends StatefulWidget {
  /// The screen's title.
  final String title;

  /// The privacy policy text.
  final String privacyText;

  /// The app launcher icon display on the top.
  final String launcherIconImageUrl;

  /// The 'agree' label.
  final String agreeLabel;

  /// The callback to be executed once the user accepts the privacy policy.
  final void Function() onAgreeCallback;

  /// The attributes of the provided texts.
  final List<PrivacyTag> privacyTags;

  /// The background color.
  final Color backgroundColor;

  /// Creates a [PrivacyAgreementScreen].
  ///
  /// Provided localized [title] and [agreeLabel] [String]s if necessary.
  const PrivacyAgreementScreen({
    Key key,
    this.title = "Privacy",
    @required this.privacyText,
    this.launcherIconImageUrl,
    this.agreeLabel = "Agree",
    @required this.onAgreeCallback,
    this.privacyTags = const [],
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  _PrivacyAgreementScreenState createState() => _PrivacyAgreementScreenState();
}

class _PrivacyAgreementScreenState extends State<PrivacyAgreementScreen>
    with TickerProviderStateMixin {
  ScrollController _scrollController;
  AnimationOnScrollController _animationOnScrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _animationOnScrollController = AnimationOnScrollController(
      scrollController: _scrollController,
      maxScrollOffset: 16.0,
      direction: AnimationDirection.forward,
    )..attach(this);
  }

  @override
  void dispose() {
    _animationOnScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      backgroundColor: widget.backgroundColor,
      appBar: FixedOnScrollAppbar(
        //animationOnScrollController: _animationOnScrollController,
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
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            top: 16.0,
            bottom: 32.0,
          ),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: widget.launcherIconImageUrl != null
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.launcherIconImageUrl != null
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
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
                              width: MediaQuery.of(context).size.width * 0.6,
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
                                          final List<Widget> children =
                                              List<Widget>();
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
                  ),
                ),
              ),
              _PrivacyTextCard(
                title: widget.title,
                privacyText: widget.privacyText,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: LitRoundedElevatedButton(
                    color: LitColors.mediumGrey.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ScaledDownText(widget.agreeLabel,
                          style: LitTextStyles.sansSerif.copyWith(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                    onPressed: widget.onAgreeCallback),
              )
            ],
          ),
        ),
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
    Key key,
    @required this.title,
    @required this.privacyText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 16.0,
                  color: Colors.black38,
                  offset: Offset(2, 2),
                  spreadRadius: 2.0,
                )
              ]),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: LitColors.mediumGrey,
                        letterSpacing: 0.35,
                        height: 1.30,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A widget to display an individual attribute of the privacy text to provide
/// a short summary.
class _PrivacyTagLabel extends StatelessWidget {
  final String labelText;

  /// States whether or not the attribute favours the user's privacy.
  final bool favorable;
  const _PrivacyTagLabel({
    Key key,
    @required this.labelText,
    @required this.favorable,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: HexColor('#E8E8E8'),
          boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.black26,
              spreadRadius: 2.0,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClippedText(
                "$labelText",
                style: LitTextStyles.sansSerif.copyWith(
                  fontSize: 14.0,
                ),
              ),
              Icon(
                favorable ? LitIcons.check : LitIcons.times,
                size: 16.0,
                color: favorable ? HexColor('#B1C6AF') : HexColor('#C4AEBC'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// An model class to provide structured data display on
/// the [PrivacyAgreementScreen].
class PrivacyTag {
  final String text;
  final bool isConform;

  /// Creates a [PrivacyTag].
  ///
  /// The attribute values are displayed on the [PrivacyAgreementScreen].
  const PrivacyTag({
    @required this.text,
    @required this.isConform,
  });
}
