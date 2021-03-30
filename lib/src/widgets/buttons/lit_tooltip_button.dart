import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A Container which will show a tooltip while being long pressing. The
/// provided [child] will wrapped inside the Container.
///
/// As tooltip the provided [text] is shown.
class LitTooltipContainer extends StatefulWidget {
  final Color? backgroundColor;
  final Widget child;
  final String text;
  final double borderRadius;
  final EdgeInsets padding;

  /// Creates a [LitTooltipContainer].
  const LitTooltipContainer({
    Key? key,
    required this.backgroundColor,
    required this.child,
    required this.text,
    this.borderRadius = 22.0,
    this.padding = const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 16.0,
    ),
  }) : super(key: key);
  @override
  _LitTooltipContainerState createState() => _LitTooltipContainerState();
}

class _LitTooltipContainerState extends State<LitTooltipContainer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  void handleLongPressStart(LongPressStartDetails details) {
    _animationController.forward(from: 0.0);
  }

  void handleLongPressEnd(LongPressEndDetails details) {
    _animationController.reverse(from: 1.0);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onLongPressEnd: handleLongPressEnd,
                  onLongPressStart: handleLongPressStart,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2.0 * _animationController.value,
                            blurRadius: 24.0 * _animationController.value,
                            offset: Offset(2 * -_animationController.value,
                                2 * -_animationController.value),
                            color: Colors.black.withOpacity(
                                (_animationController.value) * 0.6))
                      ],
                      color: Color.lerp(widget.backgroundColor, Colors.black12,
                          _animationController.value),
                    ),
                    child: Padding(
                      padding: widget.padding,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: AnimatedOpacity(
                  duration: _animationController.duration!,
                  opacity: _animationController.value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    child: BluredBackgroundContainer(
                      blurRadius: 4.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.lerp(
                            widget.backgroundColor,
                            Colors.white24,
                            1.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          child: Text(
                            widget.text,
                            style: LitTextStyles.sansSerif.copyWith(
                              fontSize: 12.0,
                              color: Color.lerp(
                                widget.backgroundColor,
                                Colors.white70,
                                1.0,
                              ),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
