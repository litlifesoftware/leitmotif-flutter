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

  /// Returns either one of the of the provided text colors (`light` or
  /// `dark` color) based on the contrast each of these colors would result
  /// in when placed in from of `this` color.
  ///
  /// Use this method to avoid unreadable text colors.
  Color applyColorByContrast(Color light, Color dark) {
    return this.computeLuminance() >= 0.5 ? dark : light;
  }
}
