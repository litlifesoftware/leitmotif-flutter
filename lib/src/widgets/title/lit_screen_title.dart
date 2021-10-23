import 'package:flutter/material.dart';
import 'package:leitmotif/styles.dart';

/// A Leitmotif `titles` widget allowing to display a title on a screen.
class LitScreenTitle extends StatelessWidget {
  /// The screen's title.
  final String title;

  /// The screen's subtitle.
  final String subtitle;

  /// States whether to use uppercase typing on the subtitle text.
  final bool uppercaseSubtitle;
  const LitScreenTitle({
    Key? key,
    required this.title,
    required this.subtitle,
    this.uppercaseSubtitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          uppercaseSubtitle ? subtitle.toUpperCase() : subtitle,
          style: LitSansSerifStyles.overline,
        ),
        SizedBox(height: 4.0),
        Text(
          title,
          style: LitSansSerifStyles.h5.copyWith(
            color: LitColors.grey350,
          ),
        ),
      ],
    );
  }
}
