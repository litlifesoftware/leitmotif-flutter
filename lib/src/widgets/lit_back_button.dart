import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `button` widget allowing to navigate one level back.
///
/// The navigation can be overriden using the [onPressed] method to specify custom
/// navigation.
class LitBackButton extends StatefulWidget {
  /// The button's height.
  final double height;

  /// The button's width.
  final double width;

  /// The button background color.
  final Color backgroundColor;

  /// The button's icon color.
  final Color iconColor;

  /// The icon's size.
  final double iconSize;

  /// States whether navigating back should be allowed.
  ///
  /// This will prevent discarding unsaved changes.
  final bool shouldNavigateBack;

  /// Handles the actions once the button is pressed while navigating back
  /// should not be allowed.
  final void Function()? onInvalidNavigation;

  /// Handles the `onPressed` action.
  final void Function()? onPressed;
  const LitBackButton({
    Key? key,
    this.height = defaultHeight,
    this.width = defaultWidth,
    this.backgroundColor = defaultBackgroundColor,
    this.iconColor = defaultIconColor,
    this.iconSize = defaultIconSize,
    this.shouldNavigateBack = defaultShouldNavigateBack,
    this.onInvalidNavigation,
    this.onPressed,
  }) : super(key: key);

  static const double defaultHeight = 32.0;
  static const double defaultWidth = 54.0;
  static const double defaultIconSize = 16.0;
  static const Color defaultBackgroundColor = LitColors.white;
  static const Color defaultIconColor = LitColors.grey350;
  static const IconData icon = LitIcons.arrow_left_solid;
  static const bool defaultShouldNavigateBack = true;
  static const List<BoxShadow> boxShadow = LitBoxShadows.md;

  @override
  _LitBackButtonState createState() => _LitBackButtonState();
}

class _LitBackButtonState extends State<LitBackButton> {
  /// Handles the `onPressed` action.
  void _onTap() {
    // If a callback was provided, execute it.
    if (widget.onPressed != null) {
      widget.onPressed!();
      // Otherwise navigate back by default.
    } else {
      if (Navigator.canPop(context)) {
        if (widget.shouldNavigateBack) {
          // Await the back button's animation.
          Future.delayed(LitAnimationDurations.button).then(
            (_) => Navigator.of(context).pop(),
          );
        } else {
          if (widget.onInvalidNavigation != null) {
            widget.onInvalidNavigation!();
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: LitPushedThroughButton(
        boxShadow: LitBackButton.boxShadow,
        backgroundColor: widget.backgroundColor,
        accentColor: widget.backgroundColor,
        child: Align(
          alignment: Alignment.center,
          child: FittedBox(
            alignment: Alignment.center,
            child: Icon(
              LitBackButton.icon,
              size: widget.iconSize,
              color: widget.iconColor,
            ),
          ),
        ),
        onPressed: _onTap,
      ),
    );
  }
}
