import 'package:flutter/widgets.dart';

class FadeInTransformContainer extends StatelessWidget {
  final AnimationController animationController;
  final Matrix4 transform;
  final Widget child;

  const FadeInTransformContainer({
    Key key,
    @required this.animationController,
    @required this.child,
    @required this.transform,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 0.5 + (0.5 * animationController.value),
      duration: animationController.duration,
      child: Transform(
        transform: transform,
        child: child,
      ),
    );
  }
}
