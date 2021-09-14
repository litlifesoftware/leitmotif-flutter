import 'package:flutter/painting.dart';

/// A collection of [LinearGradient] that can be used as decoration.

class LitGradients {
  /// A grey linear gradient.
  static const LinearGradient greyGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: const [
      const Color(0xFFFDFDFD),
      const Color(0xFFDEDEDE),
    ],
  );
}
