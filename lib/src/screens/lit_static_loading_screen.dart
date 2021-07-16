import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A screen widgets displayed a static loading indicator.
///
/// On some fetch-events, dynamic loading indicators are not always recommended.
/// For instance, a short initialization process on a app startup does not allow
/// to display a long-lasting animation.
class LitStaticLoadingScreen extends StatelessWidget {
  /// Creates a [LoadingScreen].
  const LitStaticLoadingScreen({
    this.child = const LitInfoIcon(),
    Key? key,
  }) : super(key: key);

  /// The screen's child element. This should optimally be a art widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: const [
              LitColors.mediumGrey,
              LitColors.darkBlue,
            ],
          ),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
