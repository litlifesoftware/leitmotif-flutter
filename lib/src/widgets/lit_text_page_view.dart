import 'package:flutter/material.dart';
import 'package:leitmotif/localization.dart';
import 'package:leitmotif/models.dart';
import 'package:leitmotif/styles.dart';
import 'package:leitmotif/widgets.dart';

/// A Leitmotif widget allowing to display multiple text boxes inside a single
/// navigatable page view.
class LitTextPageView extends StatefulWidget {
  /// The text pages displayed on the card.
  final List<TextPageContent> textItems;

  /// The `next` button's label.
  final String? nextButtonLabel;

  /// The card's border radius.
  final BorderRadius borderRadius;

  /// The animation's duration.
  final Duration animationDuration;

  /// The outer padding applied to the card.
  final EdgeInsets padding;
  const LitTextPageView({
    Key? key,
    required this.textItems,
    this.borderRadius = LitBorderRadius.card,
    this.animationDuration = LitAnimationDurations.button,
    this.padding = LitEdgeInsets.none,
    this.nextButtonLabel,
  }) : super(key: key);

  @override
  _LitTextPageViewState createState() => _LitTextPageViewState();
}

class _LitTextPageViewState extends State<LitTextPageView>
    with TickerProviderStateMixin {
  /// Animates the page transition.
  late AnimationController _animationController;

  /// The currently selected text item.
  int selectedIdx = 0;

  /// States whether flipping to the next page is possible.
  bool get _canFlip => selectedIdx < (widget.textItems.length - 1);

  /// Selects the next page if available or selects the first page if no next
  /// page is available.
  void _selectNext() {
    setState(
      () => _canFlip ? selectedIdx++ : selectedIdx = 0,
    );
  }

  /// Handles the `next` action by selected the next page.
  void _onPressed() {
    _animationController.reverse().then(
          (_) => _animationController.forward(),
        );
    _selectNext();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Card(
      padding: widget.padding,
      animationController: _animationController,
      text: widget.textItems[selectedIdx],
      nextButtonLabel: widget.nextButtonLabel,
      animationDuration: widget.animationDuration,
      borderRadius: widget.borderRadius,
      onPressed: _onPressed,
    );
  }
}

/// A card displaying the currently selected text page.
class _Card extends StatelessWidget {
  final AnimationController animationController;
  final TextPageContent text;
  final String? nextButtonLabel;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final void Function() onPressed;
  final Duration animationDuration;
  final double initialScale;
  final double animatedScale;
  const _Card({
    Key? key,
    required this.animationController,
    required this.text,
    required this.nextButtonLabel,
    required this.borderRadius,
    required this.padding,
    required this.onPressed,
    required this.animationDuration,
    this.initialScale = 1.00,
    this.animatedScale = 1.05,
  }) : super(key: key);

  /// Returns an animated transform matrix.
  ///
  /// Only scales on the vertical axis.
  Matrix4 get _transform {
    final double y = animatedScale -
        ((animatedScale - initialScale) * animationController.value);
    return Matrix4.identity()..scale(initialScale, y);
  }

  /// Returns an animated opacity.
  double get _opacity {
    return 0.75 + 0.25 * animationController.value;
  }

  /// Evaluates whether custom localizations are available.
  bool get _l10nAvail {
    return nextButtonLabel != null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: AnimatedBuilder(
        animation: animationController,
        child: LitTitledActionCard(
          title: text.title,
          subtitle: text.subtitle,
          child: _CardContent(
            text: text,
            onPressed: onPressed,
          ),
          actionButtonData: [
            ActionButtonData(
              title: _l10nAvail
                  ? nextButtonLabel!
                  : LeitmotifLocalizations.of(context).nextLabel,
              onPressed: onPressed,
            )
          ],
        ),
        builder: (context, child) {
          return Transform(
            transform: _transform,
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: animationDuration,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

/// The page's text content.
class _CardContent extends StatelessWidget {
  final TextPageContent text;
  final void Function() onPressed;
  const _CardContent({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: LitEdgeInsets.card.top),
        Text(
          text.text,
          style: LitSansSerifStyles.body2,
        ),
      ],
    );
  }
}
