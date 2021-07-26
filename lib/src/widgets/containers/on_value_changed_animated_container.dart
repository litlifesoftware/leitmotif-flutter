import 'package:flutter/widgets.dart';
import 'package:leitmotif/leitmotif.dart';

class OnValueChangedAnimatedContainer extends StatefulWidget {
  final Widget child;
  final BoxDecoration decoration;
  final Duration? duration;
  final bool? shouldAnimate;
  final void Function(bool) toggleShouldAnimate;
  const OnValueChangedAnimatedContainer({
    Key? key,
    required this.shouldAnimate,
    required this.child,
    required this.decoration,
    required this.duration,
    required this.toggleShouldAnimate,
  }) : super(key: key);
  @override
  _OnValueChangedAnimatedContainerState createState() =>
      _OnValueChangedAnimatedContainerState();
}

class _OnValueChangedAnimatedContainerState
    extends State<OnValueChangedAnimatedContainer>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  /// Animates the label [Widget] displaying the currently selected month.
  void _animateOnChange() {
    if (widget.shouldAnimate!) {
      _animationController!
          .reverse()
          .then((value) => widget.toggleShouldAnimate(!widget.shouldAnimate!))
          .then((value) => {_animationController!.forward(from: 0.0)});
    }
  }

  /// Initializes the [AnimationController] objects.
  ///
  /// The [Duration] will be set to the provided parents' [Duration].
  /// Note that the [Animation] will be played twice. This will double
  /// the total animation playtime.
  void _initAnimations() {
    _animationController = AnimationController(
      duration: (widget.duration),
      vsync: this,
    );
    _animationController!.forward();
  }

  void _disposeAnimations() {
    _animationController!.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  @override
  void dispose() {
    _disposeAnimations();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController!,
        builder: (BuildContext context, Widget? _) {
          _animateOnChange();
          return FadeInTransformScaleContainer(
            animationController: _animationController,
            scale: 1 - (_animationController!.value * 0.06125),
            transform: Matrix4.translationValues(
                0, -5 + (5 * _animationController!.value), 0),
            child: Container(
              decoration: widget.decoration,
              child: widget.child,
            ),
          );
        });
  }
}
