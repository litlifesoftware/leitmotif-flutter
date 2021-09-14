import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Flutter widget displaying information and allowing the user to pick an
/// action to respond to the given information.
class LitTitledActionCard extends StatelessWidget {
  /// The card's title.
  final String title;

  /// The card's subtitle. None displayed if none provided.
  final String? subtitle;

  /// The card's inner margin.
  final EdgeInsets margin;

  /// The card's background colors.
  final List<Color> backgroundColors;

  /// The card's child widget.
  final Widget child;

  /// The action button's data. Action buttons are displayed on the bottom of
  /// the card.
  final List<ActionButtonData>? actionButtonData;

  /// Creates a [LitTitledActionCard].
  const LitTitledActionCard({
    Key? key,
    required this.title,
    this.subtitle,
    this.margin = const EdgeInsets.symmetric(
      vertical: 16.0,
      horizontal: 16.0,
    ),
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
                    LitCardTitle(title: title, subtitle: subtitle),
                    child,
                    actionButtonData != null
                        ? _ButtonBuilder(
                            actionButtonData: actionButtonData,
                            constraints: constraints,
                          )
                        : SizedBox(),
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

class _ButtonBuilder extends StatelessWidget {
  final List<ActionButtonData>? actionButtonData;
  final BoxConstraints constraints;
  final EdgeInsets margin;
  const _ButtonBuilder({
    Key? key,
    required this.actionButtonData,
    this.margin = const EdgeInsets.only(top: 16.0),
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        List<Widget> children = [];
        for (ActionButtonData actionButton in actionButtonData!) {
          children.add(
            SizedBox(
              width: constraints.maxWidth,
              child: LitPushedThroughButton(
                backgroundColor: actionButton.backgroundColor ?? Colors.white,
                accentColor: actionButton.accentColor ?? LitColors.lightGrey,
                child: Text(
                  actionButton.title.toUpperCase(),
                  style: LitSansSerifStyles.button,
                  textAlign: TextAlign.center,
                ),
                onPressed: actionButton.onPressed,
              ),
            ),
          );
        }
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
