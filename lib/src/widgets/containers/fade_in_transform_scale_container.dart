import 'package:flutter/widgets.dart';

class FadeInTransformScaleContainer extends StatelessWidget {
  final AnimationController animationController;
  final Widget child;
  final Matrix4 transform;
  final double scale;

  const FadeInTransformScaleContainer({
    Key key,
    @required this.animationController,
    @required this.transform,
    @required this.scale,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 0.5 + (0.5 * animationController.value),
      duration: animationController.duration,
      child: Transform(
        transform: transform,
        child: Transform.scale(
          scale: scale,
          child: child,
        ),
      ),
    );
  }
}
