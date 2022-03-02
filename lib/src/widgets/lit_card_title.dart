import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif widget allowing to display a title and subtitle on top
/// of a card.
class LitCardTitle extends StatelessWidget {
  /// The card's title.
  final String? title;

  /// The card's subtitle.
  final String? subtitle;

  /// States whether to use uppercase typing on the subtitle text.
  final bool uppercaseSubtitle;

  /// Creates a [LitCardTitle].
  const LitCardTitle({
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
        title != null
            ? Text(
                title!,
                style: LitSansSerifStyles.h6,
              )
            : SizedBox(),
        subtitle != null ? SizedBox(height: 4.0) : SizedBox(),
        subtitle != null
            ? Text(
                uppercaseSubtitle ? subtitle!.toUpperCase() : subtitle!,
                style: LitSansSerifStyles.overline.copyWith(
                  letterSpacing: 1.0,
                ),
              )
            : SizedBox()
      ],
    );
  }
}
