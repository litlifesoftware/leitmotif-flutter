import 'package:flutter/widgets.dart';

/// A widgets that wrapps the provided children inside a column, which then is wrapped
/// inside a scroll view to allow scrolling through children.
///
/// The arguments should match the default [Column]'s arguments. The default minimun
/// height is set using a constrained box. The constrains are set to fill the screen's
/// height at minimum. If the column's height should be lower than the device's height,
/// pass a [verticalCut] value to decrease the constraint's minimum height by the
/// provided value.
class ScrollableColumn extends StatelessWidget {
  /// The [ScrollController] to controll the scroll interaction.
  final ScrollController? controller;

  /// The scrolling behavior.
  final ScrollPhysics physics;

  /// The list of widgets to be displayed in the column.
  final List<Widget> children;

  /// The vertical alignment.
  final MainAxisAlignment mainAxisAlignment;

  /// The horizontal alignment.
  final CrossAxisAlignment crossAxisAlignment;

  /// The vertical size. The vertical size might be larger then intended due to the
  /// constrained box's minumum height is set to the screen's height.
  final MainAxisSize mainAxisSize;

  /// The text base alignment.
  final TextBaseline textBaseline;

  /// The text direction.
  final TextDirection textDirection;

  /// The vertical direction.
  final VerticalDirection verticalDirection;

  /// The inner padding wrapping the children.
  final EdgeInsets padding;

  /// States whether to reverse the scroll input.
  final bool reverse;

  /// The vertical cut which will be subtracted from the constrain's minimum height.
  final double verticalCut;

  /// Creates a [ScrollableColumn].
  ///
  /// * [controller] is the [ScrollController] passed onto the scroll view.
  ///
  /// * [physics] is the [ScrollPhysics] which specifies the scroll behavior on the scroll
  ///   view. This will be set to [BouncingScrollPhysics] by default to implement the
  ///   Cupertino-styled design.
  ///
  /// * [mainAxisAlignment] is the vertical aligment of the children.
  ///
  /// * [crossAxisAlignment] is the horizontal aligment of the children.
  ///
  /// * [mainAxisSize] defines the height of the column. If a high [verticalCut] value is
  ///   defined to lower the size of the column, the [mainAxisSize] might then be set to
  ///   min.
  ///
  /// * [textBaseline] is the text base alignment.
  ///
  /// * [textDirection] is the direction in the text should be displayed in.
  ///
  /// * [padding] is the inner padding of the scroll view wrapping the children.
  ///
  /// * [reverse] states whether to reverse scroll view's scroll direction.
  ///
  /// * [verticalCut] is the vertical cut which will decrease the overall column height. The
  ///   column's constrains are set to the screen's height. If the column height should be
  ///   lower than the screen's height, the [verticalCut] should be set to the amount of
  ///   pixels, that should be subtracted from the overall box constraints (height).
  const ScrollableColumn({
    Key? key,
    this.controller,
    this.physics = const BouncingScrollPhysics(),
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.textBaseline = TextBaseline.alphabetic,
    this.textDirection = TextDirection.ltr,
    this.verticalDirection = VerticalDirection.down,
    this.padding = const EdgeInsets.all(0.0),
    this.reverse = false,
    this.verticalCut = 0.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      reverse: reverse,
      physics: physics,
      scrollDirection: Axis.vertical,
      padding: padding,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - verticalCut,
        ),
        child: Column(
          children: children,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          textBaseline: textBaseline,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
        ),
      ),
    );
  }
}
