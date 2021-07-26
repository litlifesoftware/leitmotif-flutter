import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class LitFooterDefaultStyling {
  static const List<Color> colorsLight = const [
    const Color(0xFFD9D9D9),
    Colors.white,
  ];
  static const List<Color> colorsDark = const [
    LitColors.darkBlue,
    Colors.black,
  ];
}

class LitFooter extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Color> gradientColors;
  const LitFooter({
    Key? key,
    this.title = "Footer",
    required this.child,
    this.gradientColors = LitFooterDefaultStyling.colorsLight,
  }) : super(key: key);
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
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors,
            ),
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
                        style: LitSansSerifStyles.h6.copyWith(
                          color: HexColor('#878787'),
                        ),
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
