import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `art` widgets displaying either an `right` or `left` directed
/// chevron icon depending on the provided [mode].
class LinearNavigationIcon extends StatelessWidget {
  final LitLinearNavigationMode mode;
  final Color color;
  final double size;

  /// Creates a [LinearNavigationIcon].
  const LinearNavigationIcon({
    Key? key,
    required this.mode,
    this.color = LitSansSerifStyles.defaultColor,
    this.size = 14.0,
  }) : super(key: key);

  /// Returns an icon according to the provided [LitLinearNavigationMode]
  /// value.
  IconData get _icon {
    switch (mode) {
      case LitLinearNavigationMode.next:
        return LitIcons.chevron_right_solid;
      case LitLinearNavigationMode.previous:
        return LitIcons.chevron_left_solid;
      default:
        throw Exception(
            'Leitmotif: This navigation type has not been implemented on NavigationIcon.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      _icon,
      size: size,
      color: color,
    );
  }
}
