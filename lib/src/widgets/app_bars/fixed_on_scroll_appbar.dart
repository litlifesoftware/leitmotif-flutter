import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A [CustomAppBar] widget displaying an app bar.
///
/// Only if the corresponding [ScrollController] property registers a scroll action,
/// the app bar will be shown by playing its animation forward. If the scroll offset is
/// below the threshold (scroll up), the app bar will be animated in reverse, therefore
/// removing it from the visible area.
class FixedOnScrollAppbar extends StatefulWidget implements CustomAppBar {
  /// The [ScrollController]'s scroll offset will state whether to animate the app bar.
  final ScrollController? scrollController;

  /// The offset required to trigger the app bar to appear. It defaults to 50.0.
  final double maxScrollOffset;

  /// The background color of the app bar. It defaults to [Colors.white].
  final Color backgroundColor;
  final List<BoxShadow> boxShadow;

  /// The height of the app bar. It defaults to [CustomAppBar.height].
  final double height;
  final Widget child;
  final EdgeInsets padding;

  //
  final bool shouldNavigateBack;
  final void Function()? onInvalidNavigation;

  /// Creates a [FixedOnScrollAppbar] widget.
  /// The [ScrollController] is required in order to register a scroll change.
  const FixedOnScrollAppbar({
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
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
    this.shouldNavigateBack = true,
    this.onInvalidNavigation,
  }) : super(key: key);

  @override
  _FixedOnScrollAppbarState createState() => _FixedOnScrollAppbarState();
}

class _FixedOnScrollAppbarState extends State<FixedOnScrollAppbar>
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
    return AnimatedBuilder(
      animation: _animationOnScrollController.animationController,
      builder: (context, _) {
        return AnimatedOpacity(
          duration: _animationOnScrollController.animationController.duration!,
          opacity: _animationOnScrollController.animationController.value,
          child: Transform(
            transform: Matrix4.translationValues(
                0,
                -widget.height +
                    (widget.height *
                        _animationOnScrollController.animationController.value),
                0),
            child: Container(
              height: widget.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                boxShadow: widget.boxShadow,
              ),
              padding: widget.padding,
              child: Navigator.canPop(context)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LitBackButton(
                          iconColor: LitColors.mediumGrey,
                          backgroundColor: Colors.grey[200],
                          shouldNavigateBack: widget.shouldNavigateBack,
                          onInvalidNavigation: widget.onInvalidNavigation,
                        ),
                        widget.child,
                      ],
                    )
                  : widget.child,
            ),
          ),
        );
      },
    );
  }
}
