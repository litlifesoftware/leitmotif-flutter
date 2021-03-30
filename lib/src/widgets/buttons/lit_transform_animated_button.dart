import 'dart:ui';
import 'package:flutter/material.dart';

class LitTransformAnimatedButton extends StatefulWidget {
  final Widget child;
  final void Function() onTap;
  final Color backgroundColor;
  final double verticalTransform;
  final double horizontalTransform;

  /// Creates a [TransformAnimationButton].
  ///
  /// The provided child [Widget] will be wrapped inside a
  /// styled and transformed button. Its [Animation] will be
  /// handled using its own [State] and [AnimationController].
  const LitTransformAnimatedButton({
    Key? key,
    required this.child,
    required this.onTap,
    required this.backgroundColor,
    required this.verticalTransform,
    required this.horizontalTransform,
  }) : super(key: key);
  @override
  _LitTransformAnimatedButtonState createState() =>
      _LitTransformAnimatedButtonState();
}

class _LitTransformAnimatedButtonState extends State<LitTransformAnimatedButton>
    with TickerProviderStateMixin {
  late AnimationController _buttonAnimationController;

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1000,
      ),
    );
    _buttonAnimationController.repeat(
      reverse: true,
    );
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _buttonAnimationController,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(
            1 - _buttonAnimationController.value * widget.horizontalTransform,
            1 - _buttonAnimationController.value * widget.verticalTransform,
            0,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 3,
                sigmaY: 3,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: widget.onTap,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: widget.backgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
