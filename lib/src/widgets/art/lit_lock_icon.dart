import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// An icon displaying a lock.
///
/// The icon is rendered using a [CustomPainter] to achieve a gradient background
/// effect.
class LitLockIcon extends StatelessWidget {
  final double size;
  final Color color;

  /// Creates a [LitLockIcon].
  ///
  /// Specify the [size] and [color] property to customize its appearance.
  const LitLockIcon({
    Key? key,

    /// The total size of the [LitLockIcon] painted on the screen.
    this.size = 48.0,

    /// The [LitLockIcon]'s [Color] on which the gradient shaders are built on.
    this.color = const Color(0xFF827D7D),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LockPainter(
        lockSize: size,
        color: color,
      ),
    );
  }
}

class _LockPainter extends CustomPainter {
  final double lockSize;
  final Color color;
  const _LockPainter({
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
      0.65,
    );

    Offset canvasCenter = Offset(
      (size.width / 2),
      (size.height / 2),
    );

    Paint solidLight = Paint()..color = white;
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
      enclosureCenter.dx - (enclosureHeight * 0.083),
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

    canvas.drawRRect(wardBlade, solidLight);
    canvas.drawRRect(wardBit, solidLight);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
