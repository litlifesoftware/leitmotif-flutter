import 'package:flutter/material.dart';

/// A stripped out transparent [InkWell] to hide the default Material's InkWell appearance.
class CleanInkWell extends StatelessWidget {
  final BorderRadius borderRadius;
  final Widget child;
  final void Function() onTap;

  /// Creates a [CleanInkWell].
  ///
  /// This widget can eg. be used to implement an inkwell defocussing the currently focused
  /// text input. This can be used to hide the soft keyboard without any visual feedback.
  const CleanInkWell({
    Key? key,
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(0.0)),
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      borderRadius: borderRadius,
      onTap: onTap,
      child: child,
    );
  }
}
