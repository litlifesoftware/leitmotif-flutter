import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif widget displaying a visual representation of a file path.
///
/// The provided path will be split using the `/` character.
class FilePathPreview extends StatelessWidget {
  /// The path.
  final String path;

  /// The padding applied to the wrapping container.
  final EdgeInsets padding;

  /// Creates a [FilePathPreview].
  const FilePathPreview({
    Key? key,
    required this.path,
    this.padding = const EdgeInsets.symmetric(horizontal: 2.0),
  }) : super(key: key);

  static const String _splitPattern = "/";

  /// Returns a list of path elements.
  List<String> get pathItems => path.split(_splitPattern);

  List<Widget> get elements {
    List<Widget> widgets = [];
    for (int i = 0; i < pathItems.length; i++) {
      widgets.add(
        _PathElementText(
          text: pathItems[i],
        ),
      );
      if (i != (pathItems.length - 1)) {
        widgets.add(
          _Chevron(
            padding: padding,
          ),
        );
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Builder(
        builder: (context) {
          return Row(
            children: elements,
          );
        },
      ),
    );
  }
}

/// A chevron icon to seperate individual path elements.
class _Chevron extends StatelessWidget {
  final EdgeInsets padding;

  /// Creates a [_Chevron].
  const _Chevron({
    Key? key,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: padding,
        child: Icon(
          LitIcons.chevron_right_solid,
          color: LitColors.lightGrey,
          size: 10.0,
        ),
      ),
    );
  }
}

/// A text widget displaying a path element.
class _PathElementText extends StatelessWidget {
  final String text;

  /// Creates a [_PathElementText].
  const _PathElementText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: LitSansSerifStyles.overline,
    );
  }
}
