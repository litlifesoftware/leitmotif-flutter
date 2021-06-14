import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class LitTitledDialog extends StatelessWidget {
  final double titleBarHeight;
  final BorderRadius borderRadius;
  final Widget child;
  final LinearGradient titleGradient;
  final String titleText;
  final Color titleTextColor;
  final bool elevated;
  final Widget? leading;
  final double maxWidth;
  final double minHeight;
  final EdgeInsets margin;
  final List<Widget> actionButtons;
  const LitTitledDialog({
    Key? key,
    this.titleBarHeight = 52.0,
    this.borderRadius = const BorderRadius.all(const Radius.circular(24.0)),
    required this.child,
    this.titleGradient = const LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: [
        0.65,
        1.00,
      ],
      colors: [
        Color(0xFFf4f4f7),
        Color(0xFFd1cdcd),
      ],
    ),
    required this.titleText,
    this.titleTextColor = const Color(0xFF444444),
    this.elevated = true,
    this.leading,
    this.maxWidth = 400,
    this.minHeight = 152.0,
    this.actionButtons = const [],
    this.margin = const EdgeInsets.only(
      top: 0.0,
      bottom: 0.0,
    ),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      elevation: 0.0,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: minHeight,
                maxWidth: constraints.maxWidth > maxWidth
                    ? maxWidth
                    : constraints.maxWidth,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _DialogTopBar(
                    titleBarHeight: titleBarHeight,
                    borderRadius: borderRadius,
                    titleGradient: titleGradient,
                    elevated: elevated,
                    titleText: titleText,
                    titleTextColor: titleTextColor,
                    leading: leading,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: (minHeight - (2 * titleBarHeight)),
                      maxWidth: constraints.maxWidth > maxWidth
                          ? maxWidth
                          : constraints.maxWidth,
                    ),
                    child: Padding(
                      padding: margin,
                      child: child,
                    ),
                  ),
                  actionButtons.isNotEmpty
                      ? _DialogActionButtonBuilder(
                          titleBarHeight: titleBarHeight,
                          borderRadius: borderRadius,
                          actionButtons: actionButtons,
                        )
                      : SizedBox(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DialogTopBar extends StatefulWidget {
  final double titleBarHeight;
  final BorderRadius borderRadius;
  final Gradient titleGradient;
  final bool elevated;
  final String titleText;
  final Color titleTextColor;
  final Widget? leading;
  const _DialogTopBar({
    Key? key,
    required this.titleBarHeight,
    required this.borderRadius,
    required this.titleGradient,
    required this.elevated,
    required this.titleText,
    required this.titleTextColor,
    required this.leading,
  }) : super(key: key);

  @override
  __DialogTopBarState createState() => __DialogTopBarState();
}

class __DialogTopBarState extends State<_DialogTopBar> {
  Widget get _titleText {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ClippedText(
        widget.titleText,
        textAlign: TextAlign.right,
        style: LitTextStyles.sansSerif.copyWith(
          fontSize: 16.0,
          color: widget.titleTextColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  List<BoxShadow> get _elevatedBoxShadow {
    return [
      const BoxShadow(
        color: Colors.black38,
        blurRadius: 14.0,
        offset: Offset(0.0, -2.0),
        spreadRadius: 1.0,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.titleBarHeight,
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: widget.borderRadius.topLeft,
          topRight: widget.borderRadius.topRight,
        ),
        gradient: widget.titleGradient,
        boxShadow: widget.elevated ? _elevatedBoxShadow : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          widget.leading != null
              ? Expanded(
                  flex: 2,
                  child: Container(
                    height: widget.titleBarHeight,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: widget.leading,
                    ),
                  ),
                )
              : SizedBox(),
          Expanded(
            flex: widget.leading != null ? 5 : 1,
            child: widget.leading != null
                ? _titleText
                : Container(
                    child: Center(
                      child: _titleText,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// A builder widget constraining the provided action button's width values
/// to ensure no overflow will occur.
class _DialogActionButtonBuilder extends StatelessWidget {
  final double titleBarHeight;
  final BorderRadius borderRadius;
  final List<Widget> actionButtons;
  const _DialogActionButtonBuilder({
    Key? key,
    required this.titleBarHeight,
    required this.borderRadius,
    required this.actionButtons,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: titleBarHeight,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: borderRadius.bottomLeft,
                bottomRight: borderRadius.bottomRight,
              ),
              color: LitColors.lightGrey,
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.center,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  List<Widget> buttons = [];

                  /// Wrap the action buttons inside a sized box based on the
                  /// available space.
                  for (Widget button in actionButtons) {
                    buttons.add(
                      SizedBox(
                        width: constraints.maxWidth / actionButtons.length,
                        child: button,
                      ),
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: buttons,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
