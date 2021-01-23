import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// An animated [LitSnackbar] positioned using the provided [Alignment]
/// on the [LitScaffold].
///
/// Use this [LitSnackbar] to customize the styling of your snackbar and
/// to display the provided child [Widget] inside the [LitSnackbar].
class SlidingSnackbar extends StatelessWidget implements LitSnackbar {
  final LitSnackbarController customSnackBarController;

  /// The total width of the [SlidingSnackbar].
  final double width;

  /// The total height of the [SlidingSnackbar].
  final double height;

  /// The widget that should be displayed on the snack bar.
  final Widget child;

  /// The placement of the [LitSnackbar] (defaults to [Alignment.topRight]).
  final Alignment alignment;

  /// The padding applied to the [child].
  final EdgeInsets padding;

  /// The [BorderRadius] on the parent [Container].
  final BorderRadius borderRadius;

  /// Creates a [SlidingSnackbar].
  ///
  /// Displaying the provided [child] widget.

  const SlidingSnackbar({
    Key key,
    @required this.customSnackBarController,
    this.width = 200.0,
    this.height = 80.0,
    @required this.child,
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
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: customSnackBarController.animationController,
      builder: (BuildContext context, Widget widget) {
        return Align(
          alignment: alignment,
          child: Padding(
            padding: padding,
            child: Transform(
              transform: Matrix4.translationValues(

                  /// In order for the snack bar to be displayed
                  /// outside the rendered screen content, transform
                  /// it into outside the screen content using the
                  /// provided [width] value and the provided vertical
                  /// padding.

                  ((width + (padding.right + padding.left)) *
                      (1 - customSnackBarController.animationController.value)),
                  0,
                  0),
              child: InkWell(
                onTap: () {
                  customSnackBarController.dismissSnackBar();
                },
                child: SizedBox(
                  /// Specify the height of the snack bar.
                  height: height,

                  /// Set the width of the snackbar to the provided
                  /// width. It must be equal to the transform
                  /// value in order to be fully transformed back
                  /// and forth.
                  width: width,
                  child: ClipRRect(
                    /// The Border radius must be set on both
                    /// the wrapping ClipRRect and its child
                    /// Container widget in order to be applied
                    /// on the effect an on the content.
                    borderRadius: borderRadius,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: borderRadius,
                            gradient: LinearGradient(
                                colors: [
                                  Colors.grey[300].withOpacity(0.4),
                                  Colors.grey[100].withOpacity(0.3),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [0.2, 0.7])),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  LitSnackbarController get controller => this.customSnackBarController;
}
