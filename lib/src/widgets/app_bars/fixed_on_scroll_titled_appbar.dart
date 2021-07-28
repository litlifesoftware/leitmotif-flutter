import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';
import 'package:leitmotif/src/widgets/app_bars/fixed_on_scroll_appbar.dart';

/// A [CustomAppBar] widget displaying an app bar.
///
/// Only if the corresponding [ScrollController] property registers a scroll action,
/// the app bar will be shown by playing its animation forward. If the scroll offset is
/// below the threshold (scroll up), the app bar will be animated in reverse, therefore
/// removing it from the visible area.
class FixedOnScrollTitledAppbar extends StatefulWidget implements CustomAppBar {
  /// The [ScrollController]'s scroll offset will state whether to animate the app bar.
  final ScrollController? scrollController;

  /// The offset required to trigger the app bar to appear. It defaults to 50.0.
  final double maxScrollOffset;

  /// The background color of the app bar. It defaults to [Colors.white].
  final Color backgroundColor;
  final List<BoxShadow> boxShadow;

  /// The height of the app bar. It defaults to [CustomAppBar.height].
  final double height;
  final String title;
  final EdgeInsets padding;

  final Color backButtonBackgroundColor;
  final Color backButtonIconColor;

  final TextStyle textStyle;

  //
  final bool shouldNavigateBack;
  final void Function()? onInvalidNavigation;

  /// Creates a [FixedOnScrollTitledAppbar] widget.
  /// The [ScrollController] is required in order to register a scroll change.
  const FixedOnScrollTitledAppbar({
    Key? key,
    required this.scrollController,
    this.maxScrollOffset = 50.0,
    this.backgroundColor = Colors.white,
    this.boxShadow = const [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 12.0,
        offset: Offset(0, 2),
        spreadRadius: 1.0,
      )
    ],
    this.height = CustomAppBar.height,
    required this.title,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
    this.backButtonBackgroundColor =
        LitBackButtonDefaultStyling.backgroundColor,
    this.backButtonIconColor = LitBackButtonDefaultStyling.iconColor,
    this.textStyle = LitSansSerifStyles.subtitle2,
    this.shouldNavigateBack = true,
    this.onInvalidNavigation,
  }) : super(key: key);

  @override
  _FixedOnScrollTitledAppbarState createState() =>
      _FixedOnScrollTitledAppbarState();
}

class _FixedOnScrollTitledAppbarState extends State<FixedOnScrollTitledAppbar>
    with TickerProviderStateMixin {
  late AnimationOnScrollController _animationOnScrollController;

  @override
  void initState() {
    super.initState();
    _animationOnScrollController = AnimationOnScrollController(
      scrollController: widget.scrollController,
      requiredScrollOffset: 16.0,
      direction: AnimationDirection.forward,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationOnScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FixedOnScrollAppbar(
      scrollController: widget.scrollController,
      backButtonBackgroundColor: widget.backButtonBackgroundColor,
      backButtonIconColor: widget.backButtonIconColor,
      backgroundColor: widget.backgroundColor,
      boxShadow: widget.boxShadow,
      height: widget.height,
      maxScrollOffset: widget.maxScrollOffset,
      onInvalidNavigation: widget.onInvalidNavigation,
      padding: widget.padding,
      shouldNavigateBack: widget.shouldNavigateBack,
      child: _Title(title: widget.title, style: widget.textStyle),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  final TextStyle style;
  const _Title({
    Key? key,
    required this.title,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: ClippedText(
            title,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
      ),
    );
  }
}
