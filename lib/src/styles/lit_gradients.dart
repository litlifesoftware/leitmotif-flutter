import 'package:flutter/painting.dart';
import 'package:leitmotif/styles.dart';

/// A collection of [LinearGradient] that can be used as decoration.

class LitGradients {
  /// A very light grey gradient.
  static const LinearGradient verylightGreyGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.65, 1.00],
    colors: [
      LitColors.grey150,
      LitColors.white,
    ],
  );

  /// A light grey gradient.
  static const LinearGradient lightGreyGradient = const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.65, 1.00],
    colors: [
      LitColors.grey100,
      LitColors.grey300,
    ],
  );

  /// A grey linear gradient.
  static const LinearGradient greyGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: const [
      LitColors.grey50,
      LitColors.grey150,
    ],
  );

  /// A dark green linear gradient.
  static const LinearGradient darkGreen = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: const [
      LitColors.green500,
      LitColors.grey600,
    ],
  );

  /// A dark red linear gradient.
  static const LinearGradient darkRed = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: const [
      LitColors.red400,
      LitColors.grey600,
    ],
  );

  /// A grey to pink linear gradient.
  static const LinearGradient pinkWhite = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: const [
      LitColors.grey200,
      LitColors.red200,
    ],
  );

  /// A semi transparent radial gradient used as indicator decoration on
  /// the bottom navigation.
  static const RadialGradient navigationBackdrop = RadialGradient(
    radius: 0.75,
    colors: const [
      LitColors.semiTransparent,
      LitColors.red600_40,
      LitColors.transparent,
    ],
  );
}
