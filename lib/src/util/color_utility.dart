import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A controller class to provided extended functionality to default [Color]
/// class.
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    try {
      if (hexColor.length == 6) {
        hexColor = "FF" + hexColor;
      }
    } catch (e) {
      hexColor = "FFFFFFFF";
    }
    return int.parse(hexColor, radix: 16);
  }

  /// Returns a [Color] objects converted using the
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

extension ColorUtility on Color {
  /// Desaturates the [Color] by the provided [alpha] value.
  ///
  /// An [alpha] value of [0.75] would decrease the saturation by 25%.
  Color desat(double alpha) {
    Color c = this;
    int a = (c.alpha * alpha).floor();
    int r = c.red;
    int g = c.green;
    int b = c.blue;
    return Color.fromARGB(a, r, g, b);
  }

  /// Returns one of the provided text colors (light and dark colors) based on
  /// the contrast each of these colors would result in if applied on in front
  /// of the main [Color].
  Color applyColorByContrast(Color light, Color dark) {
    /// The factor constant which is used to calculate the luminance.
    ///
    /// This value is generally set to `0.05` but will be `0.10` to
    /// allow the dark text styling to be more present.
    double factor = 0.10;
    double luminanceUserColor = this.computeLuminance();
    double luminanceTextLight = light.computeLuminance();
    double luminacneTextDark = dark.computeLuminance();
    double maxLumLight = math.max(luminanceUserColor, luminanceTextLight);
    double minLumLight = math.min(luminanceUserColor, luminanceTextLight);
    double maxLumDark = math.max(luminanceUserColor, luminacneTextDark);
    double minLumDark = math.min(luminanceUserColor, luminacneTextDark);
    double contrastLight = (maxLumLight + factor / minLumLight + factor);
    double contrastDark = (maxLumDark + factor / minLumDark + factor);
    Color textColor = (contrastDark > contrastLight) ? dark : light;
    return textColor;
  }
}
