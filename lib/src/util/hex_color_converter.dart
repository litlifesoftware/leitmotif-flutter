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
