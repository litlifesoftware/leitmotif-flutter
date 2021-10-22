import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `bottom_navigation` widget displaying a bottom navigation bar
/// allowing to switch between different screen views.
///
/// The tab-switching logic and the state-management should be handled on the
/// parent widget, as the [LitBottomNavigation] does not track its current
/// state.
class LitBottomNavigation extends StatefulWidget {
  /// The currently selected screen's index .
  final int selectedTabIndex;

  /// A setter method to handle a tab-change.
  final void Function(int index) onChangeTab;

  /// The tab items the navigation bar should be displaying.
  final List<LitBottomNavigationBarItemData> tabs;

  /// The padding surrounding the navigation bar.
  final EdgeInsets padding;

  /// The navigation bar's total height.
  final double height;

  /// States how long each animation cycle should last.
  final Duration animationDuration;

  /// States the amount of blur applied to the navigation bar's background.
  final double blurRadius;

  /// The navigation bar's background color.
  final Color backgroundColor;

  /// Creates a [LitBottomNavigation].
  const LitBottomNavigation({
    Key? key,
    required this.selectedTabIndex,
    required this.onChangeTab,
    required this.tabs,
    this.padding = defaultPadding,
    this.height = defaultHeight,
    this.animationDuration = defaultAnimationDuration,
    this.blurRadius = defaultBlurRadius,
    this.backgroundColor = defaultBackgroundColor,
  }) : super(key: key);
  static const defaultPadding = const EdgeInsets.all(0);
  static const defaultHeight = 72.0;
  static const defaultAnimationDuration = const Duration(milliseconds: 110);
  static const defaultBlurRadius = 4.0;
  static const defaultBackgroundColor = LitColors.semiTransparent;

  @override
  _LitBottomNavigationState createState() => _LitBottomNavigationState();
}

class _LitBottomNavigationState extends State<LitBottomNavigation>
    with TickerProviderStateMixin {
  /// Controller to animate the tab change transition.
  late AnimationController _animationController;

  /// Changes the currently selected tab by setting the state using the
  /// provided index value.
  void _handleOnChange(int value) {
    widget.onChangeTab(value);
    if (_animationController.isCompleted) {
      _animationController.reverse().then(
            (_) => _animationController.forward(),
          );
    }
  }

  /// Evaluates whether the provided [data] is assigned to the currently
  /// selected tab.
  bool checkIsSelected(LitBottomNavigationBarItemData data) {
    return widget.selectedTabIndex == data.index;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        child: Padding(
          padding: widget.padding,
          child: Stack(
            children: [
              _SelectedItemBackdropContainer(
                animationController: _animationController,
                checkIsSelected: checkIsSelected,
                height: widget.height,
                tabs: widget.tabs,
              ),
              BluredBackgroundContainer(
                blurRadius: widget.blurRadius,
                child: Container(
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                  ),
                  child: Builder(
                    builder: (context) {
                      final List<Widget> children = [];
                      widget.tabs.forEach(
                        (LitBottomNavigationBarItemData data) {
                          children.add(
                            LitBottomNavigationItem(
                              data: data,
                              isSelected: checkIsSelected(data),
                              onChange: _handleOnChange,
                              animationController: _animationController,
                            ),
                          );
                        },
                      );
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A backdrop decoration indicated which tab item is currently selected.
class _SelectedItemBackdropContainer extends StatelessWidget {
  final AnimationController animationController;
  final List<LitBottomNavigationBarItemData> tabs;
  final double height;
  final bool Function(LitBottomNavigationBarItemData) checkIsSelected;
  const _SelectedItemBackdropContainer({
    Key? key,
    required this.animationController,
    required this.tabs,
    required this.height,
    required this.checkIsSelected,
  }) : super(key: key);

  final double _width = 58.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Builder(
        builder: (context) {
          List<Widget> children = [];
          for (LitBottomNavigationBarItemData tab in tabs) {
            if (checkIsSelected(tab)) {
              children.add(
                AnimatedBuilder(
                  animation: animationController,
                  builder: (context, _) {
                    return _BackdropItem(
                      animationController: animationController,
                      height: height,
                      width: _width,
                    );
                  },
                  child: _BackdropItem(
                    animationController: animationController,
                    height: height,
                    width: _width,
                  ),
                ),
              );
            } else {
              children.add(
                SizedBox(
                  height: height,
                  width: _width,
                ),
              );
            }
          }

          return Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: children,
              ),
            ],
          );
        },
      ),
    );
  }
}

/// An individual backdrop item displaying a radial gradient decoration.
class _BackdropItem extends StatelessWidget {
  final AnimationController animationController;
  final double height;
  final double width;
  const _BackdropItem({
    Key? key,
    required this.animationController,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: animationController.value,
      duration: animationController.duration!,
      child: Container(
        height: height / 1.5,
        width: width,
        decoration: BoxDecoration(
          gradient: LitGradients.navigationBackdrop,
        ),
      ),
    );
  }
}

/// A Leitmotif `model` class describing meta data required to build a tab item
/// on a bottom navigation bar.
class LitBottomNavigationBarItemData {
  /// The tab's index.
  final int index;

  /// The icon in `unselected` state.
  final IconData icon;

  /// The icon in `selected` state.
  final IconData iconAlt;

  /// The tab's title.
  final String? title;

  /// The background color of the currently selected tab item.
  final Color tabBackgroundColorAlt;

  /// The background color of each unselected tab item.
  final Color tabBackgroundColor;

  /// The color of the currently selected tab item.
  final Color tabColor;

  /// The color of each unselected tab item.
  final Color tabColorAlt;

  /// Creates a [LitBottomNavigationBarItemData].
  const LitBottomNavigationBarItemData({
    required this.index,
    required this.icon,
    required this.iconAlt,
    this.title,
    this.tabBackgroundColorAlt = defaultBackgroundColorAlt,
    this.tabBackgroundColor = defaultBackgroundColor,
    this.tabColor = defaultColor,
    this.tabColorAlt = defaultColorAlt,
  });

  static const defaultBackgroundColorAlt = Colors.white;
  static const defaultBackgroundColor = LitColors.transparent;
  static const defaultColor = LitColors.grey350;
  static const defaultColorAlt = LitColors.grey500;
}
