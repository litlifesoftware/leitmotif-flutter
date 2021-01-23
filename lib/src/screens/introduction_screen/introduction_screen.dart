import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class IntroductionScreen extends StatefulWidget {
  final Color backgroundColor;
  final void Function() onStartCallback;
  final List<InstructionCard> instructionCards;
  final Color onStartButtonBorderColor;
  final String onStartButtonText;
  final Widget appTitle;
  final Widget artwork;
  final double cardHeight;
  const IntroductionScreen({
    Key key,
    this.backgroundColor = LitColors.darkBlue,
    this.appTitle = const SizedBox(),
    @required this.onStartCallback,
    @required this.instructionCards,
    @required this.onStartButtonText,
    this.artwork = const SizedBox(),
    @required this.onStartButtonBorderColor,
    this.cardHeight = 450.0,
  }) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen>
    with TickerProviderStateMixin {
  AnimationController _appearAnimationController;
  AnimationController _appTitleAnimationController;
  bool showAppTitle = true;

  /// Initializes the [AnimationController]s and plays the [Animation]s.
  void initAnimation() {
    _appearAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1000,
      ),
    );

    if (widget.appTitle != null) {
      _appTitleAnimationController = AnimationController(
          vsync: this,
          duration: Duration(
            milliseconds: 1000,
          ));
      _appTitleAnimationController.forward();
    }
    _appearAnimationController.forward();
  }

  /// Disposes the [AnimationController]s.
  void disposeAnimation() {
    _appearAnimationController.dispose();

    if (widget.appTitle != null) {
      _appTitleAnimationController.dispose();
    }
  }

  /// Animates the displayed [Widget]s in reverse and calls the [widget.onStartCallback]
  /// method.
  void handleOnSkipPress() {
    _appearAnimationController
        .reverse()
        .then((value) => widget.onStartCallback());
  }

  void handleIndexedPageViewScroll(double offset) {
    setState(() {
      if (offset == 0.0) {
        _appTitleAnimationController.reverse(from: 1.0);
      } else {
        _appTitleAnimationController.forward(from: 0.0);
      }
    });
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
      backgroundColor: widget.backgroundColor,
      body: AnimatedBuilder(
        animation: _appearAnimationController,
        builder: (BuildContext context, Widget _) {
          return Stack(
            children: [
              widget.artwork,
              FadeInTransformContainer(
                animationController: _appearAnimationController,
                child: AnimatedOpacity(
                  duration: _appearAnimationController.duration,
                  opacity: _appearAnimationController.value,
                  child: IndexedPageView(
                    children: widget.instructionCards,
                    height: widget.cardHeight,
                    pageScrollListener: widget.appTitle != null
                        ? handleIndexedPageViewScroll
                        : null,
                  ),
                ),
                transform: Matrix4.translationValues(
                    (-MediaQuery.of(context).size.width +
                        (MediaQuery.of(context).size.width *
                            _appearAnimationController.value)),
                    0,
                    0),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: LitRoundedOutlinedButton(
                    borderColor: widget.onStartButtonBorderColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 16.0,
                      ),
                      child: ScaledDownText(
                        widget.onStartButtonText,
                        style: LitTextStyles.sansSerif.copyWith(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    onPressed: handleOnSkipPress,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: FadeInTransformContainer(
                  animationController: _appearAnimationController,
                  transform: Matrix4.translationValues(
                    -100 + (100 * _appearAnimationController.value),
                    0,
                    0,
                  ),
                  child: AnimatedOpacity(
                    opacity: _appTitleAnimationController.value,
                    duration: _appTitleAnimationController.duration,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 80.0,
                      ),
                      child: widget.appTitle,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
