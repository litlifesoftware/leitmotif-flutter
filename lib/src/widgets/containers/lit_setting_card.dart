import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `containers` widget displaying a toggle button alongside text
/// elements to describe its effect on a card.
class LitSettingCard extends StatelessWidget {
  /// The current value.
  final bool value;

  /// The setting's title.
  final String title;

  /// The setting's description.
  final String? description;

  /// The inner margin.
  final EdgeInsets margin;

  /// The outer padding.
  final EdgeInsets padding;

  /// States whether to show the description in uppercase typing.
  ///
  /// Defaults to `false`.
  final bool uppercaseDescription;

  /// The callback handing the the toggle button's `onChanged` event.
  final void Function(bool) onChanged;

  /// Creates a [LitSettingCard].
  const LitSettingCard({
    Key? key,
    required this.value,
    required this.title,
    required this.onChanged,
    this.description,
    this.margin = const EdgeInsets.all(16.0),
    this.padding = const EdgeInsets.all(0.0),
    this.uppercaseDescription = false,
  }) : super(key: key);

  /// Returns the height of the spacing element.
  double get _spacingHeight {
    return margin.top / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LitGradientCard(
        margin: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LitCardTitle(
              title: title,
              subtitle: description,
              uppercaseSubtitle: uppercaseDescription,
            ),
            SizedBox(height: _spacingHeight),
            Align(
              alignment: Alignment.centerRight,
              child: LitToggleButton(
                onChanged: onChanged,
                value: value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
