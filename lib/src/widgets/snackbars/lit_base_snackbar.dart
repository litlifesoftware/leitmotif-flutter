import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// An animated [LitSnackbar] positioned using the provided [Alignment].
///
/// The default [LitSnackbar] implementation.
class LitBaseSnackbar extends StatefulWidget implements LitSnackbar {
  final LitSnackbarController snackBarController;

  /// The total width of the [LitBaseSnackbar].
  final double width;

  /// The total height of the [LitBaseSnackbar].
  final double height;

  /// The widget that should be displayed on the snack bar.
  final Widget child;

  /// The placement of the [LitSnackbar] (defaults to [Alignment.topRight]).
  final Alignment alignment;

  /// The padding applied to the [child].
  final EdgeInsets padding;

  /// The [BorderRadius] on the parent [Container].
  final BorderRadius borderRadius;

  /// The background will be compound of the [LinearGradient].
  final LinearGradient backgroundGradient;

  /// The snackbar's box shadow
  final List<BoxShadow> boxShadow;

  /// Creates a [LitBaseSnackbar].
  ///
  /// The default [LitBaseSnackbar] will have a solid background displaying the
  /// provided [child].

  const LitBaseSnackbar({
    Key? key,
    required this.snackBarController,
    this.width = LitSnackbar.defaultWidth,
    this.height = LitSnackbar.defaultHeight,
    this.alignment = LitSnackbar.defaultAlignment,
    this.padding = LitSnackbar.defaultPadding,
    this.borderRadius = LitSnackbar.defaultBorderRadius,
    this.backgroundGradient = LitSnackbar.defaultSolidGradientBackground,
    this.boxShadow = LitSnackbar.defaultBoxShadow,
    required this.child,
  }) : super(key: key);

  @override
  LitSnackbarController? get controller => this.snackBarController;
  @override
  _LitBaseSnackbarState createState() => _LitBaseSnackbarState();
}

class _LitBaseSnackbarState extends State<LitBaseSnackbar> {
  /// Returns the [LitSnackbarController]'s animation value.
  AnimationController get _snackbarAnimation {
    return widget.snackBarController.animationController;
  }

  /// Returns the snackbar's transformation, which is based on the current
  /// animation value.
  ///
  /// In order for the snack bar to be displayed outside the rendered screen
  /// content, transform it into outside the screen content using the
  /// provided [width] value and the provided vertical padding.
  Matrix4 get _transformMatrix {
    double xTransform =
        widget.width + widget.padding.right + widget.padding.left;
    return Matrix4.translationValues(
      (xTransform * (1.0 - _snackbarAnimation.value)),
      0,
      0,
    );
  }

  /// Dismisses the snackbar.
  void _dismiss() {
    widget.snackBarController.dismissSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _snackbarAnimation,
      builder: (BuildContext context, Widget? _) {
        return Align(
          alignment: widget.alignment,
          child: Padding(
            padding: widget.padding,
            child: Transform(
              transform: _transformMatrix,
              child: InkWell(
                borderRadius: widget.borderRadius,
                onTap: _dismiss,
                child: SizedBox(
                  height: widget.height,
                  width: widget.width,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: widget.borderRadius,
                      gradient: widget.backgroundGradient,
                      boxShadow: widget.boxShadow,
                    ),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
