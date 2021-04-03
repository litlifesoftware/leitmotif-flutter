import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class LitCreditsScreen extends StatefulWidget {
  final String title;
  final Widget art;
  final List<CreditContent> credits;
  final Duration animationDuration;
  const LitCreditsScreen({
    Key? key,
    this.title = "Credits",
    this.art = const SizedBox(),
    required this.credits,
    this.animationDuration = const Duration(milliseconds: 5000),
  }) : super(key: key);
  @override
  _LitCreditsScreenState createState() => _LitCreditsScreenState();
}

class _LitCreditsScreenState extends State<LitCreditsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late ScrollController _scrollController;
  bool _animationStopped = false;
  double _currentScrollOffset = 0.0;
  double _maxScrollExtent = 0.0;
  void stopAnimation() {
    setState(() {
      _animationStopped = true;
    });
  }

  void setCurrentScrollOffset() {
    setState(() {
      _currentScrollOffset = _scrollController.offset;
    });
  }

  void _syncScrollToAnimation() {
    if (_animationController.value < 1.0) {
      if (!_animationStopped) {
        _scrollController.animateTo(
          (_scrollController.position.maxScrollExtent *
              _animationController.value),
          duration: widget.animationDuration,
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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
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
      appBar: LitAppBar(title: widget.title),
      body: GestureDetector(
        onVerticalDragCancel: stopAnimation,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: const [
                    const Color(0xFFDCDCDC),
                    const Color(0xFFD7D7D7),
                  ],
                ),
              ),
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
                        for (int i = 0; i < widget.credits.length; i++) {
                          list.add(_CreditItem(
                            credit: widget.credits[i],
                          ));
                        }
                        return ScrollableColumn(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(
                            vertical: 48.0,
                          ),
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: list,
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
  final CreditContent credit;
  const _CreditItem({
    Key? key,
    required this.credit,
  }) : super(key: key);

  @override
  __CreditItemState createState() => __CreditItemState();
}

class __CreditItemState extends State<_CreditItem> {
  Widget _buildNameItem(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
      ),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: LitTextStyles.sansSerifSubHeader.copyWith(
          color: Color(
            0xFF7e7e7e,
          ),
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
            color: Color(0xFFB0B0B0),
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

class CreditContent {
  final String role;
  final List<String> names;
  const CreditContent({
    required this.role,
    required this.names,
  });
}
