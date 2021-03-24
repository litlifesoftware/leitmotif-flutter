import 'package:flutter/widgets.dart';

/// A controller playing animations triggered by scrolling.
///
/// If the [ScrollController] has registered an [Offset] change, the animation
/// will be played forward or in reverse. The required [AnimationController]
/// will be declared as a property and is initialized by calling the
/// [AnimationOnScrollController] constructor. The listener will then be attached
/// on the animation controller.
class AnimationOnScrollController {
  /// The [ScrollController] of the widgets on which the animation on scroll
  /// should be played.
  final ScrollController scrollController;

  /// The direction in which the animation should be played.
  final AnimationDirection direction;

  /// The required offset to trigger the animation.
  final double requiredScrollOffset;

  /// The Ticker required for the [AnimationController].
  final TickerProvider vsync;

  /// The duration the animation should last.
  final Duration animationDuration;

  /// Creates an [AnimationOnScrollController].
  ///
  /// * [scrollController] obtains the current scroll offset.
  ///
  /// * [direction] is the direction in which the animation is played.
  ///
  /// * [requiredScrollOffset] is the offset required to trigger the animation.
  ///
  /// * [vsync] provides access to the current [TickerProvider] to initialize
  ///   the [AnimationController].
  ///
  /// * [animationDuration] will determine the length the animation should have.
  ///
  /// {@tool snippet}
  /// The [AnimationOnScrollController] needs to be initialized on a [StatefulWidget].
  /// This can be achieved by initializing the declared object in the [State.initState]
  /// method as stated below:
  /// ```dart
  /// _animationOnScrollController = AnimationOnScrollController(
  ///   scrollController: _scrollController,
  ///   vsync: this,
  /// );
  /// ```
  /// {@end-tool}
  ///
  /// {@tool snippet}
  /// The [AnimationOnScrollController] should also be disposed by overriding the
  /// [State.dispose] method as stated below:
  /// ```dart
  ///  _animationOnScrollController.dispose();
  /// ```
  /// {@end-tool}
  AnimationOnScrollController({
    @required this.scrollController,
    this.direction = AnimationDirection.forward,
    this.requiredScrollOffset = 32.0,
    @required this.vsync,
    this.animationDuration = const Duration(milliseconds: 130),
  }) {
    _initAnimation();
    _attach();
  }

  /// The animation controller required to play the animation.
  AnimationController animationController;

  /// Plays the [Animation] forward.
  void _show() {
    if (!animationController.isAnimating) {
      print("show");
      if (direction == AnimationDirection.forward) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }
  }

  /// Plays the [Animation] in reverse.
  void _hide() {
    if (!animationController.isAnimating) {
      if (direction == AnimationDirection.forward) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
    }
  }

  /// Plays the animation forward or in reverse depending on the current scroll offset
  /// provided by the [ScrollController]. The animation will only be played if the user
  /// is scrolling in the same direction and only if the previous animation has been
  /// finished playing using the [ScrollController.keepScrollOffset] property.
  void _animateOnScroll() {
    if (scrollController.keepScrollOffset) {
      if (scrollController.offset > requiredScrollOffset) {
        _show();
      } else if (scrollController.offset > 0 &&
          scrollController.offset <= requiredScrollOffset) {
        _hide();
      } else if (scrollController.offset <= 0) {
        _hide();
      }
    }
  }

  /// Initializes the local [AnimationController] instance.
  void _initAnimation() {
    animationController = AnimationController(
        vsync: this.vsync, duration: this.animationDuration);
  }

  /// Attaches the [_animateOnScroll] listener to the provided [ScrollController].
  void _attach() {
    scrollController.addListener(_animateOnScroll);
  }

  /// Disposes the [AnimationController].
  void dispose() {
    animationController.dispose();
  }
}

/// A List of available animation directions.
enum AnimationDirection {
  forward,
  reverse,
}
