import 'package:flutter/material.dart';
import 'package:leitmotif/utility.dart';

/// A widget visually seperating two similar looking widget.
///
/// The divider can be used on list views or columns in horizontal alignment or
/// on rows in vertical alignment.
class LitDivider extends StatelessWidget {
  final EdgeInsets padding;

  const LitDivider({
    Key? key,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        height: 2.0,
        decoration: BoxDecoration(
          color: HexColor('#C9C9C9'),
        ),
      ),
    );
  }
}
