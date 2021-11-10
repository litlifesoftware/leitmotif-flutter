import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif container widget displaying the provided [child] on an
/// elevated card.
///
/// Allows the user to interact with the card using action buttons displayed on
/// the bottom of the card.
class LitTitledActionCard extends StatelessWidget {
  /// The card's title.
  final String? title;

  /// The card's subtitle. None displayed if none provided.
  final String? subtitle;

  /// The card's inner margin.
  final EdgeInsets margin;

  /// The card's background colors.
  final List<Color> backgroundColors;

  /// The card's child widget.
  final Widget child;

  /// The action button's data.
  final List<ActionButtonData>? actionButtonData;

  /// Creates a [LitTitledActionCard].
  const LitTitledActionCard({
    Key? key,
    this.title,
    this.subtitle,
    this.margin = LitEdgeInsets.card,
    this.backgroundColors = const [Colors.white, Colors.white],
    this.child = const SizedBox(),
    this.actionButtonData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            LitGradientCard(
              colors: backgroundColors,
              child: Padding(
                padding: margin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LitCardTitle(
                      title: title,
                      subtitle: subtitle,
                    ),
                    child,
                    _ButtonBuilder(
                      data: actionButtonData,
                      constraints: constraints,
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

/// A builder widget allowing to build a row of buttons on the
/// [LitTitledActionCard]'s bottom.
class _ButtonBuilder extends StatelessWidget {
  final List<ActionButtonData>? data;
  final BoxConstraints constraints;
  final EdgeInsets margin;
  const _ButtonBuilder({
    Key? key,
    required this.data,
    this.margin = LitEdgeInsets.spacingTop,
    required this.constraints,
  }) : super(key: key);
  bool get _buttonsEnabled => data != null;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        List<Widget> children = [];
        if (_buttonsEnabled)
          for (ActionButtonData item in data!)
            children.add(
              SizedBox(
                width: constraints.maxWidth,
                child: LitPushedThroughButton(
                  backgroundColor: item.backgroundColor,
                  accentColor: item.accentColor,
                  child: Text(
                    item.title.toUpperCase(),
                    style: item.style,
                    textAlign: TextAlign.center,
                  ),
                  onPressed: item.onPressed,
                ),
              ),
            );
        return Padding(
          padding: margin,
          child: Column(
            children: children,
          ),
        );
      },
    );
  }
}
