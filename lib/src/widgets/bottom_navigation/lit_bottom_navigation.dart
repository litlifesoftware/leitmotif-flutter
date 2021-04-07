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
  /// The currently displayed widget's index value.
  final int selectedTabIndex;

  /// The setter method to set the new tab index value on the parent widget.
  final void Function(int) onTabSelect;

  /// The relative width the bar the landscape mode.
  final double landscapeWidthFactor;

  /// The meta data of the navigatable tabs. These will have to match with the parent's widget
  /// list in order to avoid index-based errors.
  final List<LitBottomNavigationTabData> tabs;

  /// Creates a [LitBottomNavigation].
  ///
  /// * [selectedTabIndex] is the parent's currently selected tab's index.
  ///
  /// * [onTabSelect] sets the parent's tab index value using the new value.
  ///
  /// * [landscapeWidthFactor] is the relative width on the landscape mode. Defaults to ``0.65``.
  ///
  /// * [tabs] is a list of meta data objects which will be linked to the widget's instances. They will
  ///   provide the icons and the 'is selected' condition.
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
  /// Now the list of tab data objects can be linked to the respective screen widget. Use a wrapping [Stack]
  /// to stack the navigation on top of your currently selected screen widget:
  /// ```dart
  /// return Scaffold(
  ///    body: Builder(
  ///      builder: (context) {
  ///        return Stack(
  ///          children: [
  ///            _tabs[tabIndex],
  ///            LitBottomNavigation(
  ///              axis: Axis.vertical,
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
    required this.selectedTabIndex,
    required this.onTabSelect,
    this.landscapeWidthFactor = 0.65,
    required this.tabs,
  }) : super(key: key);
  @override
  _LitBottomNavigationState createState() => _LitBottomNavigationState();
}

class _LitBottomNavigationState extends State<LitBottomNavigation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  void switchTab(int value) {
    widget.onTabSelect(value);
    if (_animationController.isCompleted) {
      _animationController.reverse().then(
            (value) => _animationController.forward(),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(
        milliseconds: 150,
      ),
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
            100 - (100 * _animationController.value),
            0,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: LitConstrainedSizedBox(
                      landscapeWidthFactor: 0.55,
                      child: BluredBackgroundContainer(
                        blurRadius: 2.0,
                        child: Container(
                          height: 56.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: LitColors.lightGrey.withOpacity(0.6),
                          ),
                          child: Builder(
                            builder: (context) {
                              final List<Widget> children = [];
                              widget.tabs
                                  .forEach((LitBottomNavigationTabData data) {
                                children.add(
                                  _BottomNavigationItem(
                                    data: data,
                                    selected:
                                        widget.selectedTabIndex == data.index,
                                    setSelectedTab: switchTab,
                                    animationController: _animationController,
                                  ),
                                );
                              });
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

/// The navigation item which will create a view model for the provided data instance.
class _BottomNavigationItem extends StatelessWidget {
  final LitBottomNavigationTabData data;
  final bool selected;
  final void Function(int) setSelectedTab;
  final AnimationController animationController;
  const _BottomNavigationItem({
    Key? key,
    required this.data,
    required this.selected,
    required this.setSelectedTab,
    required this.animationController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return AnimatedOpacity(
          opacity: 0.5 + (0.5 * animationController.value),
          duration: animationController.duration!,
          child: InkWell(
            onTap: selected
                ? () {}
                : () {
                    setSelectedTab(data.index);
                  },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: selected
                        ? LitColors.mediumGrey
                        : LitColors.mediumGrey.withOpacity(0.3),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              blurRadius: 14.0,
                              color: Colors.black.withOpacity(0.4),
                            )
                          ]
                        : [],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 8.0,
                    ),
                    child: Icon(
                      selected ? data.iconSelected : data.icon,
                      color: Colors.white,
                      size: (animationController.value * 22.0),
                    ),
                  ),
                ),
                selected
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 8.0,
                        ),
                        child: Transform(
                          transform: Matrix4.translationValues(
                            0,
                            25.0 - (25.0 * animationController.value),
                            0,
                          ),
                          child: Container(
                            height: 4 + (4 * animationController.value),
                            width: 4 + (4 * animationController.value),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                    2 + (2 * animationController.value)),
                              ),
                              color: Color.lerp(
                                Colors.white,
                                LitColors.lightPink,
                                animationController.value,
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
