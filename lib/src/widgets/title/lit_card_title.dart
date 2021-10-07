import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class LitCardTitle extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const LitCardTitle({
    Key? key,
    required this.title,
    required this.subtitle,
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
                subtitle!.toUpperCase(),
                style: LitSansSerifStyles.overline.copyWith(
                  letterSpacing: 1.0,
                ),
              )
            : SizedBox()
      ],
    );
  }
}
