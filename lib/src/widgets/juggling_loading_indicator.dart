import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:leitmotif/styles.dart';

/// A Leitmotif widget displaying a loading animation.
///
class JugglingLoadingIndicator extends StatefulWidget {
  /// The circles' color.
  final Color color;

  /// The background's color.
  final Color backgroundColor;

  /// The itensity of the backdrop shadow.
  final List<BoxShadow> boxShadow;

  /// Defines the size of the indicator.
  final double size;

  /// Defines the padding applied on the widget.
  final EdgeInsets padding;

  /// Creates a [JugglingLoadingIndicator].
  const JugglingLoadingIndicator({
    Key? key,
    this.size = 54.0,
    this.color = LitColors.mediumGrey,
    this.backgroundColor = Colors.white,
    this.boxShadow = LitBoxShadows.lg,
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);
  @override
  _JugglingLoadingIndicatorState createState() =>
      _JugglingLoadingIndicatorState();
}

class _JugglingLoadingIndicatorState extends State<JugglingLoadingIndicator>
    with TickerProviderStateMixin {
  static const Duration duration = const Duration(milliseconds: 2000);

  /// Controlls the rotation animation.
  late AnimationController rotateAnimationController;

  /// Controlls the scale animation.
  late AnimationController scaleAnimationController;

  /// The animation's scale.
  double get _scale {
    return -0.7 - (scaleAnimationController.value * -0.4);
  }

  /// The animation's angle.
  double get _angle {
    return (rotateAnimationController.value) * 2 * Math.pi;
  }

  /// Initializes and runs the rotation animation.
  void _initRotateAnim() {
    rotateAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 2000,
      ),
    )..repeat(reverse: false);
  }

  /// Initializes and runs the scale animation.
  void _initScaleAnim() {
    scaleAnimationController = AnimationController(
      vsync: this,
      duration: duration,
    )..repeat(reverse: true);
  }

  @override
  void initState() {
    _initRotateAnim();
    _initScaleAnim();
    super.initState();
  }

  @override
  void dispose() {
    rotateAnimationController.dispose();
    scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedBuilder(
            animation: scaleAnimationController,
            builder: (context, child) {
              return Opacity(
                opacity: scaleAnimationController.value,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        constraints.maxWidth / 3,
                      ),
                      color: widget.backgroundColor,
                      boxShadow: widget.boxShadow,
                    ),
                    child: Padding(
                      padding: widget.padding,
                      child: Center(
                        child: AnimatedBuilder(
                          animation: rotateAnimationController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scale,
                              child: Transform.rotate(
                                angle: _angle,
                                child: CustomPaint(
                                  painter: _JugglingLoadingIndicatorPaint(
                                    animation: rotateAnimationController,
                                    size: constraints.maxWidth,
                                    color: widget.color,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// A CustomPainter to paing the progress animation.
class _JugglingLoadingIndicatorPaint extends CustomPainter {
  final Animation animation;
  final double size;
  final Color color;
  _JugglingLoadingIndicatorPaint({
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
    return this.animation.status == AnimationStatus.forward;
  }
}
