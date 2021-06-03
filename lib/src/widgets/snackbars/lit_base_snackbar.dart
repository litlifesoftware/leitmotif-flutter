import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// An animated [LitSnackbar] positioned using the provided [Alignment]
/// on the [LitScaffold].
///
/// Use this [LitSnackbar] to customize the styling of your snackbar and
/// to display the provided child [Widget] inside the [LitSnackbar].
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
  /// Displaying the provided [child] widget.

  const LitBaseSnackbar({
    Key? key,
    required this.snackBarController,
    this.width = 200.0,
    this.height = 80.0,
    required this.child,
    this.alignment = Alignment.topRight,
    this.padding = const EdgeInsets.symmetric(
      vertical: 32.0,
    ),
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(15.0),
      bottomLeft: Radius.circular(15.0),
      bottomRight: Radius.circular(15.0),
      topRight: Radius.circular(15.0),
    ),
    this.backgroundGradient = const LinearGradient(
      colors: const [
        Color(0xFFFFFFFF),
        Color(0xFFF8F8F8),
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: const [0.2, 0.7],
    ),
    this.boxShadow = const [
      const BoxShadow(
        blurRadius: 8.0,
        color: Colors.black26,
        offset: Offset(-3.0, 3.0),
        spreadRadius: -1.0,
      )
    ],
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
                onTap: () {
                  widget.snackBarController.dismissSnackBar();
                },
                child: SizedBox(
                  /// Specify the height of the snack bar.
                  height: widget.height,

                  /// Set the width of the snackbar to the provided
                  /// width. It must be equal to the transform
                  /// value in order to be fully transformed back
                  /// and forth.
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
