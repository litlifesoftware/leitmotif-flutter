import 'package:flutter/widgets.dart';

class ScrollableColumn extends StatelessWidget {
  final ScrollController controller;
  final ScrollPhysics physics;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextBaseline textBaseline;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final EdgeInsets padding;
  final bool reverse;
  const ScrollableColumn({
    Key key,
    this.controller,
    this.physics = const BouncingScrollPhysics(),
    @required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.textBaseline = TextBaseline.alphabetic,
    this.textDirection = TextDirection.ltr,
    this.verticalDirection = VerticalDirection.down,
    this.padding = const EdgeInsets.all(0.0),
    this.reverse = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      reverse: reverse,
      physics: physics,
      scrollDirection: Axis.vertical,
      padding: padding,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
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
