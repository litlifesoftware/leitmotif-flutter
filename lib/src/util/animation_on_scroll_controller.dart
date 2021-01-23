import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

/// A controller class which will enable the provided [AnimationController]
/// to be played if the [ScrollController] has registered an [Offset] change.
class AnimationOnScrollController {
  /// The [ScrollController] must be accesible in the widget on which the
  /// animation should be display in order to reference it create a reference
  /// on the scrollable widget.
  final ScrollController scrollController;
  final AnimationDirection direction;
  final double maxScrollOffset;

  /// Creates an [AnimationOnScrollController].
  ///
  /// Ensure the listener is attached to the provided [ScrollController] and
  /// that the [AnimationController] is initialized in order for the [Animation] to
  /// be played. This requires the [TickerProviderStateMixin] to be implemented in the
  /// [StatefulWidget].
  ///
  /// {@tool snippet}
  /// The [AnimationOnScrollController] can not be initialized in the [LitScaffold]
  /// because the [scrollController] property must remain accessible the the child
  /// widget. Therefore this controller should be initialized in the child widget.
  /// This can be achieved by calling [attach] in the overriden [State.initState]
  /// method as stated below:
  /// ```dart
  ///  _animationOnScrollController = AnimationOnScrollController(
  ///    scrollController: _scrollController,
  ///    maxScrollOffset: 16.0,
  ///    direction: AnimationDirection.forward,
  ///  )..attach(this);
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
    @required this.maxScrollOffset,
  });

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

  /// Plays the [Animation] forward or in reverse depending on the current scroll offset
  /// provided by the [ScrollController].
  ///
  /// The [Animation] will only be played if the user is scrolling in the same direction
  /// and only if the previous [Animation] has been finished playing using the
  /// [ScrollController.keepScrollOffset] property.
  void _animateOnScroll() {
    if (scrollController.keepScrollOffset) {
      if (scrollController.offset > maxScrollOffset) {
        _show();
      } else if (scrollController.offset > 0 &&
          scrollController.offset <= maxScrollOffset) {
        _hide();
      } else if (scrollController.offset <= 0) {
        _hide();
      }
    }
  }

  /// Attaches the [_animateOnScroll] listener to the provided [ScrollController].
  void attach(TickerProvider vsync) {
    animationController = AnimationController(
        vsync: vsync, duration: Duration(milliseconds: 130));
    scrollController.addListener(_animateOnScroll);
  }

  /// Disposes the [AnimationController].
  void dispose() {
    animationController.dispose();
  }
}

/// A List of possible [Animation] directions.
enum AnimationDirection {
  forward,
  reverse,
}
