import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// A bottom navigation bar allowing to switch between a list of tabs, which are displayed
/// on the parent component.
///
/// The parent should hold a list of navigatable screen widgets. The parent's [selectedTabIndex]
/// state value should determine which of the screen widgets should be displayed at the moment.
/// Only one widgets will be displayed at once by displaying the list item whose index value
/// matches with the current [selectedTabIndex].
class LitBottomNavigation extends StatefulWidget {
  /// Creates a [LitBottomNavigation].
  ///
  /// {@tool snippet}
  /// The [LitBottomNavigation]'s tabs need to match the parent's widget list to avoid index errors and
  /// to reliably display the currently selected widget based on its meta data [LitBottomNavigationTabData].
  ///
  /// First where needs to be a tab widget list on the parent widget:
  /// ```dart
  /// final List<Widget> _tabs = [
  ///   HomeScreen(),
  ///   ProfileScreen(),
  /// ];
  /// ```
  ///
  /// And there needs to be a list of tab data objects:
  /// ```dart
  ///    final List<LitBottomNavigationTabData> _tabData = [
  ///   LitBottomNavigationTabData(
  ///     index: 0,
  ///     icon: LitIcons.home,
  ///     iconSelected: LitIcons.home_alt,
  ///   ),
  ///   LitBottomNavigationTabData(
  ///     index: 1,
  ///     icon: LitIcons.person,
  ///     iconSelected: LitIcons.person_solid,
  ///   ),
  /// ];
  /// ```
  ///
  /// Now the list of tab data objects can be linked to the respective screen
  /// widget. Use a wrapping [Stack] to stack the navigation on top of your
  /// currently selected screen widget:
  /// ```dart
  /// return Scaffold(
  ///    body: Builder(
  ///      builder: (context) {
  ///        return Stack(
  ///          children: [
  ///            _tabs[tabIndex],
  ///            LitBottomNavigation(
  ///              selectedTabIndex: tabIndex,
  ///              onTabSelect: _setTabIndex,
  ///              tabs: _tabData,
  ///            )
  ///          ],
  ///        );
  ///      },
  ///    ),
  ///  );
  /// ```
  ///
  /// {@end-tool}
  const LitBottomNavigation({
    Key? key,
    this.hide = true,
    required this.selectedTabIndex,
    required this.onTabSelect,
    this.landscapeWidthFactor = 0.65,
    required this.tabs,
    this.padding = LitBottomNavigationBarDefaultStyling.padding,
    this.height = LitBottomNavigationBarDefaultStyling.height,
    this.animationDuration =
        LitBottomNavigationBarDefaultStyling.animationDuration,
    this.blurRadius = LitBottomNavigationBarDefaultStyling.blurRadius,
    this.backgroundColor = LitBottomNavigationBarDefaultStyling.backgroundColor,
    this.tabItemBackgroundColorSelected =
        LitBottomNavigationBarDefaultStyling.tabItemBackgroundColorSelected,
    this.tabItemBackgroundColor =
        LitBottomNavigationBarDefaultStyling.tabItemBackgroundColor,
    this.tabItemColor = LitBottomNavigationBarDefaultStyling.tabItemColor,
    this.tabItemColorSelected =
        LitBottomNavigationBarDefaultStyling.tabItemColorSelected,
  }) : super(key: key);

  /// States whether to hide the bottom navigation.
  ///
  /// Hiding the bar could be used in order to avoid overlapping of widgets
  /// displayed in front of the bottom navigation (such as panels).
  final bool hide;

  /// The currently displayed widget's index value.
  final int selectedTabIndex;

  /// The setter method to set the new tab index value on the parent widget.
  final void Function(int) onTabSelect;

  /// The relative width the bar the landscape mode.
  final double landscapeWidthFactor;

  /// The meta data of the navigatable tabs. These will have to match with the parent's widget
  /// list in order to avoid index-based errors.
  final List<LitBottomNavigationTabData> tabs;

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

  /// The background color of the currently selected tab item.
  final Color tabItemBackgroundColorSelected;

  /// The background color of each unselected tab item.
  final Color tabItemBackgroundColor;

  /// The color of the currently selected tab item.
  final Color tabItemColor;

  /// The color of each unselected tab item.
  final Color tabItemColorSelected;
  @override
  _LitBottomNavigationState createState() => _LitBottomNavigationState();
}

