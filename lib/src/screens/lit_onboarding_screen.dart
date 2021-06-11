import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:lit_ui_kit/src/widgets/containers/lit_elevated_glass_card.dart';

class LitOnboardingScreen extends StatefulWidget {
  final String title;
  final String nextButtonLabel;
  final Widget art;
  final List<OnboardingText> textItems;
  final BorderRadius cardBorderRadius;
  final BoxDecoration backgroundDecoration;
  final Duration animationDuration;
  final void Function() onExit;
  const LitOnboardingScreen({
    Key? key,
    this.title = "Onboading",
    this.nextButtonLabel = "Next",
    this.art = const SizedBox(),
    required this.textItems,
    this.cardBorderRadius = const BorderRadius.all(Radius.circular(42.0)),
    this.backgroundDecoration = const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          const Color(0xFFc6c6c6),
          const Color(0xFFC18F8F),
        ],
      ),
    ),
    this.animationDuration = const Duration(milliseconds: 120),
    required this.onExit,
  }) : super(key: key);

  @override
  _LitOnboardingScreenState createState() => _LitOnboardingScreenState();
}

class _LitOnboardingScreenState extends State<LitOnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late ScrollController _scrollController;
  int selectedTextItem = 0;
  void _onPressed() {
    _animationController
        .reverse()
        .then((value) => _animationController.forward());
    if (selectedTextItem < (widget.textItems.length - 1)) {
      setState(() {
        selectedTextItem++;
      });
    } else {
      setState(() {
        selectedTextItem = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      appBar: FixedOnScrollAppbar(
        scrollController: _scrollController,
        child: ClippedText(
          widget.title,
          style: LitTextStyles.sansSerifStyles[body],
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              decoration: widget.backgroundDecoration,
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: _Card(
                animationController: _animationController,
                text: widget.textItems[selectedTextItem],
                nextButtonLabel: widget.nextButtonLabel,
                art: widget.art,
                buttonAnimationDuration: widget.animationDuration,
                borderRadius: widget.cardBorderRadius,
                onPressed: _onPressed,
              ),
            ),
          ),
          AnimatedActionButton(
            onPressed: widget.onExit,
            alignment: Alignment.bottomLeft,
            child: Icon(
              LitIcons.times,
              color: LitColors.mediumGrey,
              size: 16.0,
            ),
          )
        ],
      ),
    );
  }
}

class _Card extends StatefulWidget {
  final AnimationController animationController;
  final OnboardingText text;
  final String nextButtonLabel;
  final BorderRadius borderRadius;
  final Widget art;
  final EdgeInsets padding;
  final void Function() onPressed;
  final double horizontalTransform;
  final Duration buttonAnimationDuration;
  final double initialScale;
  final double animatedScale;
  const _Card({
    Key? key,
    required this.animationController,
    required this.text,
    required this.nextButtonLabel,
    required this.borderRadius,
    required this.art,
    this.padding = const EdgeInsets.only(
      top: 128.0,
    ),
    required this.onPressed,
    this.horizontalTransform = 60.0,
    required this.buttonAnimationDuration,
    this.initialScale = 1.00,
    this.animatedScale = 1.05,
  }) : super(key: key);

  @override
  __CardState createState() => __CardState();
}

class __CardState extends State<_Card> {
  Matrix4 get _transform {
    final double _x = widget.initialScale;
    final double _y = widget.animatedScale -
        ((widget.animatedScale - widget.initialScale) *
            widget.animationController.value);
    return Matrix4.identity()..scale(_x, _y);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, _) {
        return LitElevatedGlassCard(
          padding: widget.padding,
          borderRadius: widget.borderRadius,
          child: _CardContent(
            text: widget.text,
            nextButtonLabel: widget.nextButtonLabel,
            buttonAnimationDuration: widget.buttonAnimationDuration,
            onPressed: widget.onPressed,
          ),
          middleLayer: Align(alignment: Alignment.topCenter, child: widget.art),
          transform: _transform,
        );
      },
    );
  }
}

class _CardContent extends StatelessWidget {
  final OnboardingText text;
  final String nextButtonLabel;
  final Duration buttonAnimationDuration;
  final void Function() onPressed;
  const _CardContent({
    Key? key,
    required this.text,
    required this.nextButtonLabel,
    required this.buttonAnimationDuration,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        bottom: 32.0,
        left: 32.0,
        right: 32.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            child: Text(
              text.subtitle.toUpperCase(),
              textAlign: TextAlign.start,
              style: LitTextStyles.sansSerif.copyWith(
                fontSize: 16.0,
                color: HexColor('#6c6c6c'),
                letterSpacing: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            text.title,
            style: LitTextStyles.sansSerif.copyWith(
              fontSize: 32.0,
              color: HexColor('#6E6E6E'),
              letterSpacing: 2.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Text(
              text.text,
              style: LitTextStyles.sansSerif.copyWith(
                fontSize: 14.0,
                color: HexColor('#525252'),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: LitPushedThroughButton(
                  accentColor: Colors.white,
                  backgroundColor: Colors.white,
                  animationDuration: buttonAnimationDuration,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8.0,
                      color: Colors.black45,
                      offset: Offset(-4, 3),
                      spreadRadius: -2.0,
                    )
                  ],
                  margin: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 8.0,
                  ),
                  child: ClippedText(
                    nextButtonLabel,
                    upperCase: true,
                    style: LitTextStyles.sansSerif.copyWith(
                      fontSize: 14.0,
                      color: HexColor('#525252'),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                  onPressed: onPressed),
            ),
          )
        ],
      ),
    );
  }
}

/// A model class to describe the onboarding's card content. The card will display a
/// subtitle, a title and the actual text.
class OnboardingText {
  final String subtitle;
  final String title;
  final String text;

  /// Creates a [OnboardingText] data object.
  const OnboardingText({
    required this.subtitle,
    required this.title,
    required this.text,
  });
}
