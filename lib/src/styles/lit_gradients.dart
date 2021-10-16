import 'package:flutter/painting.dart';
import 'package:leitmotif/styles.dart';

/// A collection of [LinearGradient] that can be used as decoration.

class LitGradients {
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

  static const LinearGradient dark = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: const [
      LitColors.green500,
      LitColors.grey600,
    ],
  );

  static const LinearGradient pinkWhite = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: const [
      LitColors.grey200,
      LitColors.red200,
    ],
  );
}
