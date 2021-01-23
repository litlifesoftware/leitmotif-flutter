import 'package:flutter/material.dart';

/// The extended [IconData] class to override the default [IconData.fontPackage]
/// and [IconData.fontFamily].
class LitIconData extends IconData {
  /// Creates a new [LitIconData] object using the defined [IconData.fontPackage]
  /// and [IconData.fontFamily].
  const LitIconData(int codePoint)
      : super(
          codePoint,
          fontFamily: 'LitIcons',
          fontPackage: 'lit_ui_kit',
        );
}
