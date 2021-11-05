import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `screen` widget showing all persons or entities involved in
/// the app's development process.
class LitCreditsScreen extends StatefulWidget {
  /// The screen' localization.
  final String? title;
  final String appName;
  final String? appDescription;
  final Widget art;
  final bool showCopyrightNotice;
  final List<CreditData> credits;
  final BoxDecoration backgroundDecoration;
  final Duration animationDuration;

  /// Creates a [LitCreditsScreen].
  const LitCreditsScreen({
    Key? key,
    this.title,
    required this.appName,
    this.appDescription,
    this.art = const SizedBox(),
    this.showCopyrightNotice = true,
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

  double get _opacity {
    return 0.5 + 0.5 * _animationController.value;
  }

  Matrix4 get _transform {
    return Matrix4.translationValues(
      0,
      -30 + 30 * _animationController.value,
      0,
    );
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
        title: widget.title ?? LeitmotifLocalizations.of(context).creditsLabel,
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
                  return LitScrollbar(
                    child: ScrollableColumn(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        vertical: 48.0,
                        horizontal: 16.0,
                      ),
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 0.0,
                        ),
                        AnimatedBuilder(
                          animation: _animationController,
                          child: Column(
                            children: [
                              widget.art,
                              _Title(
                                description: widget.appDescription,
                                title: widget.appName,
                              ),
                              (widget.showCopyrightNotice)
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        '\u00a9' +
                                            ' ' +
                                            DateTime.now().year.toString(),
                                        style: LitSansSerifStyles.caption
                                            .copyWith(),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                          builder: (context, child) {
                            return AnimatedOpacity(
                              opacity: _opacity,
                              duration: _animationController.duration!,
                              child: Transform(
                                transform: _transform,
                                child: child,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Builder(
                          builder: (context) {
                            List<Widget> items = [];
                            for (int i = 0; i < widget.credits.length; i++) {
                              items.add(
                                AnimatedBuilder(
                                  animation: _animationController,
                                  child: _CreditItem(
                                    credit: widget.credits[i],
                                  ),
                                  builder: (context, child) {
                                    return AnimatedOpacity(
                                      duration: _animationController.duration!,
                                      opacity: _opacity,
                                      child: Transform(
                                        transform:
                                            _tweenController.listItemTransform(
                                          i,
                                          widget.credits.length,
                                          y: 75.0,
                                        ),
                                        child: child,
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            return Column(
                              children: items,
                            );
                          },
                        ),
                      ],
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

/// A widget displaying the role and names of the provided [CreditData].
class _CreditItem extends StatelessWidget {
  final CreditData credit;

  const _CreditItem({
    Key? key,
    required this.credit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
