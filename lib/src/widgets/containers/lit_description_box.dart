import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

const double _ICON_CONTAINER_WIDTH = 42.0;
const double _ICON_SIZE = 13.0;
const int _ICON_COLOR_DARK = 0xFF616161;
const int _ICON_COLOR_LIGHT = 0xFFFFFFFf;
const EdgeInsets _ICON_PADDING = const EdgeInsets.only(top: 8.0, bottom: 8.0);
const EdgeInsets _TEXT_BOX_PADDING = const EdgeInsets.only(
  right: 4.0,
  left: 8.0,
  top: 8.0,
  bottom: 8.0,
);

/// A Flutter widget displaying an [Icon] alongside the provided description
/// text in order to share information in a textual manner.
class LitDescriptionTextBox extends StatefulWidget {
  final IconData icon;
  final String? title;
  final String text;
  final EdgeInsets padding;

  final int maxLines;
  final Color iconBackgroundColor;
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
}

class _LitDescriptionTextBoxState extends State<LitDescriptionTextBox> {
  /// Either returns the dark or light text color.
  Color get _iconColor {
    return widget.iconBackgroundColor.applyColorByContrast(
      Color(_ICON_COLOR_LIGHT),
      Color(_ICON_COLOR_DARK),
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
                Padding(
                  padding: _ICON_PADDING,
                  child: Container(
                    height: _ICON_CONTAINER_WIDTH,
                    width: _ICON_CONTAINER_WIDTH,
                    decoration: BoxDecoration(
                      color: widget.iconBackgroundColor,
                      boxShadow: LitBoxShadows.sm,
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        widget.icon,
                        size: _ICON_SIZE,
                        color: _iconColor,
                      ),
                    ),
                  ),
                ),

                // Text box.
                Container(
                  width: constraints.maxWidth - _ICON_CONTAINER_WIDTH,
                  child: Padding(
                    padding: _TEXT_BOX_PADDING,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: widget.title != null
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        widget.title != null
                            ? ClippedText(
                                widget.title!.toUpperCase(),
                                maxLines: 1,
                                style: widget.style.copyWith(
                                  fontWeight: FontWeight.lerp(
                                    widget.style.fontWeight,
                                    FontWeight.bold,
                                    0.75,
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: widget.title != null ? 2.0 : 0.0,
                        ),
                        ClippedText(
                          widget.text,
                          maxLines: widget.maxLines,
                          style: widget.style,
                        ),
                      ],
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
