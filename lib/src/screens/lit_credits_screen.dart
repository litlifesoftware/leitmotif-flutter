import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class LitCreditsScreen extends StatefulWidget {
  final String screenTitle;
  final String appTitle;
  final String? subTitle;
  final Widget art;
  final List<CreditData> credits;
  final Duration? animationDuration;
  final bool darkMode;
  final bool alignAppBarTitleRight;
  final bool autoScroll;
  const LitCreditsScreen({
    Key? key,
    this.screenTitle = "Credits",
    required this.appTitle,
    this.subTitle,
    this.art = const SizedBox(),
    required this.credits,
    this.animationDuration,
    this.darkMode = false,
    this.alignAppBarTitleRight = false,
    this.autoScroll = false,
  }) : super(key: key);
  @override
  _LitCreditsScreenState createState() => _LitCreditsScreenState();
}

class _LitCreditsScreenState extends State<LitCreditsScreen>
    with TickerProviderStateMixin {
  final int millisecPerCredit = 1000;
  late AnimationController _animationController;
  late ScrollController _scrollController;
  bool _animationStopped = false;

  Duration get _animationDuration {
    return widget.animationDuration ??
        Duration(milliseconds: millisecPerCredit * widget.credits.length);
  }

  bool get _shouldAutoScroll {
    bool extendedListView = (_scrollController.position.maxScrollExtent >
        (MediaQuery.of(context).size.height / 2));
    return extendedListView && widget.autoScroll;
  }

  void stopAnimation() {
    setState(() {
      _animationStopped = true;
    });
  }

  void _syncScrollToAnimation() {
    if (_shouldAutoScroll) {
      if (_animationController.value < 1.0) {
        if (!_animationStopped) {
          _scrollController.animateTo(
            (_scrollController.position.maxScrollExtent *
                _animationController.value),
            duration: _animationDuration,
            curve: Curves.ease,
          );
        }
      } else {
        if (!_animationStopped) {
          _scrollController.animateTo(
            (0.0),
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
      }
    }
  }

  Color get _backgroundColor {
    return widget.darkMode ? Color(0xFF333333) : LitColors.lightGrey;
  }

  BoxDecoration get _backgroundDecoration {
    return widget.darkMode
        ? const BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: const [
                const Color(0xAF142B33),
                const Color(0xBF152536),
              ],
            ),
          )
        : const BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: const [
                const Color(0xFFDCDCDC),
                const Color(0xFFD7D7D7),
              ],
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _scrollController = ScrollController();
    _animationController.addListener(_syncScrollToAnimation);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitScaffold(
      backgroundColor: _backgroundColor,
      appBar: LitAppBar(
        alignRight: widget.alignAppBarTitleRight,
        title: widget.screenTitle,
        backgroundColor: _backgroundColor,
        backButtonBackgroundColor: LitColors.mediumGrey,
        backButtonIconColor: LitColors.lightGrey,
      ),
      body: GestureDetector(
        onVerticalDragCancel: stopAnimation,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: _backgroundDecoration,
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
                        List<Widget> list = [];
                        list.add(
                          SizedBox(
                            // height: _animationController.value < 1.0
                            //     ? _scrollController.position.maxScrollExtent *
                            //         _animationController.value
                            //     : 0.0,
                            height: 0.0,
                          ),
                        );
                        list.add(widget.art);
                        list.add(
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              widget.appTitle,
                              style: LitTextStyles.sansSerifSubHeader.copyWith(
                                color: Color(
                                  0xFF7e7e7e,
                                ),
                              ),
                            ),
                          ),
                        );
                        if (widget.subTitle != "" && widget.subTitle != null) {
                          list.add(
                            Column(
                              children: [
                                Container(
                                  color: Color(0xFFB0B0B0),
                                  height: 2.0,
                                  width: 32.0,
                                ),
                                Text(
                                  "${widget.subTitle}",
                                  textAlign: TextAlign.center,
                                  style: LitTextStyles
                                      .sansSerifBodyTighterSmaller
                                      .copyWith(
                                    color: Color(0xFFB0B0B0),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        for (int i = 0; i < widget.credits.length; i++) {
                          list.add(
                            _CreditItem(
                              credit: widget.credits[i],
                              darkMode: widget.darkMode,
                            ),
                          );
                        }
                        return LitScrollbar(
                          child: ScrollableColumn(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(
                              vertical: 48.0,
                            ),
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: list,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CreditItem extends StatefulWidget {
  final CreditData credit;
  final bool darkMode;
  const _CreditItem({
    Key? key,
    required this.credit,
    required this.darkMode,
  }) : super(key: key);

  @override
  __CreditItemState createState() => __CreditItemState();
}

class __CreditItemState extends State<_CreditItem> {
  Color get _roleTextColor {
    return widget.darkMode ? Colors.white54 : Color(0xFFB0B0B0);
  }

  Color get _nameTextColor {
    return widget.darkMode ? Colors.white : Color(0xFF7e7e7e);
  }

  Widget _buildNameItem(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
      ),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: LitTextStyles.sansSerifSubHeader.copyWith(
          color: _nameTextColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(children: [
        Text(
          widget.credit.role,
          textAlign: TextAlign.center,
          style: LitTextStyles.sansSerifBody.copyWith(
            color: _roleTextColor,
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        Builder(builder: (context) {
          List<Widget> _nameItems = [];
          for (String name in widget.credit.names) {
            _nameItems.add(_buildNameItem(name));
          }
          return Column(
            children: _nameItems,
          );
        })
      ]),
    );
  }
}

class CreditData {
  final String role;
  final List<String> names;
  const CreditData({
    required this.role,
    required this.names,
  });
}
