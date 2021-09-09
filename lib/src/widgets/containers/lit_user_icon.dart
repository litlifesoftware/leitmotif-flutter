import 'package:flutter/material.dart';
import 'package:leitmotif/containers.dart';
import 'package:leitmotif/styles.dart';
import 'package:leitmotif/text.dart';
import 'package:leitmotif/utility.dart';

/// A widget displaying an username on a colored background.
///
/// The username will be converted into an acronym to keep the displayed text
/// as short as possible. The username is split on each space character.
class LitUserIcon extends StatefulWidget {
  /// Creates a [LitUserIcon].
  const LitUserIcon({
    Key? key,
    this.size = 96.0,
    this.primaryColor = Colors.white,
    this.contrastColor = Colors.white,
    this.username = "Some One",
    this.boxShadow = LitBoxShadows.md,
    this.borderRadius = const BorderRadius.all(
      const Radius.circular(38.0),
    ),
    this.fontSize = 34.0,
    this.onPressed,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
  }) : super(key: key);

  /// The size which accounts for both, width and height.
  final double size;

  /// The primary color used to generate the gradient background.
  final Color primaryColor;

  /// The contrasting color used to generate the gradient background.
  final Color contrastColor;

  /// The displayed username, whose text is converted into an acronym.
  final String username;

  /// The container's box shadow.
  final List<BoxShadow> boxShadow;

  /// The container's border radius.
  final BorderRadius borderRadius;

  /// Called once the container has been pressed.
  final void Function()? onPressed;

  /// The text font size.
  final double fontSize;

  /// The margin surrounding the text.
  final EdgeInsets margin;

  @override
  __UserIconState createState() => __UserIconState();
}

class __UserIconState extends State<LitUserIcon> {
  /// Returns a stylized user color.
  Color get _primaryColor {
    return widget.primaryColor.desat(0.75);
  }

  /// Returns a [Color] to contrast with the [_primaryColor].
  Color get _contrastColor {
    return widget.contrastColor;
  }

  /// Returns the initials of the user derived by the username.
  String get _usernameInitials {
    String initals = "";
    List<String> names = "${widget.username}".split(" ");

    // Add the first character of each substring (name elements).
    for (String nameElement in names) {
      if (initals.length < 3) {
        initals = initals +
            // If there is only one element and the element's length
            //  does not exceed three characters, adopt the whole element's
            // content.
            ((nameElement.length < 3 && names.length == 1)
                ? nameElement
                // Else, shorten it.
                : nameElement.substring(0, 1));
      }
    }

    return initals;
  }

  /// Returns either a dark or a light themed text color based on the contrast
  /// ratio.
  Color get _textColor {
    return _primaryColor.computeLuminance() >= 0.5
        ? Color(0xFF757575)
        : Colors.white;
  }

  List<BoxShadow> get _boxShadow {
    if (widget.size > 96.0) {
      return LitBoxShadows.lg;
    }
    if (widget.size > 42.0) {
      return LitBoxShadows.md;
    }
    return LitBoxShadows.sm;
  }

  double get _fontSize {
    return widget.size / 2.75;
  }

  EdgeInsets get _margin {
    return EdgeInsets.all(widget.size / 5);
  }

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
                colors: [Colors.white, _primaryColor],
              ),
              borderRadius: _borderRadius,
            ),
            child: Center(
              child: Padding(
                padding: _margin,
                child: ClippedText(
                  _usernameInitials,
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
