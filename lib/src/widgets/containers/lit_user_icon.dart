import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lit_ui_kit/containers.dart';
import 'package:lit_ui_kit/styles.dart';
import 'package:lit_ui_kit/text.dart';

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
    this.username = "Some One",
    this.boxShadow = const [
      const BoxShadow(
        blurRadius: 4.0,
        color: Colors.black12,
        offset: Offset(
          -3.0,
          2.0,
        ),
        spreadRadius: -1.0,
      )
    ],
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
  Color get _userColor {
    Color uColor = widget.primaryColor;
    int alpha = (uColor.alpha * 0.75).floor();
    int red = uColor.red;
    int green = uColor.green;
    int blue = uColor.blue;
    return Color.fromARGB(alpha, red, green, blue);
  }

  Color get _contrastColor {
    return Color(0xFFFFFFFF);
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

  Color get _textColor {
    Color textLight = Colors.white;
    Color textDark = Color(0xFF888888);
    double luminanceUserColor = _userColor.computeLuminance();
    double luminanceTextLight = textLight.computeLuminance();
    double luminacneTextDark = textDark.computeLuminance();
    double contrastLight = (max(luminanceUserColor, luminanceTextLight) +
        0.05 / min(luminanceUserColor, luminanceTextLight) +
        0.05);
    double contrastDark = (max(luminanceUserColor, luminacneTextDark) +
        0.05 / min(luminanceUserColor, luminacneTextDark) +
        0.05);
    Color textColor = (contrastDark > contrastLight) ? textDark : textLight;
    return textColor;
  }

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
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          boxShadow: widget.boxShadow,
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                _userColor,
                _contrastColor,
              ]),
          borderRadius: widget.borderRadius,
        ),
        child: Center(
          child: Padding(
            padding: widget.margin,
            child: ClippedText(
              _usernameInitials,
              style: LitSansSerifStyles.header5.copyWith(
                fontSize: widget.fontSize,
                color: _textColor,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
