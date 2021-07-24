import 'package:flutter/material.dart';
import 'package:lit_ui_kit/buttons.dart';
import 'package:lit_ui_kit/containers.dart';

/// A widget displaying a List of minimalist buttons on a [LitFooter].
///
/// The title defaults to `Settings`, as its primary function is to display a
/// minimalist settings section.
class LitSettingsFooter extends StatelessWidget {
  /// The footer's title. Defaults to `Settings`.
  final String title;

  /// A list of buttons to create interactive options.
  final List<LitPlainLabelButton> children;

  /// A list of colors applied on the background's gradient.
  final List<Color> gradientColors;

  /// Creates a [LitSettingsFooter].
  const LitSettingsFooter({
    Key? key,
    this.title = "Settings",
    required this.children,
    this.gradientColors = LitFooterDefaultStyling.colorsLight,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return LitFooter(
      title: title,
      gradientColors: gradientColors,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: children,
        ),
      ),
    );
  }
}
