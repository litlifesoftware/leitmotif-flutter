import 'package:flutter/material.dart';
import 'package:leitmotif/models.dart';

/// A Leitmotif `model` class providing data required to build navigatable
/// tab views.
class LitNavigableTab {
  /// The meta data for the tab.
  final LitBottomNavigationItemData tabData;

  /// The screen widget.
  final Widget screen;

  /// Creates a [LitNavigableTab],
  const LitNavigableTab({
    required this.tabData,
    required this.screen,
  });
}
