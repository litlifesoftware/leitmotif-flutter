import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class LitTitledActionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final List<ActionButtonData>? actionButtonData;
  const LitTitledActionCard({
    Key? key,
    required this.title,
    this.subtitle,
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
              colors: [Colors.white, Colors.white],
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
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
  const _ButtonBuilder({
    Key? key,
    required this.actionButtonData,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        List<Widget> children = [];
        for (ActionButtonData actionButton in actionButtonData!) {
          children.add(SizedBox(height: 24.0));
          children.add(
            SizedBox(
              width: constraints.maxWidth,
              child: LitPushedThroughButton(
                backgroundColor: actionButton.backgroundColor,
                accentColor: actionButton.accentColor,
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
        return Column(
          children: children,
        );
      },
    );
  }
}
