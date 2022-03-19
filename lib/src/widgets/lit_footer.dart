import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `containers` widget allowing to display the provided [child]
/// on a decorated container aligned on the bottom of the screen.
class LitFooter extends StatelessWidget {
  /// The footer's title.
  final String title;

  /// The child widget.
  final Widget child;

  /// The gradient decoration.
  final Gradient gradientDecoration;

  /// Creates a [LitFooter].
  const LitFooter({
    Key? key,
    required this.title,
    required this.child,
    this.gradientDecoration = defaultGradientDecoration,
  }) : super(key: key);

  static const defaultGradientDecoration = LitGradients.verylightGreyGradient;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradientDecoration,
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 82.0,
              left: 16.0,
              right: 16.0,
            ),
            child: LitConstrainedSizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LitConstrainedSizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                      ),
                      child: ClippedText(
                        title,
                        textAlign: TextAlign.end,
                        style: LitSansSerifStyles.h5,
                      ),
                    ),
                  ),
                  LitConstrainedSizedBox(
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
