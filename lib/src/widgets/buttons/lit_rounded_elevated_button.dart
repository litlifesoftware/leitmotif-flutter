import 'package:flutter/material.dart';

class LitRoundedElevatedButton extends StatefulWidget {
  final Color color;
  final Widget child;
  final void Function() onPressed;
  final double radius;
  final EdgeInsets padding;
  final List<BoxShadow> boxShadow;

  /// Creates a [RoundedFlatButton].
  ///
  /// The button will highlight the provided child [Widget] using
  /// the corresponding [color] parameter value.
  /// Its [BorderRadius] is set by default to have a radius of
  /// 25.0 pixels.
  const LitRoundedElevatedButton({
    Key? key,
    required this.color,
    required this.child,
    required this.onPressed,
    this.radius = 25.0,
    this.padding = const EdgeInsets.symmetric(
      vertical: 4.0,
      horizontal: 12.0,
    ),
    this.boxShadow = const [
      BoxShadow(
        blurRadius: 16.0,
        color: Colors.black26,
        offset: Offset(-2, 2),
        spreadRadius: 1.0,
      )
    ],
  }) : super(key: key);

  @override
  _LitRoundedElevatedButtonState createState() =>
      _LitRoundedElevatedButtonState();
}

class _LitRoundedElevatedButtonState extends State<LitRoundedElevatedButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  Future<void> _animate() {
    return _animationController
        .reverse(from: 1.0)
        .then((_) => _animationController.forward());
  }

  //void _pressDown(TapDownDetails details) {}

  void _pressUp(TapUpDetails details) {
    _animate().then((_) => widget.onPressed());
  }

  void _longPressedEnd(LongPressEndDetails details) {
    _animationController.forward();
  }

  void _longPressStart(LongPressStartDetails details) {
    _animationController.reverse();
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 80), vsync: this);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: _onTap,
      //onTapDown: _pressDown,
      onTapUp: _pressUp,
      onLongPressStart: _longPressStart,
      onLongPressEnd: _longPressedEnd,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(widget.radius),
                boxShadow: [
                  BoxShadow(
                    blurRadius: widget.boxShadow.first.blurRadius *
                        _animationController.value,
                    color: widget.boxShadow.first.color,
                    offset: Offset(
                        widget.boxShadow.first.offset.dx *
                            _animationController.value,
                        widget.boxShadow.first.offset.dy *
                            _animationController.value),
                    spreadRadius: widget.boxShadow.first.spreadRadius *
                        _animationController.value,
                  )
                ]),
            child: Padding(
              padding: widget.padding,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
