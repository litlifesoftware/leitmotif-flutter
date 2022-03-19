import 'package:flutter/material.dart';
import 'package:leitmotif/styles.dart';
import 'package:leitmotif/utility.dart';
import 'package:leitmotif/widgets.dart';

/// A Leitmotif `art` widget displaying a stylized username on a
/// decorated background.
///
/// The username will be converted into an acronym to keep the displayed text
/// as short as possible. The username is split on each space character.
class LitUserIcon extends StatefulWidget {
  /// The size which accounts for both, width and height.
  final double size;

  /// The primary color used to generate the gradient background.
  final Color color;

  /// The contrasting color used to generate the gradient background.
  final Color accentColor;

  /// The displayed username, whose text is converted into an acronym.
  final String name;

  /// The container's box shadow.
  final List<BoxShadow> boxShadow;

  /// Called once the container has been pressed.
  final void Function()? onPressed;

  /// Creates a [LitUserIcon].
  const LitUserIcon({
    Key? key,
    this.size = 96.0,
    this.color = Colors.white,
    this.accentColor = Colors.white,
    required this.name,
    this.boxShadow = LitBoxShadows.md,
    this.onPressed,
  }) : super(key: key);

  @override
  __UserIconState createState() => __UserIconState();
}

class __UserIconState extends State<LitUserIcon> {
  /// Returns a desaturated main color.
  Color get _color => widget.color.desat(0.65);

  /// Returns a desaturated accent color.
  Color get _accentColor => widget.accentColor.desat(0.35);

  List<String> get names {
    if (widget.name.length > 0) {
      return widget.name.split(" ");
    }
    return [];
  }

  /// Returns the initials of the user derived by its username.
  String get _initials {
    if (names.isEmpty) {
      return "";
    }

    // Only one name provided
    if (names.length == 1) {
      return "" + names.first.convertToInitial();
    }

    // Ignore middle names by using only the first and the last name's
    // initials.
    if (names.length > 1) {
      return "" +
          names.first.convertToInitial() +
          names.last.convertToInitial();
    }

    return "";
  }

  /// Returns either a dark or a light themed text color based on the contrast
  /// ratio.
  Color get _textColor {
    Color light = Colors.white;
    Color dark = LitColors.grey350;

    return _color.applyColorByContrast(light, dark);
  }

  /// Returns the font size in relation to the provided size.
  double get _fontSize {
    return widget.size / 3.75;
  }

  /// Returns the margin in relation to the provided size.
  EdgeInsets get _margin {
    return EdgeInsets.all(widget.size / 5);
  }

  /// Returns the border radius in relation to the provided size.
  BorderRadius get _borderRadius {
    return BorderRadius.all(
      Radius.circular(widget.size / 2.5),
    );
  }

  /// Calls the provided [widget.onPressed] callback.
  void _onTap() {
    if (widget.onPressed != null) {
      widget.onPressed!();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CleanInkWell(
      onTap: _onTap,
      child: Stack(
        children: [
          // Ensure to always paint on a white solid background.
          Container(
            height: widget.size,
            width: widget.size,
            decoration: BoxDecoration(
              boxShadow: widget.boxShadow,
              borderRadius: _borderRadius,
              color: Colors.white,
            ),
          ),
          Container(
            height: widget.size,
            width: widget.size,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [_accentColor, _color],
                stops: [0.05, 0.65],
              ),
              borderRadius: _borderRadius,
            ),
            child: Center(
              child: Padding(
                padding: _margin,
                child: ScaledDownText(
                  _initials,
                  style: LitSansSerifStyles.h5.copyWith(
                    fontSize: _fontSize,
                    color: _textColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
