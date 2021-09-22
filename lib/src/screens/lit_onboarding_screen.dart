import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class LitOnboardingScreen extends StatefulWidget {
  final String title;
  final String nextButtonLabel;
  final Widget art;
  final List<TextPageContent> textItems;
  final BoxDecoration backgroundDecoration;
  final Duration animationDuration;
  final EdgeInsets cardPadding;
  final void Function() onExit;
  const LitOnboardingScreen({
    Key? key,
    this.title = "Onboading",
    this.nextButtonLabel = "Next",
    this.art = const SizedBox(),
    required this.textItems,
    this.backgroundDecoration = const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          const Color(0xFFc6c6c6),
          const Color(0xFFC18F8F),
        ],
      ),
    ),
    this.animationDuration = const Duration(milliseconds: 120),
    this.cardPadding = const EdgeInsets.only(
      top: 128.0,
      bottom: 64.0,
    ),
    required this.onExit,
  }) : super(key: key);

  @override
  _LitOnboardingScreenState createState() => _LitOnboardingScreenState();
}

class _LitOnboardingScreenState extends State<LitOnboardingScreen>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      appBar: FixedOnScrollTitledAppbar(
        scrollController: _scrollController,
        title: widget.title,
      ),
      body: Stack(
        children: [
          Container(
            decoration: widget.backgroundDecoration,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LitTextPageView(
              middleLayer: widget.art,
              textItems: widget.textItems,
              padding: widget.cardPadding,
              animationDuration: widget.animationDuration,
              nextButtonLabel: widget.nextButtonLabel,
            ),
          ),
          AnimatedActionButton(
            onPressed: widget.onExit,
            alignment: Alignment.bottomLeft,
            child: Icon(
              LitIcons.times,
              color: LitColors.mediumGrey,
              size: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
