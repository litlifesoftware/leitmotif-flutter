import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class LitOnboardingScreen extends StatefulWidget {
  final Decoration backgroundDecoration;
  final void Function() onStartCallback;
  final List<InstructionCard> instructionCards;
  final String onStartButtonText;
  final Widget artwork;
  final double minCardHeight;
  final TextStyle buttonTextStyle;
  final Color buttonBackgroundColor;
  final Color buttonAccentColor;
  final EdgeInsets cardMargin;
  const LitOnboardingScreen({
    Key key,
    this.backgroundDecoration = const BoxDecoration(
      gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: const [
            Colors.grey,
            Colors.white,
          ],
          stops: [
            0.3,
            0.86,
          ]),
    ),
    @required this.onStartCallback,
    @required this.instructionCards,
    @required this.onStartButtonText,
    this.artwork = const SizedBox(),
    this.minCardHeight = 256.0,
    this.buttonTextStyle = LitTextStyles.sansSerifTitle,
    this.buttonAccentColor = Colors.black,
    this.buttonBackgroundColor = Colors.white,
    this.cardMargin = const EdgeInsets.only(
      top: 85.0,
      bottom: 64.0,
    ),
  }) : super(key: key);

  @override
  _LitOnboardingScreenState createState() => _LitOnboardingScreenState();
}

class _LitOnboardingScreenState extends State<LitOnboardingScreen>
    with TickerProviderStateMixin {
  AnimationController _fadeInAnimation;
  AnimationController _artworkAnimation;
  bool showAppTitle = true;

  /// Initializes the [AnimationController]s and plays the [Animation]s.
  void initAnimation() {
    _fadeInAnimation = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 210,
      ),
    );

    _artworkAnimation = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 180,
        ));
    _artworkAnimation.forward();

    _fadeInAnimation.forward();
  }

  /// Disposes the [AnimationController]s.
  void disposeAnimation() {
    _fadeInAnimation.dispose();

    _artworkAnimation.dispose();
  }

  /// Animates the displayed [Widget]s in reverse and calls the [widget.onStartCallback]
  /// method.
  void handleOnSkipPress() {
    _fadeInAnimation.reverse().then((value) => widget.onStartCallback());
  }

  void handleIndexedPageViewScroll(double offset) {
    if (offset > 0.0) {
      if (offset < 1.0) {
        if (!_artworkAnimation.isAnimating) {
          _artworkAnimation.forward();
        }
      } else {
        if (!_artworkAnimation.isAnimating) {
          _artworkAnimation.reverse();
        }
      }
    }
  }

  List<Widget> get _columnChildren {
    return [
      LitConstrainedSizedBox(
        child: Padding(
          padding: widget.cardMargin,
          child: FadeInTransformContainer(
            animationController: _fadeInAnimation,
            child: AnimatedOpacity(
              duration: _fadeInAnimation.duration,
              opacity: _fadeInAnimation.value,
              child: IndexedPageView(
                children: widget.instructionCards,
                pageScrollListener: handleIndexedPageViewScroll,
              ),
            ),
            transform: Matrix4.translationValues(
                (-MediaQuery.of(context).size.width +
                    (MediaQuery.of(context).size.width *
                        _fadeInAnimation.value)),
                0,
                0),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: LitPushedThroughButton(
            backgroundColor: widget.buttonBackgroundColor,
            accentColor: widget.buttonAccentColor,
            onPressed: handleOnSkipPress,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 16.0,
              ),
              child: ScaledDownText(
                widget.onStartButtonText,
                style: widget.buttonTextStyle,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  Size get _deviceSize {
    return MediaQuery.of(context).size;
  }

  @override
  void initState() {
    initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    disposeAnimation();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: widget.backgroundDecoration,
        child: AnimatedBuilder(
          animation: _fadeInAnimation,
          builder: (BuildContext context, Widget _) {
            return Stack(
              children: [
                AnimatedBuilder(
                  animation: _artworkAnimation,
                  builder: (context, _) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: AnimatedOpacity(
                        opacity: _artworkAnimation.value,
                        duration: _artworkAnimation.duration,
                        child: widget.artwork,
                      ),
                    );
                  },
                ),
                // If the scren is in portrait mode
                isPortraitMode(_deviceSize)
                    // Display a non-scrollable column.
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: _columnChildren,
                      )
                    // Otherwise display a scrollable column to avoid any overflow
                    // on landscape mode.
                    : ScrollableColumn(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: _columnChildren,
                      )
              ],
            );
          },
        ),
      ),
    );
  }
}
