import 'package:flutter/material.dart';

class LitRoundedOutlinedButton extends StatelessWidget {
  final Color borderColor;
  final Widget child;
  final void Function() onPressed;
  final double radius;
  final double strokeWidth;

  /// Creates a [RoundedBordedButton].
  ///
  /// The button will surround the provided child [Widget] using
  /// a [Border]. Its color is set by the corresponding [borderColor]
  /// parameter value.
  /// Its [BorderRadius] is set by default to have a radius of
  /// 25.0 pixels.
  const LitRoundedOutlinedButton({
    Key key,
    @required this.borderColor,
    @required this.child,
    @required this.onPressed,
    this.radius = 25.0,
    this.strokeWidth = 4.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: borderColor,
            width: strokeWidth,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 12.0,
          ),
          child: child,
        ),
      ),
    );
  }
}
