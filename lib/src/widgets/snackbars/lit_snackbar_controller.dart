import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A controller to handle animations on [LitSnackbar] widgets.
///
/// Each [LitSnackbar] is required to have a [LitSnackbarController] in order
/// to perform the animation, which will slide in and out the [LitSnackbar]
/// using the [showSnackBar] method.
///
/// To use [LitSnackbar]s outside the [LitScaffold], their controller class
/// should be initialized by excuting the [LitSnackbarController]'s [init]
/// method.
///
class LitSnackbarController {
  /// The [AnimationController]' duration.
  final Duration animationDuration;

  /// The duration the snackbar should be displayed.
  final Duration displayDuration;

  /// The behavior of the snackbar's animation.
  final SnackbarAnimationType animationType;

  /// The [AnimationController] necessary to animate the [LitSnackbar].
  late AnimationController animationController;

  /// Creates a new controller for a [LitSnackbar].
  ///
  /// *  [animationDuration] is the animation's duration.
  ///
  /// * [displayDuration] is the duration a snackbar should be display on the
  ///   screen.
  ///
  /// * [animationType] describes how the animation should behave.
  ///
  /// {@tool snippet}
  /// Alternativly the [init] method could be executed on the
  /// [LitSnackbarController]'s initialization inside the [State.initState]
  /// method like stated below:
  /// ```dart
  /// _customSnackBarController = LitSnackbarController()..init(this);
  /// ```
  /// {@end-tool}
  LitSnackbarController({
    this.animationDuration = const Duration(
      milliseconds: 350,
    ),
    this.displayDuration = const Duration(milliseconds: 3500),
    this.animationType = SnackbarAnimationType.rightToLeft,
  });

  /// Initalizes the [AnimationController] by passing the provided
  /// [TickerProvider].
  void init(TickerProvider vsync) {
    animationController = AnimationController(
      vsync: vsync,
      duration: animationDuration,
    );
  }

  /// Dispose this [LitSnackbarController].
  ///
  /// The [AnimationController] of this [LitSnackbarController] will be dispose
  /// to ensure no [TickerProvider] leak will occur.  Call this method on the
  /// [StatefulWidget] by overriding its dispose method.
  void dispose() {
    animationController.dispose();
  }

  /// Slides in the [LitSnackbar] by playing the [AnimationController]'s
  /// animation. It will then either play the reverse animation after the
  /// forward animation completed, or it will just stay at the
  /// 'animation complete' state to be disposed otherwise.
  ///
  /// First play the animation forward from the beginning, pause it for a
  /// specific [Duration] and try to play the animation in reverse, if the
  /// previous one has been completed. In case of a disposal of the
  /// [AnimationController] during the method execution, an exception will be
  /// caught.
  Future<void> showSnackBar({bool reverseAnimation = true}) {
    return animationController.forward(from: 0).then(
      (value) {
        return Future.delayed(displayDuration, () {
          try {
            if (reverseAnimation) {
              if (animationController.status == AnimationStatus.completed) {
                animationController.reverse();
              }
            }
          } catch (e) {
            _throwError();
          }
        }).then((value) => _callListerns());
      },
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
        _throwError();
      }
    }
  }

  /// Print the error text if there has been an error while playing the
  /// animation.
  void _throwError() {
    throw Exception(
      [
        "Error while playing the animation on the LitSnackbar. Have you " +
            "called snackbar after disposing its controller?"
      ],
    );
  }

  /// A list currently added listeners.
  List<Function> _listeners = [];

  /// Calls all provided listeners one by one.
  void _callListerns() {
    for (Function func in _listeners) {
      func();
    }
  }

  /// Adds a listener to the panel.
  ///
  /// Each action ([dismissSettingsPanel],[showSettingsPanel]) will trigger the
  /// provided callbacks.
  void addListener(void Function() func) {
    _listeners.add(func);
  }
}

/// Available types of [LitSnackbar] animations.
///
/// Each animation will behave differently.
enum SnackbarAnimationType {
  rightToLeft,
  topToBottom,
  bottomToTop,
}
