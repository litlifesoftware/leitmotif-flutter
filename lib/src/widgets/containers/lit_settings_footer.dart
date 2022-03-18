import 'package:flutter/material.dart';
import 'package:leitmotif/containers.dart';
import 'package:leitmotif/localization.dart';
import 'package:leitmotif/widgets.dart';

/// A widget displaying a List of minimalist buttons on a [LitFooter].
///
/// The title defaults to `Settings`, as its primary function is to display a
/// minimalist settings section.
class LitSettingsFooter extends StatelessWidget {
  /// The footer's title. Defaults to `Settings`.
  final String? title;

  /// A list of buttons to create interactive options.
  final List<LitPlainLabelButton> children;

  /// A list of colors applied on the background's gradient.
  final Gradient gradientDecoration;

  /// Creates a [LitSettingsFooter].
  const LitSettingsFooter({
    Key? key,
    this.title,
    required this.children,
    this.gradientDecoration = LitFooter.defaultGradientDecoration,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return LitFooter(
      title: title ?? LeitmotifLocalizations.of(context).settingsLabel,
      gradientDecoration: gradientDecoration,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: children,
        ),
      ),
    );
  }
}
