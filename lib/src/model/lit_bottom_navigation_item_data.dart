import 'package:flutter/material.dart';
import 'package:leitmotif/styles.dart';

/// A Leitmotif `model` class describing meta data required to build a tab item
/// on a bottom navigation bar.
class LitBottomNavigationItemData {
  /// The tab's index.
  final int index;

  /// The icon in `unselected` state.
  final IconData icon;

  /// The icon in `selected` state.
  final IconData iconAlt;

  /// The tab's title.
  final String? title;

  /// The background color of the currently selected tab item.
  final Color tabBackgroundColorAlt;

  /// The background color of each unselected tab item.
  final Color tabBackgroundColor;

  /// The color of the currently selected tab item.
  final Color tabColor;

  /// The color of each unselected tab item.
  final Color tabColorAlt;

  /// Creates a [LitBottomNavigationItemData].
  const LitBottomNavigationItemData({
    required this.index,
    required this.icon,
    required this.iconAlt,
    this.title,
    this.tabBackgroundColorAlt = defaultBackgroundColorAlt,
    this.tabBackgroundColor = defaultBackgroundColor,
    this.tabColor = defaultColor,
    this.tabColorAlt = defaultColorAlt,
  });

  static const defaultBackgroundColorAlt = Colors.white;
  static const defaultBackgroundColor = LitColors.transparent;
  static const defaultColor = LitColors.grey350;
  static const defaultColorAlt = LitColors.grey500;
}
