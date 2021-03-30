import 'package:flutter/material.dart';

class LitToggleButton extends StatefulWidget {
  final void Function(bool) toggleCallback;
  final bool toggledValue;
  final Color activeColor;
  final Color inactiveColor;
  const LitToggleButton({
    Key? key,
    required this.toggleCallback,
    required this.toggledValue,
    required this.activeColor,
    required this.inactiveColor,
  }) : super(key: key);

  @override
  _LitToggleButtonState createState() => _LitToggleButtonState();
}

class _LitToggleButtonState extends State<LitToggleButton>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25.0),
      onTap: () {
        if (!animationController.isAnimating) {
          widget.toggledValue
              ? animationController
                  .reverse()
                  .then((value) => widget.toggleCallback(!widget.toggledValue))
              : animationController
                  .forward()
                  .then((value) => widget.toggleCallback(!widget.toggledValue));
        }
      },
      child: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) {
            return Container(
              width: 60,
              height: 30,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  AspectRatio(
                    aspectRatio: 2.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.lerp(widget.inactiveColor,
                            widget.activeColor, animationController.value),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: Transform(
                      transform: Matrix4.translationValues(
                          (animationController.value) * 30, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(-2, -2),
                              blurRadius: 15.0,
                              spreadRadius: 2,
                            )
                          ],
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
