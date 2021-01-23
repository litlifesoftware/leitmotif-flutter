import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// Creates a new controller for a [LitSnackbar].
///
/// Each [LitSnackbar] is required to have a [LitSnackbarController] in order
/// to perform the animation, which will slide in and out the [LitSnackbar]
/// using the [showSnackBar] method.
///
/// To use [LitSnackbar]s outside the [LitScaffold], their controller class
/// should be initialized by excuting the [LitSnackbarController]'s [init] method.
///
/// {@tool snippet}
/// Alternativly the [init] method could be executed on the [LitSnackbarController]'s
/// initialization inside the [State.initState] method like stated below:
/// ```dart
///  _customSnackBarController = _customSnackBarController = LitSnackbarController()..init(this);
/// ```
/// {@end-tool}
///
class LitSnackbarController {
  /// The [AnimationController] necessary to animate the [LitSnackbar].
  AnimationController animationController;

  /// Initalizes the [AnimationController] by passing the provided [TickerProvider].
  void init(TickerProvider vsync) {
    animationController = AnimationController(
        vsync: vsync,
        duration: Duration(
          milliseconds: 350,
        ));
  }

  /// Dispose this [LitSnackbarController].
  ///
  /// The [AnimationController] of this [LitSnackbarController] will be dispose to
  /// ensure no [TickerProvider] leak will occur.  Call this method on the [StatefulWidget]
  /// by overriding its dispose method.
  void dispose() {
    animationController.dispose();
  }

  /// Slides in the [LitSnackbar] by playing the [AnimationController]'s animation methods
  /// after each other. First play the animation forward from the beginning, pause it for
  /// a specific [Duration] and try to play the animation in reverse, if the previous one
  /// has been completed. In case of a disposal of the [AnimationController] during the
  /// method execution, an exception will be caught.
  void showSnackBar() {
    animationController.forward(from: 0).then(
          (value) => Future.delayed(Duration(milliseconds: 3500), () {
            try {
              if (animationController.status == AnimationStatus.completed) {
                animationController.reverse();
              }
            } catch (e) {
              _catchError();
            }
          }),
        );
  }

  /// Dismisses the [LitSnackbar].
  ///
  /// The animation will be played back the animation in reverse.
  void dismissSnackBar() {
    if (!animationController.isAnimating) {
      try {
        animationController.reverse(from: 1.0);
      } catch (e) {
        _catchError();
      }
    }
  }

  /// Print the error text if there has been an error while playing the
  /// animation.
  void _catchError() {
    throw Exception(
        ["Error while playing the animation on the CustomSnackBar"]);
  }
}
