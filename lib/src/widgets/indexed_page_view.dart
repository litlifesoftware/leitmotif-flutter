import 'package:flutter/material.dart';

/// A widget to display the provided [children] inside a [PageView].
///
/// The [PageView] displays indicators to visualize the current page
/// position.
class IndexedPageView extends StatefulWidget {
  /// The height of the page content is fixed to ensure the content has a
  /// size.
  final double height;
  final List<Widget> children;
  final ScrollPhysics physics;
  final Color indicatorColor;
  final double indicatorSpacingTop;

  /// States whether to navigate to the next or previous page if the page view
  /// is tapped on.
  final bool tapToNavigate;

  /// An additional listener to return the current page scroll offset
  /// to the parent widget.
  final void Function(double? offset)? pageScrollListener;

  /// Creates an [IndexedPageView] widget.
  const IndexedPageView({
    Key? key,
    this.height = 256.0,
    required this.children,
    this.physics = const BouncingScrollPhysics(),
    this.pageScrollListener,
    this.indicatorColor = Colors.white,
    this.indicatorSpacingTop = 50.0,
    this.tapToNavigate = false,
  }) : super(key: key);
  @override
  _IndexedPageViewState createState() => _IndexedPageViewState();
}

class _IndexedPageViewState extends State<IndexedPageView> {
  late PageController _pageController;
  late int _currentPage;
  late double _opacity;

  final Duration onTapTransDur = Duration(milliseconds: 500);
  final Curve onTapTransCurve = Curves.easeIn;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _opacity = 1.0;
    _pageController = PageController();

    _pageController.addListener(() {
      if (_pageController.hasClients) {
        _bindOpacity();
        if (widget.pageScrollListener != null) {
          widget.pageScrollListener!(_pageController.page);
        }
      }
    });
  }

  /// Binds the [PageController] page value to the [_opacity] state value.
  void _bindOpacity() {
    setState(() {
      _currentPage = _pageController.page!.ceil();
      _opacity = (_pageController.page! - _currentPage) + 1;
    });
  }

  void _onTap() {
    if (_currentPage == (widget.children.length - 1)) {
      _pageController.animateToPage(
        0,
        duration: onTapTransDur,
        curve: onTapTransCurve,
      );
    } else {
      _pageController.nextPage(
        duration: onTapTransDur,
        curve: onTapTransCurve,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: _onTap,
            child: SizedBox(
              height: widget.height,
              child: PageView(
                controller: _pageController,
                physics: widget.physics,
                children: widget.children,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: widget.height + widget.indicatorSpacingTop,
            ),
            child: Builder(builder: (BuildContext context) {
              final List<Widget> dots = [];
              for (int i = 0; i < widget.children.length; i++) {
                dots.add(_ScrolledCardIndicator(
                  isSelected: _currentPage == i,
                  opacity: _opacity,
                  indicatorColor: widget.indicatorColor,
                ));
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: dots,
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}

class _ScrolledCardIndicator extends StatelessWidget {
  final bool isSelected;
  final double opacity;
  final Color indicatorColor;
  const _ScrolledCardIndicator({
    Key? key,
    required this.isSelected,
    required this.opacity,
    required this.indicatorColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 8.0,
        width: 8.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: indicatorColor.withOpacity(
                isSelected ? (opacity >= 0.5 ? opacity : 0.5) : 0.5),
          ),
        ),
      ),
    );
  }
}
