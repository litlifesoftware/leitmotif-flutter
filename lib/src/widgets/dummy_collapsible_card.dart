import 'package:flutter/material.dart';

import 'collapsible_card.dart';
import 'collapsible_card_controller.dart';

class DummyCollapsibleCard extends StatelessWidget implements CollapsibleCard {
  final CollapsibleCardController collapsibleCardController;

  const DummyCollapsibleCard(
      {Key? key, required this.collapsibleCardController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  CollapsibleCardController get controller => this.collapsibleCardController;
}
