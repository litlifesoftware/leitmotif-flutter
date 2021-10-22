import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// The [LitCreditsScreen]'s `Localization`.
///
/// Contains the localized strings used on the screen.
class LitCreditsScreenLocalization {
  final String title;

  /// Createst a [LitCreditsScreenLocalization].
  const LitCreditsScreenLocalization({
    required this.title,
  });
}

/// A Leitmotif `screen` widget showing all persons or entities involved in
/// developing an app.
class LitCreditsScreen extends StatefulWidget {
  final LitCreditsScreenLocalization? localization;
  final String appName;
  final String? appDescription;
  final Widget art;
  final List<CreditData> credits;
  final BoxDecoration backgroundDecoration;
  final Duration animationDuration;

  /// Creates a [LitCreditsScreen].
  const LitCreditsScreen({
    Key? key,
    this.localization,
    required this.appName,
    this.appDescription,
    this.art = const SizedBox(),
    required this.credits,
    this.backgroundDecoration = const BoxDecoration(
      gradient: LitGradients.lightGreyGradient,
    ),
    this.animationDuration = const Duration(milliseconds: 350),
  }) : super(key: key);
  @override
  _LitCreditsScreenState createState() => _LitCreditsScreenState();
}

class _LitCreditsScreenState extends State<LitCreditsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late LitTweenController _tweenController;
  late ScrollController _scrollController;

  /// States whether the custom localizations are available.
  bool get _l10nAvail {
    return widget.localization != null;
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..forward();
    _tweenController = LitTweenController(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      appBar: FixedOnScrollTitledAppbar(
        scrollController: _scrollController,
        title: _l10nAvail
            ? widget.localization!.title
            : LeitmotifLocalizations.of(context).creditsLabel,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: widget.backgroundDecoration,
          ),
          Container(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: 256.0,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return AnimatedBuilder(
                    animation: _animationController,
                    builder: (_context, _) {
                      return _AnimatedContent(
                        animationController: _animationController,
                        tweenController: _tweenController,
                        scrollController: _scrollController,
                        appDescription: widget.appDescription,
                        appName: widget.appName,
                        art: widget.art,
                        credits: widget.credits,
                      );
                    },
                    child: _AnimatedContent(
                      animationController: _animationController,
                      tweenController: _tweenController,
                      scrollController: _scrollController,
                      appDescription: widget.appDescription,
                      appName: widget.appName,
                      art: widget.art,
                      credits: widget.credits,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// The [LitCreditsScreen]'s animated content.
class _AnimatedContent extends StatelessWidget {
  final AnimationController animationController;
  final LitTweenController tweenController;
  final ScrollController scrollController;
  final List<CreditData> credits;
  final String appName;
  final String? appDescription;
  final Widget art;
  const _AnimatedContent({
    Key? key,
    required this.animationController,
    required this.tweenController,
    required this.scrollController,
    required this.credits,
    required this.appName,
    required this.appDescription,
    required this.art,
  }) : super(key: key);

  double get _opacity {
    return 0.5 + 0.5 * animationController.value;
  }

  Matrix4 get _transform {
    return Matrix4.translationValues(
      0,
      -30 + 30 * animationController.value,
      0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LitScrollbar(
      child: ScrollableColumn(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(
          vertical: 48.0,
          horizontal: 16.0,
        ),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 0.0,
          ),
          AnimatedOpacity(
            opacity: _opacity,
            duration: animationController.duration!,
            child: Transform(
              transform: _transform,
              child: Column(
                children: [
                  art,
                  _Title(
                    description: appDescription,
                    title: appName,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          _CreditList(
            credits: credits,
            animationController: animationController,
            tweenController: tweenController,
            opacity: _opacity,
          ),
        ],
      ),
    );
  }
}

/// A widget to the app's information.
class _Title extends StatelessWidget {
  final String title;
  final String? description;

  const _Title({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  bool get _subTitleAvailable {
    return description != "" && description != null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: LitSansSerifStyles.h5.copyWith(
              color: LitColors.grey350,
            ),
          ),
        ),
        _subTitleAvailable
            ? Column(
                children: [
                  Container(
                    color: Color(0xFFB0B0B0),
                    height: 2.0,
                    width: 32.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      description!,
                      textAlign: TextAlign.center,
                      style: LitSansSerifStyles.body2
                          .copyWith(color: LitColors.grey350),
                    ),
                  )
                ],
              )
            : SizedBox()
      ],
    );
  }
}

/// A widget displaying a list of credit items.
class _CreditList extends StatelessWidget {
  final AnimationController animationController;
  final LitTweenController tweenController;
  final List<CreditData> credits;
  final double opacity;
  const _CreditList({
    Key? key,
    required this.animationController,
    required this.tweenController,
    required this.credits,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        List<Widget> items = [];
        for (int i = 0; i < credits.length; i++) {
          items.add(
            AnimatedOpacity(
              duration: animationController.duration!,
              opacity: opacity,
              child: Transform(
                transform: tweenController.listItemTransform(
                  i,
                  credits.length,
                  y: 75.0,
                ),
                child: _CreditItem(
                  credit: credits[i],
                  animationController: animationController,
                ),
              ),
            ),
          );
        }
        return Column(
          children: items,
        );
      },
    );
  }
}

/// A widget displaying the role and names of the provided [CreditData].
class _CreditItem extends StatelessWidget {
  final AnimationController animationController;
  final CreditData credit;

  const _CreditItem({
    Key? key,
    required this.animationController,
    required this.credit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: animationController.value,
      duration: animationController.duration!,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Text(
              credit.role,
              textAlign: TextAlign.center,
              style: LitSansSerifStyles.body2.copyWith(
                color: LitColors.grey350,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Builder(
              builder: (context) {
                List<Widget> _nameItems = [];
                for (String name in credit.names) {
                  _nameItems.add(
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                      ),
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        style: LitSansSerifStyles.h5.copyWith(
                          color: LitColors.grey400,
                        ),
                      ),
                    ),
                  );
                }
                return Column(
                  children: _nameItems,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
