import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:lit_ui_kit/snackbars.dart';

/// An animated [LitSnackbar] positioned using the provided [Alignment].
///
/// A transparent [LitSnackbar] implementation.
class LitTransparentSnackbar extends StatefulWidget implements LitSnackbar {
  /// The controller containing the show/dismiss logic.
  final LitSnackbarController snackBarController;

  /// The total width of the [LitBaseSnackbar].
  final double width;

  /// The total height of the [LitBaseSnackbar].
  final double height;

  /// The placement of the [LitSnackbar] (defaults to [Alignment.topRight]).
  final Alignment alignment;

  /// The padding applied to the [child].
  final EdgeInsets padding;

  /// The [BorderRadius] on the parent [Container].
  final BorderRadius borderRadius;

  final LinearGradient backgroundGradient;

  /// The widget that should be displayed on the snack bar.
  final Widget child;

  /// Creates a [LitTransparentSnackbar].
  ///
  /// Provide a controller and a [child] widget.
  const LitTransparentSnackbar({
    Key? key,
    required this.snackBarController,
    this.width = LitSnackbar.defaultWidth,
    this.height = LitSnackbar.defaultHeight,
    this.alignment = Alignment.topRight,
    this.padding = LitSnackbar.defaultPadding,
    this.borderRadius = LitSnackbar.defaultBorderRadius,
    this.backgroundGradient = LitSnackbar.defaultTransparentGradientBackground,
    required this.child,
  }) : super(key: key);

  @override
  _LitTransparentSnackbarState createState() => _LitTransparentSnackbarState();

  @override
  LitSnackbarController? get controller => this.snackBarController;
}

class _LitTransparentSnackbarState extends State<LitTransparentSnackbar> {
  /// Returns the sigma value required to apply a blur filter.
  double get _blur {
    return 6.0;
  }

  @override
  Widget build(BuildContext context) {
    return LitBaseSnackbar(
      snackBarController: widget.snackBarController,
      height: widget.height,
      width: widget.width,
      boxShadow: const [],
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          color: Colors.white24,
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: BluredBackgroundContainer(
            borderRadius: widget.borderRadius,
            child: widget.child,
            blurRadius: _blur,
          ),
        );
      }),
      backgroundGradient: widget.backgroundGradient,
    );
  }
}
