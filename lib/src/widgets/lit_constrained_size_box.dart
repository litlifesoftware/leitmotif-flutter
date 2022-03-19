import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class LitConstrainedSizedBox extends StatelessWidget {
  final Widget child;
  final double landscapeWidthFactor;
  const LitConstrainedSizedBox({
    Key? key,
    required this.child,
    this.landscapeWidthFactor = 0.5,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: isPortraitMode(MediaQuery.of(context).size)
            ? constraints.maxWidth
            : constraints.maxWidth >
                    (MediaQuery.of(context).size.width * landscapeWidthFactor)
                ? (MediaQuery.of(context).size.width * landscapeWidthFactor)
                : constraints.maxWidth,
        child: child,
      );
    });
  }
}
