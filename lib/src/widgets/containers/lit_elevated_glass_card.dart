import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class LitElevatedGlassCard extends StatelessWidget {
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final Widget child;
  final Widget backgroundArt;
  final Matrix4 transform;
  final List<BoxShadow> boxShadow;
  const LitElevatedGlassCard({
    Key? key,
    required this.padding,
    required this.borderRadius,
    required this.child,
    this.backgroundArt = const SizedBox(),
    required this.transform,
    this.boxShadow = const [
      BoxShadow(
        blurRadius: 10.0,
        color: Colors.black38,
        offset: Offset(-4.0, 2.0),
        spreadRadius: -2.0,
      )
    ],
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform(
          transform: transform,
          child: Padding(
            padding: padding,
            child: Align(
              alignment: Alignment.center,
              child: LitElevatedCard(
                margin: const EdgeInsets.all(0.0),
                padding: const EdgeInsets.all(0.0),
                backgroundColor: Colors.white,
                borderRadius: borderRadius,
                boxShadow: boxShadow,
                child: Opacity(
                  opacity: 0.0,
                  child: child,
                ),
              ),
            ),
          ),
        ),
        backgroundArt,
        Transform(
          transform: transform,
          child: Padding(
            padding: padding,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: Colors.white54,
                ),
                child: BluredBackgroundContainer(
                  blurRadius: 8.0,
                  borderRadius: borderRadius,
                  child: LitElevatedCard(
                    margin: const EdgeInsets.all(0.0),
                    padding: const EdgeInsets.all(0.0),
                    backgroundColor: Colors.transparent,
                    boxShadow: [],
                    borderRadius: borderRadius,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
