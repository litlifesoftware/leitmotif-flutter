import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A screen widget displaying a specified artwork in front of a bubble-styled
/// animated background.
///
/// The screen could potentially be shown on an app's initial startup as part
/// of the developer's (corporate) identity.
class LitStartupScreen extends StatefulWidget {
  /// The animation duration.
  final Duration animationDuration;

  /// The screen's artwork.
  final Widget art;

  /// The screen's title.
  final String title;

  /// The screen's subtitle.
  final String subtitle;

  /// Creates a [LitStartupScreen].
  ///
  /// * [animationDuration] is the duration of the background's animation cycle.
  ///   The animation will be repeated.
  ///
  /// * [art] is the artwork widget shown in front of the bubble animation. This
  ///   will default to the [LitLifeBlurredBackgroundLogo]. Use your own art if
  ///   desired by passing a custom value.
  ///
  /// * [title] is the title of the screen shown on the top. This could either
  ///   be the app's title or the developer's name.
  ///
  /// * [subtitle] is the subtitle of the screen shown on the bottom. This
  ///   could either be a copyright tag or something similar.
  const LitStartupScreen({
    Key? key,
    this.animationDuration = const Duration(
      milliseconds: 6000,
    ),
    this.art = const LitLifeBlurredBackgroundLogo(),
    this.title = "LitLifeSoftware",
    this.subtitle = "\u00a9 2019-2021",
  }) : super(key: key);
  @override
  _LitStartupScreenState createState() => _LitStartupScreenState();
}

class _LitStartupScreenState extends State<LitStartupScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late AnimationController _bubbleAnimation;

  final Duration _fadeDuration = Duration(milliseconds: 500);

  Size get _deviceSize {
    return MediaQuery.of(context).size;
  }

  @override
  void initState() {
    _bubbleAnimation = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: _fadeDuration,
    );

    _bubbleAnimation.repeat(reverse: false);

    _fadeAnimationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    _bubbleAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: _deviceSize.height,
        width: _deviceSize.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFFCE4E4),
              Color(0xFFB7ACBF),
            ],
          ),
        ),
        child: AnimatedBuilder(
          animation: _fadeAnimationController,
          builder: (context, _) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedOpacity(
                          duration: _fadeAnimationController.duration!,
                          opacity: _fadeAnimationController.value,
                          child: AnimatedBuilder(
                            animation: _bubbleAnimation,
                            builder: (context, _) {
                              return SizedBox(
                                height: 256.0,
                                width: 256.0,
                                child: CustomPaint(
                                  painter: BackgroundBubblesPainter(
                                    animationController: _bubbleAnimation,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    AnimatedOpacity(
                      duration: _fadeAnimationController.duration!,
                      opacity: _fadeAnimationController.value,
                      child: widget.art,
                    ),
                  ],
                ),
                AnimatedOpacity(
                  duration: _fadeAnimationController.duration!,
                  opacity: _fadeAnimationController.value,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: _deviceSize.height,
                      minWidth: _deviceSize.width,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(),
                        SizedBox(),
                        SizedBox(),
                        SizedBox(),
                        Text(
                          widget.title,
                          style: LitTextStyles.sansSerifHeader.copyWith(
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Colors.black12,
                                offset: Offset(-2, 2),
                                spreadRadius: -1,
                              )
                            ],
                          ),
                        ),
                        Text(
                          widget.subtitle,
                          style: LitTextStyles.sansSerifHeader.copyWith(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
