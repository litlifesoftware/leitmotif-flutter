import 'package:flutter/material.dart';

import 'collapsible_card_controller.dart';

abstract class CollapsibleCard extends Widget {
  final CollapsibleCardController controller;

  const CollapsibleCard({Key? key, required this.controller}) : super(key: key);
}
