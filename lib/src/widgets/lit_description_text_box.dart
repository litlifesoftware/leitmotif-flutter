import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `containers` widget allowing to display information alongside
/// an icon.
class LitDescriptionTextBox extends StatefulWidget {
  /// The icon.
  final IconData icon;

  /// The title.
  final String? title;

  /// The description text body.
  final String text;

  /// The outer padding.
  final EdgeInsets padding;

  /// The maximum number of lines the description text body should have.
  final int maxLines;

  /// The icon container's background color.
  final Color iconBackgroundColor;

  /// The text style.
  final TextStyle style;

  /// Creates a [LitDescriptionTextBox].
  const LitDescriptionTextBox({
    Key? key,
    this.icon = LitIcons.info,
    this.title,
    required this.text,
    this.padding = const EdgeInsets.all(0),
    this.maxLines = 3,
    this.iconBackgroundColor = Colors.white,
    this.style = LitSansSerifStyles.caption,
  }) : super(key: key);

  @override
  _LitDescriptionTextBoxState createState() => _LitDescriptionTextBoxState();

  static const double _iconContainerWidth = 42.0;
  static const double _iconSize = 13.0;
  static const int _colorDark = 0xFF616161;
  static const int _colorLight = 0xFFFFFFFf;
  static const EdgeInsets _iconPadding =
      const EdgeInsets.only(top: 8.0, bottom: 8.0);
  static const EdgeInsets _textBoxPadding = const EdgeInsets.only(
    right: 4.0,
    left: 8.0,
    top: 8.0,
    bottom: 8.0,
  );
}

class _LitDescriptionTextBoxState extends State<LitDescriptionTextBox> {
  /// Either returns the dark or light text color.
  Color get _iconColor {
    return widget.iconBackgroundColor.applyColorByContrast(
      Color(LitDescriptionTextBox._colorLight),
      Color(LitDescriptionTextBox._colorDark),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon container.
                _IconContainer(
                  icon: widget.icon,
                  iconBackgroundColor: widget.iconBackgroundColor,
                  iconColor: _iconColor,
                ),
                // Text box.
                Container(
                  width: constraints.maxWidth -
                      LitDescriptionTextBox._iconContainerWidth,
                  child: Padding(
                    padding: LitDescriptionTextBox._textBoxPadding,
                    child: _TextBox(
                      maxLines: widget.maxLines,
                      style: widget.style,
                      text: widget.text,
                      title: widget.title,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// A widget to display an icon inside a decorated container.
class _IconContainer extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  const _IconContainer({
    Key? key,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: LitDescriptionTextBox._iconPadding,
      child: Container(
        height: LitDescriptionTextBox._iconContainerWidth,
        width: LitDescriptionTextBox._iconContainerWidth,
        decoration: BoxDecoration(
          color: iconBackgroundColor,
          boxShadow: LitBoxShadows.sm,
          borderRadius: BorderRadius.circular(
            16.0,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            size: LitDescriptionTextBox._iconSize,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

class _TextBox extends StatelessWidget {
  final String? title;
  final String text;
  final int maxLines;
  final TextStyle style;
  const _TextBox({
    Key? key,
    required this.title,
    required this.text,
    required this.maxLines,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        title != null
            ? ClippedText(
                title!.toUpperCase(),
                maxLines: 1,
                style: style.copyWith(
                  fontWeight: FontWeight.lerp(
                    style.fontWeight,
                    FontWeight.bold,
                    0.75,
                  ),
                ),
              )
            : SizedBox(height: 0),
        SizedBox(
          height: title != null ? 2.0 : 0.0,
        ),
        ClippedText(
          text,
          maxLines: maxLines,
          style: style,
        ),
      ],
    );
  }
}
