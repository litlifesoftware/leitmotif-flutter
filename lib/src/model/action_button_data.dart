import 'package:flutter/material.dart';

class ActionButtonData {
  final String title;
  final void Function() onPressed;
  final Color backgroundColor;
  final Color accentColor;

  const ActionButtonData({
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
    required this.accentColor,
  });
}
