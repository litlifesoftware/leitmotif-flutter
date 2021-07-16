import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// An icon displaying a lock.
///
/// The icon is rendered using a [CustomPainter] to achieve a gradient background
/// effect.
class LitLockIcon extends StatefulWidget {
  /// The icon size.
  final double size;

  /// The icon color.
  final Color color;

  /// The animation duration.
  final Duration animationDuration;

  /// Creates a [LitLockIcon].
  ///
  /// Specify the [size] and [color] property to customize its appearance.
  ///
  /// * [size] is the icons's size.
  /// * [color] is the icon's main color. The gradient's accent colors are
  ///   using this color value generated.
  /// * [animationDuration] is the duration the animation should have.
  const LitLockIcon({
    Key? key,
    this.size = 48.0,
    this.color = const Color(0xFFAAAAAA),
    this.animationDuration = const Duration(milliseconds: 400),
  }) : super(key: key);

  @override
  _LitLockIconState createState() => _LitLockIconState();
}

class _LitLockIconState extends State<LitLockIcon>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return CustomPaint(
          painter: _LockPainter(
            animationController: _animationController,
            lockSize: widget.size,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class _LockPainter extends CustomPainter {
  final AnimationController animationController;
  final double lockSize;
  final Color color;
  const _LockPainter({
    required this.animationController,
    required this.lockSize,
    required this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    double enclosureHeight = lockSize;
    double enclosureWidth = lockSize * 1.083;
    double shackleHeight = enclosureHeight * 1.166;
    double shackleWidth = shackleHeight / 2;
    double wardBladeHeight = enclosureHeight / 4;
    double wardBladeRadius = wardBladeHeight / 3;
    double wardBitWidth = wardBladeRadius * 1.2;

    final Color white = const Color(0xFFFFFFFF);
    final Color dark = color;
    final Color? light = Color.lerp(
      dark,
      white,
      0.75,
    );

    Offset canvasCenter = Offset(
      (size.width / 2),
      (size.height / 2),
    );

    Paint solidGrey = Paint()..color = const Color(0xFF777777);
    Paint strokeDark = Paint()
      ..shader = ui.Gradient.linear(
        Offset(
          enclosureWidth,
          0,
        ),
        Offset(
          0,
          enclosureHeight,
        ),
        [
          light!,
          dark,
        ],
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = enclosureHeight * 0.145;

    Paint enclosurePaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(
          enclosureWidth,
          0,
        ),
        Offset(
          0,
          enclosureHeight,
        ),
        [
          white,
          dark,
        ],
      );

    Offset enclosureCenter = Offset(
      canvasCenter.dx,
      canvasCenter.dy + (enclosureHeight / 4),
    );
    Offset shackleCenter = Offset(
      canvasCenter.dx,
      enclosureCenter.dx -
          (enclosureHeight * 0.12) +
          ((1.0 - animationController.value) * 16.0),
    );
    Offset bladeCenter = Offset(
      canvasCenter.dx,
      enclosureCenter.dy - (enclosureHeight * 0.0625),
    );
    Offset bitCenter = Offset(
      canvasCenter.dx,
      bladeCenter.dy + (enclosureHeight * 0.1875),
    );

    RRect enclosure = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: enclosureCenter,
        height: enclosureHeight,
        width: enclosureWidth,
      ),
      Radius.circular(wardBladeHeight),
    );

    RRect shackle = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: shackleCenter,
        height: shackleHeight,
        width: shackleWidth,
      ),
      Radius.circular(shackleHeight * 0.4),
    );

    RRect wardBlade = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: bladeCenter,
        height: wardBladeHeight,
        width: wardBladeHeight,
      ),
      Radius.circular(wardBladeRadius),
    );

    RRect wardBit = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: bitCenter,
        height: wardBladeHeight,
        width: wardBitWidth,
      ),
      Radius.circular(wardBladeRadius),
    );
    canvas.drawRRect(shackle, strokeDark);
    canvas.drawRRect(enclosure, enclosurePaint);

    canvas.drawRRect(wardBlade, solidGrey);
    canvas.drawRRect(wardBit, solidGrey);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
