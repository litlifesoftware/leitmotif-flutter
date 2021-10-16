import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `screen` widget displaying a fullscreen loading indicator.
///
/// Suitable for major fetching or loading processes.
class LitStaticLoadingScreen extends StatelessWidget {
  /// The background's decoration.
  final BoxDecoration decoration;

  /// The screen's child element.
  final Widget child;

  /// Creates a [LitStaticLoadingScreen].
  const LitStaticLoadingScreen({
    this.decoration = const BoxDecoration(
      gradient: LitGradients.dark,
    ),
    this.child = const LitInfoIcon(),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: decoration,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
