import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `dialog` widget displaying the provided [child] on inside a
/// titled dialog.
class LitTitledDialog extends StatefulWidget {
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
  final Duration animationDuration;

  /// Creates a [LitTitledDialog].
  const LitTitledDialog({
    Key? key,
    this.titleBarHeight = 52.0,
    this.borderRadius = const BorderRadius.all(
      const Radius.circular(24.0),
    ),
    required this.child,
    this.titleGradient = LitGradients.lightGreyGradient,
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
    this.animationDuration = const Duration(
      milliseconds: 180,
    ),
  }) : super(key: key);

  @override
  _LitTitledDialogState createState() => _LitTitledDialogState();
}

class _LitTitledDialogState extends State<LitTitledDialog>
    with TickerProviderStateMixin {
  /// Default scale
  static const double defSc = 1.0;

  /// Animation scale
  static const double anmSc = 1.25;
  late AnimationController _anmCon;

  /// Returns the currently animated transform.
  Matrix4 get _transform {
    final double x = defSc;
    final double y = anmSc - ((anmSc - defSc) * _anmCon.value);
    return Matrix4.identity()..scale(x, y);
  }

  /// Returns the currently animated opacity.
  double get _opacity {
    return 0.5 + 0.5 * _anmCon.value;
  }

  /// Returns the dialog's content minimum height.
  double _minHeight(BoxConstraints constraints) {
    return (widget.minHeight - (2 * widget.titleBarHeight));
  }

  /// Returns the dialog's content maximum width.
  double _maxWidth(BoxConstraints constraints) {
    return constraints.maxWidth > widget.maxWidth
        ? widget.maxWidth
        : constraints.maxWidth;
  }

  @override
  void initState() {
    _anmCon = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _anmCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anmCon,
      builder: (context, _) {
        return AnimatedOpacity(
          opacity: _opacity,
          duration: _anmCon.duration!,
          child: Transform(
            transform: _transform,
            child: Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: widget.borderRadius,
              ),
              elevation: 0.0,
              child: ClipRRect(
                borderRadius: widget.borderRadius,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: widget.minHeight,
                        maxWidth: _maxWidth(constraints),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _DialogTopBar(
                            titleBarHeight: widget.titleBarHeight,
                            borderRadius: widget.borderRadius,
                            titleGradient: widget.titleGradient,
                            elevated: widget.elevated,
                            titleText: widget.titleText,
                            titleTextColor: widget.titleTextColor,
                            leading: widget.leading,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: _minHeight(constraints),
                              maxWidth: _maxWidth(constraints),
                            ),
                            child: Padding(
                              padding: widget.margin,
                              child: widget.child,
                            ),
                          ),
                          widget.actionButtons.isNotEmpty
                              ? _DialogActionButtonBuilder(
                                  titleBarHeight: widget.titleBarHeight,
                                  borderRadius: widget.borderRadius,
                                  actionButtons: widget.actionButtons,
                                )
                              : SizedBox(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DialogTopBarLabel extends StatelessWidget {
  final String title;
  final Color textColor;
  const _DialogTopBarLabel({
    Key? key,
    required this.title,
    required this.textColor,
  }) : super(key: key);
  static const EdgeInsets padding = const EdgeInsets.symmetric(
    horizontal: 24.0,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ClippedText(
        title,
        textAlign: TextAlign.right,
        style: LitSansSerifStyles.subtitle2.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}

/// The [LitTitledDialog]'s top bar displaying the dialog's title.
class _DialogTopBar extends StatelessWidget {
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

  static const List<BoxShadow> _elevatedBoxShadow = [
    const BoxShadow(
      color: Colors.black38,
      blurRadius: 14.0,
      offset: Offset(0.0, -2.0),
      spreadRadius: 1.0,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: titleBarHeight,
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: borderRadius.topLeft,
          topRight: borderRadius.topRight,
        ),
        gradient: titleGradient,
        boxShadow: elevated ? _DialogTopBar._elevatedBoxShadow : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          leading != null
              ? Expanded(
                  flex: 2,
                  child: Container(
                    height: titleBarHeight,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: leading,
                    ),
                  ),
                )
              : SizedBox(),
          Expanded(
            flex: leading != null ? 4 : 1,
            child: leading != null
                ? _DialogTopBarLabel(
                    title: titleText,
                    textColor: titleTextColor,
                  )
                : Container(
                    child: Center(
                      child: _DialogTopBarLabel(
                        title: titleText,
                        textColor: titleTextColor,
                      ),
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
              color: Color(0xFFEEEEEE),
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
