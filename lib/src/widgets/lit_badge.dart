part of widgets;

/// A Leitmotif widget displaying the provided [child] inside a badge.
class LitBadge extends StatelessWidget {
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final Widget child;

  /// Creates a [LitBadge].
  const LitBadge({
    Key? key,
    this.backgroundColor = LitColors.mediumGrey,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(16.0),
    ),
    required this.child,
    this.padding = const EdgeInsets.symmetric(
      vertical: 2.0,
      horizontal: 8.0,
    ),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