class _LitBottomNavigationState extends State<LitBottomNavigation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  /// Switches the currently selected tab using the provided index value.
  void switchTab(int value) {
    widget.onTabSelect(value);
    if (_animationController.isCompleted) {
      _animationController.reverse().then(
            (value) => _animationController.forward(),
          );
    }
  }

  /// Returns the vertical transform value applied by the animation.
  double get _transformY {
    return widget.height * 2;
  }

  double get _animatedTransform {
    return widget.hide
        ? _transformY
        : _transformY - (_transformY * _animationController.value);
  }

  bool getIsSelected(LitBottomNavigationTabData data) {
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
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return Transform(
          transform: Matrix4.translationValues(
            0,
            _animatedTransform,
            0,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  child: Padding(
                    padding: widget.padding,
                    child: LitConstrainedSizedBox(
                      landscapeWidthFactor: 0.55,
                      child: BluredBackgroundContainer(
                        blurRadius: widget.blurRadius,
                        child: Container(
                          height: widget.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: widget.backgroundColor,
                          ),
                          child: Builder(
                            builder: (context) {
                              final List<Widget> children = [];
                              widget.tabs.forEach(
                                (LitBottomNavigationTabData data) {
                                  children.add(
                                    _BottomNavigationItem(
                                      data: data,
                                      selected: getIsSelected(data),
                                      setSelectedTab: switchTab,
                                      animationController: _animationController,
                                      tabItemBackgroundColor:
                                          widget.tabItemBackgroundColor,
                                      tabItemBackgroundColorSelected:
                                          widget.tabItemBackgroundColorSelected,
                                      tabItemColor: widget.tabItemColor,
                                      tabItemColorSelected:
                                          widget.tabItemColorSelected,
                                    ),
                                  );
                                },
                              );
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: children,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

/// The navigation item which will create a view model for the provided data
/// instance.
class _BottomNavigationItem extends StatefulWidget {
  final LitBottomNavigationTabData data;
  final bool selected;
  final void Function(int) setSelectedTab;
  final AnimationController animationController;
  final Color tabItemBackgroundColorSelected;
  final Color tabItemBackgroundColor;
  final Color tabItemColor;
  final Color tabItemColorSelected;

  const _BottomNavigationItem({
    Key? key,
    required this.data,
    required this.selected,
    required this.setSelectedTab,
    required this.animationController,
    required this.tabItemBackgroundColorSelected,
    required this.tabItemBackgroundColor,
    required this.tabItemColor,
    required this.tabItemColorSelected,
  }) : super(key: key);

  @override
  __BottomNavigationItemState createState() => __BottomNavigationItemState();
}

class __BottomNavigationItemState extends State<_BottomNavigationItem> {
  Color get _backgroundColor {
    return widget.selected
        ? widget.tabItemBackgroundColorSelected
        : widget.tabItemBackgroundColor;
  }

  Color get _iconColor {
    return widget.selected ? widget.tabItemColorSelected : widget.tabItemColor;
  }

  IconData get _icon {
    return widget.selected ? widget.data.iconSelected : widget.data.icon;
  }

  List<BoxShadow> get _boxShadow {
    return widget.selected
        ? [
            BoxShadow(
              blurRadius: 6.0,
              color: Colors.black38,
              offset: Offset(-2, 2),
              spreadRadius: -1.0,
            )
          ]
        : [];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, _) {
        return AnimatedOpacity(
          opacity: 0.5 + (0.5 * widget.animationController.value),
          duration: widget.animationController.duration!,
          child: InkWell(
            onTap: widget.selected
                ? () {}
                : () {
                    widget.setSelectedTab(widget.data.index);
                  },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: _backgroundColor,
                    boxShadow: _boxShadow,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 8.0,
                    ),
                    child: Icon(
                      _icon,
                      color: _iconColor,
                      size: (widget.animationController.value * 22.0),
                    ),
                  ),
                ),
                widget.selected
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 8.0,
                        ),
                        child: Transform(
                          transform: Matrix4.translationValues(
                            0,
                            25.0 - (25.0 * widget.animationController.value),
                            0,
                          ),
                          child: Container(
                            height: 4 + (4 * widget.animationController.value),
                            width: 4 + (4 * widget.animationController.value),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  2 + (2 * widget.animationController.value),
                                ),
                              ),
                              color: Color.lerp(
                                Colors.white,
                                LitColors.lightPink,
                                widget.animationController.value,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// The meta data of each tab inside the [LitBottomNavigation].
///
/// Provide an index value, a selected and an unselected icon. Either of them are displayed
/// depending on the current 'is selected' state.
class LitBottomNavigationTabData {
  final int index;
  final IconData icon;
  final IconData iconSelected;

  /// Creates a [LitBottomNavigationTabData] to be used on the [LitBottomNavigation].
  ///
  /// * [index] is the index value of the tab.
  ///
  /// * [icon] is the icon displayed as long as the tab has not been selected.
  ///
  /// * [iconSelected] is the icon displayed once the tab has been selected.
  const LitBottomNavigationTabData({
    required this.index,
    required this.icon,
    required this.iconSelected,
  });
}

/// The default styling of [LitBottomNavigation].
class LitBottomNavigationBarDefaultStyling {
  static const padding = const EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 8.0,
  );
  static const height = 56.0;
  static const animationDuration = const Duration(milliseconds: 150);
  static const blurRadius = 3.0;
  static const backgroundColor = const Color(0x82C7C7C7);
  static const tabItemBackgroundColorSelected = LitColors.mediumGrey;
  static const tabItemBackgroundColor = const Color(0x7fb7b7b7);
  static const tabItemColor = LitColors.mediumGrey;
  static const tabItemColorSelected = Colors.white;
}
