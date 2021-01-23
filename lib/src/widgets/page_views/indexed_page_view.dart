import 'package:flutter/material.dart';

/// A widget to display the provided [children] inside a [PageView].
///
/// The [PageView] will have indicators to state the current page
/// position.
class IndexedPageView extends StatefulWidget {
  final double height;
  final List<Widget> children;
  final ScrollPhysics physics;
  final Color indicatorColor;
  final double indicatorSpacingTop;

  /// An additional listener to return the current page scroll offset
  /// to the parent widget.
  final void Function(double offset) pageScrollListener;

  /// Creates an [IndexedPageView] widget.
  const IndexedPageView({
    Key key,
    this.height = 250.0,
    @required this.children,
    this.physics = const BouncingScrollPhysics(),
    this.pageScrollListener,
    this.indicatorColor = Colors.white,
    this.indicatorSpacingTop = 50.0,
  }) : super(key: key);
  @override
  _IndexedPageViewState createState() => _IndexedPageViewState();
}

class _IndexedPageViewState extends State<IndexedPageView> {
  PageController _pageController;
  int _currentPage;
  double _selectedIndicatorOpacity;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _selectedIndicatorOpacity = 1.0;
    _pageController = PageController();

    _pageController.addListener(() {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = _pageController.page.ceil();
          _selectedIndicatorOpacity = (_pageController.page - _currentPage) + 1;
        });
        if (widget.pageScrollListener != null) {
          widget.pageScrollListener(_pageController.page);
        }
      }
    });
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
          SizedBox(
            height: widget.height,
            child: PageView(
              controller: _pageController,
              physics: widget.physics,
              children: widget.children,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: widget.height + widget.indicatorSpacingTop,
            ),
            child: Builder(builder: (BuildContext context) {
              final List<Widget> dots = List<Widget>();
              for (int i = 0; i < widget.children.length; i++) {
                dots.add(_ScrolledCardIndicator(
                  isSelected: _currentPage == i,
                  selectedIndicatorOpacity: _selectedIndicatorOpacity,
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
  final double selectedIndicatorOpacity;
  final Color indicatorColor;
  const _ScrolledCardIndicator({
    Key key,
    @required this.isSelected,
    @required this.selectedIndicatorOpacity,
    @required this.indicatorColor,
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
            color: indicatorColor.withOpacity(isSelected
                ? (selectedIndicatorOpacity >= 0.5
                    ? (selectedIndicatorOpacity)
                    : 0.5)
                : 0.5),
          ),
        ),
      ),
    );
  }
}
