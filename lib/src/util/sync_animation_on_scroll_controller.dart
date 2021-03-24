import 'package:flutter/widgets.dart';

/// A controller syncing the current scroll controller state onto an animation
/// controller.
///
/// If the [ScrollController] has registered an [Offset] change, the animation
/// will change its value. The required [AnimationController] will be declared
/// as a property and is initialized by calling the
/// [SyncAnimationOnScrollController] constructor. The listener will then be
/// attached on the animation controller.
class SyncAnimationOnScrollController {
  /// The [ScrollController] of the widget on which the animation should be
  /// syned with.
  final ScrollController scrollController;

  /// The Ticker required for the [AnimationController].
  final TickerProvider vsync;

  /// The duration the animation should last.
  final Duration animationDuration;

  /// The total scrollable area available.
  final double totalScrollOffset;

  /// Creates a [SyncAnimationOnScrollController].
  ///
  /// * [scrollController] obtains the current scroll offset.
  ///
  /// * [vsync] provides access to the current [TickerProvider] to initialize
  ///   the [AnimationController].
  ///
  /// * [animationDuration] will determine the length the animation should have.
  ///
  /// {@tool snippet}
  /// The [SyncAnimationOnScrollController] needs to be initialized on a
  /// [StatefulWidget]. This can be achieved by initializing the declared object
  /// in the [State.initState] method as stated below:
  /// ```dart
  ///  _syncAnimationOnScrollController = SyncAnimationOnScrollController(
  ///    scrollController: _scrollController,
  ///    vsync: this,
  ///  );
  /// ```
  /// {@end-tool}
  ///
  /// {@tool snippet}
  /// The [SyncAnimationOnScrollController] should also be disposed by overriding
  /// the [State.dispose] method as stated below:
  /// ```dart
  ///  _syncAnimationOnScrollController.dispose();
  /// ```
  /// {@end-tool}
  SyncAnimationOnScrollController({
    @required this.scrollController,
    @required this.vsync,
    this.animationDuration = const Duration(milliseconds: 130),
    this.totalScrollOffset = 100.0,
  }) {
    _initAnimation();
    _attach();
  }

  /// The animation controller required to play the animation.
  AnimationController animationController;

  /// Returns the currently scrolled offset.
  double get _scrollOffset {
    return scrollController.offset;
  }

  /// Returns the total scrollable area.
  double get _totalOffset {
    return totalScrollOffset;
  }

  /// Initializes the local [AnimationController] instance.
  void _initAnimation() {
    animationController = AnimationController(
        vsync: this.vsync, duration: this.animationDuration);
  }

  /// Attaches the [_animateOnScroll] listener to the provided [ScrollController].
  void _attach() {
    scrollController.addListener(_syncOnScroll);
  }

  /// Syncs the [animationController.value] to the current scroll state. As long
  /// as the maximum scrollable area has not been reached yet, the animation will
  /// be carried on. If the scrollable area has been exceeded or reached, the
  /// animation is completed.
  void _syncOnScroll() {
    scrollController.addListener(
      () {
        if (_scrollOffset <= _totalOffset) {
          animationController.value = (_scrollOffset / _totalOffset);
        } else if (_scrollOffset < 0) {
          animationController.value = 0.0;
        } else if (_scrollOffset > 0 && _scrollOffset < _totalOffset) {
          animationController.value = (_scrollOffset / _totalOffset);
        }
      },
    );
  }

  /// Disposes the [AnimationController].
  void dispose() {
    animationController.dispose();
  }
}
