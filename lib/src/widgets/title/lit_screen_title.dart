import 'package:flutter/material.dart';
import 'package:leitmotif/styles.dart';

class LitScreenTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const LitScreenTitle({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subtitle.toUpperCase(),
          style: LitSansSerifStyles.overline,
        ),
        SizedBox(height: 4.0),
        Text(
          title,
          style: LitSansSerifStyles.h5.copyWith(
            color: Color(0xFF9E9E9E),
          ),
        ),
      ],
    );
  }
}
