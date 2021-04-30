import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class LitStartupScreen extends StatefulWidget {
  @override
  _LitStartupScreenState createState() => _LitStartupScreenState();
}

class _LitStartupScreenState extends State<LitStartupScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late AnimationController _bubbleAnimation;

  Size get _deviceSize {
    return MediaQuery.of(context).size;
  }

  @override
  void initState() {
    _bubbleAnimation = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 6000,
      ),
    );
    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 210),
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
                                  painter: BackgroundBubbles(
                                    animationController: _bubbleAnimation,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    BluredBackgroundContainer(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(42.0)),
                      blurRadius: 12.0,
                      child: Container(
                        height: 128.0,
                        width: 128.0,
                        decoration: const BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(42.0)),
                          color: const Color(0x66FFFFFF),
                        ),
                      ),
                    ),
                  ],
                ),
                ConstrainedBox(
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
                      Column(
                        children: [
                          Text("sdf"),
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class BackgroundBubbles extends CustomPainter {
  final AnimationController animationController;

  const BackgroundBubbles({required this.animationController});

  Offset calcBubbleOffset(double radius, double rad, Offset center,
      {double? transformDx, double? transformDy}) {
    return Offset(
      (radius * cos(rad) + (center.dx) - (transformDx ?? 0.0)),
      (radius * sin(rad) + (center.dy) - (transformDy ?? 0.0)),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint yellowPaint = Paint()..color = Color(0xFFFBFAF0).withOpacity(0.84);
    Paint cyanPaint = Paint()..color = Color(0xFFE0EFEB).withOpacity(0.93);
    Paint pinkPaint = Paint()..color = Color(0xFFF9E7F4).withOpacity(0.60);
    Paint greenPaint = Paint()..color = Color(0xFFDCE7DC).withOpacity(0.69);
    Paint whitePaint = Paint()..color = Color(0xFFFFFFFF).withOpacity(0.62);

    double yellowRadius = 59.0;
    double cyanRadius = 51.0;
    double pinkRadius = 59.0;
    double greenRadius = 63.0;
    double whiteRadius = 45.0;

    Offset center = Offset(size.width / 2, size.height / 2);

    double yellowRad = (3 * (pi / 180) * 360) * animationController.value;
    double cyanRad = (-2 * (pi / 180) * 360) * animationController.value;
    double pinkRad = ((pi / 180) * 360) * animationController.value;
    double greenRad = (-(pi / 180) * 360) * animationController.value;
    double whiteRad = (-3 * (pi / 180) * 360) * animationController.value;

    double yellowTransformDx = 20.0;
    double yellowTransformDy = 20.0;

    double cyanTransformDx = 15.0;
    double cyanTransformDy = 15.0;

    double whiteTransformDx = 30.0;
    double whiteTransformDy = 30.0;

    Offset yellowTransform = calcBubbleOffset(
      yellowRadius,
      yellowRad,
      center,
      transformDx: yellowTransformDx,
      transformDy: yellowTransformDy,
    );

    Offset cyanTransform = calcBubbleOffset(
      cyanRadius,
      cyanRad,
      center,
      transformDx: cyanTransformDx,
      transformDy: cyanTransformDy,
    );

    Offset pinkTransform = calcBubbleOffset(pinkRadius, pinkRad, center);

    Offset greenTransform = calcBubbleOffset(greenRadius, greenRad, center);

    Offset whiteTransform = calcBubbleOffset(
      whiteRadius,
      whiteRad,
      center,
      transformDx: whiteTransformDx,
      transformDy: whiteTransformDy,
    );

    canvas.drawCircle(greenTransform, greenRadius, greenPaint);
    canvas.drawCircle(yellowTransform, yellowRadius, yellowPaint);
    canvas.drawCircle(cyanTransform, cyanRadius, cyanPaint);
    canvas.drawCircle(pinkTransform, pinkRadius, pinkPaint);
    canvas.drawCircle(whiteTransform, whiteRadius, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
