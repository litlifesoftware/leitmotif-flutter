import 'package:flutter/material.dart';

/// A scrollbar widget providing an interactive scrollbar on it's child widget.
///
/// The default [Material] [Scrollbar] is slightly customized to provide a
/// consistant styling across all instances.
///
/// {@macro flutter.widgets.Scrollbar}
class LitScrollbar extends StatelessWidget {
  final Widget child;
  final ScrollController? scrollController;
  final double thickness;
  final Radius radius;

  /// Creates a [LitScrollbar].
  ///
  /// * [child] is the child that the scrollbar will be wrapping.
  ///
  /// * [scrollController] is the scroll controller to bind the scrollbar on.
  ///
  /// * [thickness] is the width of the scrollbar.
  ///
  /// * [radius] is the border radius of scrollbar.
  const LitScrollbar({
    Key? key,
    required this.child,
    this.scrollController,
    this.thickness = 8.0,
    this.radius = const Radius.circular(4.0),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: thickness,
      child: child,
      controller: scrollController,
      isAlwaysShown: false,
      radius: radius,
    );
  }
}
