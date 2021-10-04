import 'package:flutter/material.dart';
import 'package:leitmotif/containers.dart';
import 'package:leitmotif/leitmotif.dart';
import 'package:leitmotif/styles.dart';

class LitTextPageView extends StatefulWidget {
  final String nextButtonLabel;
  final List<TextPageContent> textItems;
  final BorderRadius cardBorderRadius;
  final Duration animationDuration;
  final EdgeInsets padding;
  final Widget middleLayer;
  const LitTextPageView({
    Key? key,
    this.nextButtonLabel = "NEXT",
    required this.textItems,
    this.cardBorderRadius = const BorderRadius.all(
      Radius.circular(24.0),
    ),
    this.animationDuration = const Duration(milliseconds: 120),
    this.padding = const EdgeInsets.all(0.0),
    this.middleLayer = const SizedBox(),
  }) : super(key: key);

  @override
  _LitTextPageViewState createState() => _LitTextPageViewState();
}

class _LitTextPageViewState extends State<LitTextPageView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late ScrollController _scrollController;
  int selectedTextItem = 0;

  void _performPageTransition() {
    if (selectedTextItem < (widget.textItems.length - 1)) {
      setState(() {
        selectedTextItem++;
      });
    } else {
      setState(() {
        selectedTextItem = 0;
      });
    }
  }

  void _onPressed() {
    _animationController
        .reverse()
        .then((value) => _animationController.forward());
    _performPageTransition();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animationController.forward();
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
      text: widget.textItems[selectedTextItem],
      nextButtonLabel: widget.nextButtonLabel,
      // middleLayer: widget.middleLayer,
      buttonAnimationDuration: widget.animationDuration,
      borderRadius: widget.cardBorderRadius,
      onPressed: _onPressed,
    );
  }
}

class _Card extends StatefulWidget {
  final AnimationController animationController;
  final TextPageContent text;
  final String nextButtonLabel;
  final BorderRadius borderRadius;
  // final Widget middleLayer;
  final EdgeInsets padding;
  final void Function() onPressed;
  final double horizontalTransform;
  final Duration buttonAnimationDuration;
  final double initialScale;
  final double animatedScale;
  const _Card({
    Key? key,
    required this.animationController,
    required this.text,
    required this.nextButtonLabel,
    required this.borderRadius,
    // required this.middleLayer,
    required this.padding,
    required this.onPressed,
    this.horizontalTransform = 60.0,
    required this.buttonAnimationDuration,
    this.initialScale = 1.00,
    this.animatedScale = 1.05,
  }) : super(key: key);

  @override
  __CardState createState() => __CardState();
}

class __CardState extends State<_Card> {
  Matrix4 get _transform {
    final double _x = widget.initialScale;
    final double _y = widget.animatedScale -
        ((widget.animatedScale - widget.initialScale) *
            widget.animationController.value);
    return Matrix4.identity()..scale(_x, _y);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: AnimatedBuilder(
        animation: widget.animationController,
        builder: (context, _) {
          return Transform(
            transform: _transform,
            child: LitTitledActionCard(
              title: widget.text.title,
              subtitle: widget.text.subtitle,
              child: _CardContent(
                text: widget.text,
                nextButtonLabel: widget.nextButtonLabel,
                buttonAnimationDuration: widget.buttonAnimationDuration,
                onPressed: widget.onPressed,
              ),
              actionButtonData: [
                ActionButtonData(
                  title: widget.nextButtonLabel,
                  onPressed: widget.onPressed,
                  backgroundColor: Colors.white,
                  accentColor: Colors.white,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final TextPageContent text;
  final String nextButtonLabel;
  final Duration buttonAnimationDuration;
  final void Function() onPressed;
  const _CardContent({
    Key? key,
    required this.text,
    required this.nextButtonLabel,
    required this.buttonAnimationDuration,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 8.0,
        ),
        Text(
          text.text,
          style: LitSansSerifStyles.body2,
        ),
      ],
    );
  }
}

/// A model class to describe text page's card content. The card will display a
/// subtitle, a title and a description text.
class TextPageContent {
  final String? subtitle;
  final String title;
  final String text;

  /// Creates a [TextPageContent] data object.
  const TextPageContent({
    this.subtitle,
    required this.title,
    required this.text,
  });
}
