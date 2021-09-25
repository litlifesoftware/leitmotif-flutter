import 'package:flutter/material.dart';

/// A collection of [BoxShadow] objects that can be used as decoration.
class LitBoxShadows {
  /// A [BoxShadow] that can be applied on smaller elements.
  static const List<BoxShadow> xs = const [
    const BoxShadow(
      offset: Offset(-1.0, 1.0),
      blurRadius: 3.0,
      color: Colors.black26,
      spreadRadius: -1.0,
    )
  ];

  /// A [BoxShadow] that can be applied on smaller elements.
  static const List<BoxShadow> sm = const [
    const BoxShadow(
      offset: Offset(-2.0, 2.0),
      blurRadius: 4.0,
      color: Colors.black26,
      spreadRadius: -1.0,
    )
  ];

  /// A [BoxShadow] that can be applied on medium-sized elements.
  static const List<BoxShadow> md = const [
    const BoxShadow(
      offset: Offset(-3.0, 3.0),
      blurRadius: 4.0,
      color: Colors.black38,
      spreadRadius: -2.0,
    )
  ];

  /// A [BoxShadow] that can be applied on larger elements.
  static const List<BoxShadow> lg = const [
    const BoxShadow(
      offset: Offset(-4.0, 4.0),
      blurRadius: 6.0,
      color: Colors.black38,
      spreadRadius: -2.0,
    )
  ];

  /// A [BoxShadow] that can be applied on smaller text elements.
  static const List<BoxShadow> textSm = const [
    BoxShadow(
      offset: Offset(1.0, 1.0),
      color: Colors.black12,
      blurRadius: 4.0,
    )
  ];

  /// A [BoxShadow] that can be applied on medium-sized text elements.
  static const List<BoxShadow> textMd = const [
    BoxShadow(
      offset: Offset(2.0, 2.0),
      color: Colors.black12,
      blurRadius: 4.0,
    )
  ];

  /// A [BoxShadow] that can be applied on larger text elements.
  static const List<BoxShadow> textLg = const [
    BoxShadow(
      offset: Offset(3.0, 3.0),
      color: Colors.black12,
      blurRadius: 4.0,
    )
  ];
}
