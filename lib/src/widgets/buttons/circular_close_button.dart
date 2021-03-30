import 'package:flutter/material.dart';

/// A circular button, which can be pressed in order to remove a widget route
/// from the stack or to remove a certain widget from the visible area.
class CircularCloseButton extends StatelessWidget {
  final void Function() onPressed;
  final Color borderColor;
  final Color? color;

  /// Create a [CircularCloseButton].
  ///
  /// Pass an [onPressed] method to implement the functionality.
  const CircularCloseButton({
    Key? key,
    required this.onPressed,
    required this.borderColor,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          height: 24.0,
          width: 24.0,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: borderColor,
                      width: 2.0,
                    ),
                    color: color,
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
