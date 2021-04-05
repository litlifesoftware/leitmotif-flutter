import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A button widget displaying animated bubbles as its background layer.
class LitBubbleButton extends StatefulWidget {
  final BorderRadius borderRadius;
  final Widget child;
  final Duration animationDuration;
  final void Function() onPressed;

  /// Creates a [LitBubbleButton].
  ///
  /// [borderRadius] specifies the button's border radius.
  ///
  /// [child] is the content of the button.
  ///
  /// [onPressed] is the method called once the button has been pressed.
  const LitBubbleButton({
    Key? key,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.0)),
    required this.child,
    this.animationDuration = const Duration(milliseconds: 8000),
    required this.onPressed,
  }) : super(key: key);
  @override
  _LitBubbleButtonState createState() => _LitBubbleButtonState();
}

class _LitBubbleButtonState extends State<LitBubbleButton>
    with TickerProviderStateMixin {
  late AnimationController _bubbleAnimation;

  @override
  void initState() {
    super.initState();
    _bubbleAnimation =
        AnimationController(duration: widget.animationDuration, vsync: this);
    _bubbleAnimation.repeat(reverse: true);
  }

  @override
  void dispose() {
    _bubbleAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitPushedButton(
      onPressed: widget.onPressed,
      child: AnimatedBuilder(
        animation: _bubbleAnimation,
        builder: (context, _) {
          return Transform.scale(
            scale: 0.95 + (_bubbleAnimation.value * 0.15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius,
                color: LitColors.lightPink,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6.0,
                    color: Colors.black26,
                    spreadRadius: 1.0,
                    offset: Offset(
                      0.5,
                      0.5,
                    ),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    16.0,
                  ),
                ),
                child: Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        painter: _BubblePaint(
                          animation: _bubbleAnimation,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8.0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.child,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// The [CustomPaint] rendering the animated bubbles.
class _BubblePaint extends CustomPainter {
  final Animation animation;

  const _BubblePaint({
    required this.animation,
  }) : super();
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width, size.height);

    List<Paint> paints = [
      Paint()..color = Colors.grey.withOpacity(0.67),
      Paint()..color = Colors.pink.withOpacity(0.56),
      Paint()..color = Colors.lightBlue.withOpacity(0.55),
    ];

    canvas.translate((-80 + (170 * animation.value as double)),
        -15 + (15 * animation.value as double));
    canvas.rotate(0.52 * animation.value);

    List<RRect> rrects = [
      RRect.fromRectXY(
        Rect.fromCenter(
          center: Offset(center.dx - 40, center.dy - 15),
          height: 120,
          width: 120,
        ),
        120,
        120,
      ),
      RRect.fromRectXY(
        Rect.fromCenter(center: center, height: 60, width: 60),
        60,
        60,
      ),
      RRect.fromRectXY(
        Rect.fromCenter(
          center: Offset(center.dx + 45, center.dy + 7.5),
          height: 65,
          width: 65,
        ),
        50,
        50,
      ),
    ];

    for (int i = 0; i < rrects.length; i++) {
      canvas.drawRRect(rrects[i], paints[i]);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return animation.value != this.animation.value;
  }
}
