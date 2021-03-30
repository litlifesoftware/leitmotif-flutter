import 'package:flutter/material.dart';

class LitRoundedFlatButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final void Function() onPressed;
  final double radius;
  final EdgeInsets padding;

  /// Creates a [LitRoundedFlatButton].
  ///
  /// The button will highlight the provided child [Widget] using
  /// the corresponding [color] parameter value.
  /// Its [BorderRadius] is set by default to have a radius of
  /// 25.0 pixels.
  const LitRoundedFlatButton({
    Key? key,
    required this.color,
    required this.child,
    required this.onPressed,
    this.radius = 25.0,
    this.padding = const EdgeInsets.symmetric(
      vertical: 4.0,
      horizontal: 12.0,
    ),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
