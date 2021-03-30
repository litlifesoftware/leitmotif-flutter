import 'dart:math' as Math;
import 'package:flutter/material.dart';

/// A [Widget] to display a loading animation.
///
/// Use this [Widget] as a placeholder while the result of an asychronous
/// [Future] is awaited. This works similarly to the [CircularProgressIndicator].
class JugglingLoadingIndicator extends StatefulWidget {
  /// The color of the circles transformed.
  final Color indicatorColor;

  /// The [Color] of the painting canvas.
  final Color backgroundColor;

  /// The itensity of the backdrop shadow.
  final double shadowOpacity;

  /// Creates a [JungglingLoadingIndicator].
  const JugglingLoadingIndicator({
    Key? key,
    required this.indicatorColor,
    required this.backgroundColor,
    required this.shadowOpacity,
  }) : super(key: key);
  @override
  _JugglingLoadingIndicatorState createState() =>
      _JugglingLoadingIndicatorState();
}

class _JugglingLoadingIndicatorState extends State<JugglingLoadingIndicator>
    with TickerProviderStateMixin {
  /// Animates the rotation [Transform].
  AnimationController? rotateAnimationController;

  /// Animates the scale [Transform].
  late AnimationController scaleAnimationController;

  @override
  void initState() {
    super.initState();
    rotateAnimationController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 2000,
        ));
    rotateAnimationController!.repeat(reverse: false);
    scaleAnimationController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 2000,
        ));
    scaleAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    rotateAnimationController!.dispose();
    scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedBuilder(
          animation: scaleAnimationController,
          builder: (context, child) {
            return Opacity(
              opacity: scaleAnimationController.value,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(constraints.maxWidth / 3),
                      color: widget.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(widget.shadowOpacity),
                          offset: Offset(-4, 4),
                          blurRadius: 25,
                          spreadRadius: 2,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.scale(
                      //scale: 0.20,
                      scale: 1.0,
                      child: Center(
                          child: AnimatedBuilder(
                              animation: rotateAnimationController!,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: -0.7 -
                                      (scaleAnimationController.value * -0.4),
                                  child: Transform.rotate(
                                    angle: (rotateAnimationController!.value) *
                                        2 *
                                        Math.pi,
                                    child: CustomPaint(
                                      painter: JugglingLoadingIndicatorPaint(
                                        animation: rotateAnimationController,
                                        size: constraints.maxWidth,
                                        color: widget.indicatorColor,
                                      ),
                                    ),
                                  ),
                                );
                              })),
                    ),
                  ),
                ),
              ),
            );
          });
    });
  }
}

class JugglingLoadingIndicatorPaint extends CustomPainter {
  final Animation? animation;
  final double size;
  final Color color;
  JugglingLoadingIndicatorPaint({
    required this.animation,
    required this.size,
    required this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final int steps = 4;
    final double circleOpacity = 1.00 / steps;
    final double circleSize = this.size / 4;

    final Paint circleSteps = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    //

    //
    // 0 deg
    circleSteps.color = color.withOpacity(circleOpacity * 1);
    canvas.drawCircle(Offset(0, -this.size), circleSize, circleSteps);

    // 90 deg
    circleSteps.color = color.withOpacity(circleOpacity * 2);
    canvas.drawCircle(Offset(0, this.size), circleSize, circleSteps);
    // 180 deg
    circleSteps.color = color.withOpacity(circleOpacity * 3);
    canvas.drawCircle(Offset(-this.size, 0), circleSize, circleSteps);
    // 270 deg
    circleSteps.color = color.withOpacity(circleOpacity * 4);
    canvas.drawCircle(Offset(this.size, 0), circleSize, circleSteps);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this.animation!.status == AnimationStatus.forward;
  }
}
