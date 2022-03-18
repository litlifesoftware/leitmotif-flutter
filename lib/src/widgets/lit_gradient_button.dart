import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class LitGradientButton extends StatefulWidget {
  final Widget child;
  final Color color;
  final Color accentColor;
  final void Function() onPressed;
  final EdgeInsets padding;
  final bool animated;
  final bool blurred;
  final Alignment begin;
  final Alignment end;
  final List<BoxShadow> boxShadow;
  final BorderRadius borderRadius;
  const LitGradientButton({
    Key? key,
    required this.child,
    this.color = Colors.white,
    this.accentColor = const Color(0xFFE7E7E7),
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
    this.animated = false,
    this.begin = Alignment.topRight,
    this.end = Alignment.bottomLeft,
    this.boxShadow = const [
      const BoxShadow(
        color: Colors.black26,
        blurRadius: 12.0,
        offset: Offset(
          2,
          2,
        ),
        spreadRadius: 1.0,
      ),
    ],
    this.borderRadius = const BorderRadius.all(
      Radius.circular(
        18.0,
      ),
    ),
    this.blurred = true,
  }) : super(key: key);
  @override
  _LitGradientButtonState createState() => _LitGradientButtonState();
}

class _LitGradientButtonState extends State<LitGradientButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  LinearGradient get _gradient {
    return LinearGradient(
      colors: [
        Color.lerp(
          widget.color,
          widget.accentColor,
          _animationController.value,
        )!,
        Color.lerp(
          widget.accentColor,
          widget.color,
          _animationController.value,
        )!
      ],
      stops: [
        widget.animated ? (0.00 + (_animationController.value * 0.20)) : 0.2,
        widget.animated ? (0.20 + (_animationController.value) * 0.80) : 0.7
      ],
      begin: widget.animated
          ? Alignment.lerp(
              widget.begin,
              widget.end,
              _animationController.value,
            )!
          : widget.begin,
      end: widget.animated
          ? Alignment.lerp(
              Alignment.bottomRight,
              widget.begin,
              _animationController.value,
            )!
          : widget.end,
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    if (widget.animated) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitPushedButton(
      onPressed: widget.onPressed,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Transform(
            transform: Matrix4.translationValues(
                0,
                widget.animated ? -4.0 + 4.0 * _animationController.value : 0,
                0),
            child: widget.blurred
                ? BluredBackgroundContainer(
                    borderRadius: widget.borderRadius,
                    child: _ButtonContent(
                      borderRadius: widget.borderRadius,
                      boxShadow: widget.boxShadow,
                      child: widget.child,
                      gradient: _gradient,
                      padding: widget.padding,
                    ),
                  )
                : _ButtonContent(
                    borderRadius: widget.borderRadius,
                    boxShadow: widget.boxShadow,
                    child: widget.child,
                    gradient: _gradient,
                    padding: widget.padding,
                  ),
          );
        },
      ),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  final LinearGradient gradient;
  final BorderRadius borderRadius;
  final List<BoxShadow> boxShadow;
  final EdgeInsets padding;
  final Widget child;
  const _ButtonContent({
    Key? key,
    required this.gradient,
    required this.borderRadius,
    required this.boxShadow,
    required this.padding,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: borderRadius,
            boxShadow: boxShadow,
          ),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ],
    );
  }
}
