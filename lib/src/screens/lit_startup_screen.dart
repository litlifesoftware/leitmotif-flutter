import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `screens` widget displaying the developer's logo on an animated
/// background.
///
/// The screen could potentially be shown on an app's initial startup as part
/// of the developer's (corporate) identity.
class LitStartupScreen extends StatefulWidget {
  /// The animation duration.
  final Duration animationDuration;

  /// The screen's artwork.
  final Widget? art;

  /// The screen's title.
  final String? title;

  /// The screen's subtitle.
  final String? subtitle;

  /// The size the animated art should be drawn on.
  final double backgroundSize;

  /// Creates a [LitStartupScreen].
  const LitStartupScreen({
    Key? key,
    this.animationDuration = const Duration(
      milliseconds: 6000,
    ),
    this.art,
    this.title,
    this.subtitle,
    this.backgroundSize = 256.0,
  }) : super(key: key);
  @override
  _LitStartupScreenState createState() => _LitStartupScreenState();
}

class _LitStartupScreenState extends State<LitStartupScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationControllerCont;

  static const Duration _fadeDuration = LitAnimationDurations.appearAnimation;

  Size get _deviceSize {
    return MediaQuery.of(context).size;
  }

  static const double _spacingY = 30.0;

  @override
  void initState() {
    super.initState();

    _animationControllerCont = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat(reverse: false);

    _animationController = AnimationController(
      vsync: this,
      duration: _fadeDuration,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationControllerCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Container(
          height: _deviceSize.height,
          width: _deviceSize.width,
          decoration: BoxDecoration(
            gradient: LitGradients.pinkBeige,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              _AnimatedBackground(
                animationController: _animationControllerCont,
                size: widget.backgroundSize,
              ),
              AnimatedBuilder(
                animation: _animationController,
                child: widget.art ?? const LitLifeBlurredBackgroundLogo(),
                builder: (context, child) {
                  return AnimatedOpacity(
                    duration: _fadeDuration,
                    opacity: _animationController.value,
                    child: child,
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animationController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: _spacingY),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.title ?? "LitLifeSoftware",
                        style: LitSansSerifStyles.h5.copyWith(
                          color: Colors.white,
                          shadows: LitBoxShadows.textMd,
                        ),
                      ),
                      SizedBox(height: _spacingY),
                      Text(
                        widget.subtitle ??
                            '\u00a9' + ' ' + DateTime.now().year.toString(),
                        style: LitSansSerifStyles.subtitle1.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: _spacingY),
                    ],
                  ),
                ),
                builder: (context, child) {
                  return AnimatedOpacity(
                    duration: _animationController.duration!,
                    opacity: _animationController.value,
                    child: child,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Displays an animated background on the [LitStartupScreen].
class _AnimatedBackground extends StatelessWidget {
  final AnimationController animationController;
  final double size;
  const _AnimatedBackground({
    Key? key,
    required this.animationController,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: animationController,
          builder: (context, _) {
            return SizedBox(
              height: size,
              width: size,
              child: CustomPaint(
                painter: BackgroundBubblesPainter(
                  animationController: animationController,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
