import 'package:flutter/material.dart';
import 'package:leitmotif/bottom_navigation.dart';

/// A screen widget allowing to navigate the provided tab widgets inside an
/// surrounding tab view.
///
/// It implements the [LitBottomNavigation] as a view layer and the required
/// logic for tracking the state and the for navigating between the tabs.
/// The tab wiew will ignore the any overlapping widgets when using a keyboard
/// by disabling the [Scaffold.resizeToAvoidBottomInset]. To reenable the
/// resize when using a keyboard, set the [resizeToAvoidBottomInset] to `true`.
///
/// Accoring to Material Design's guidelines (https://material.io/components/),
/// bottom app bars should be able to overlap when using the keyboard.
///
class LitTabView extends StatefulWidget {
  /// Creates a [LitTabView].
  ///
  /// * [tabs] are the widget and data objects the view should display.
  const LitTabView({
    Key? key,
    required this.tabs,
    this.resizeToAvoidBottomInset = false,
    this.hideNavigationBar = false,
    this.animationDuration =
        LitBottomNavigationBarDefaultStyling.animationDuration,
    this.barBlurRadius = LitBottomNavigationBarDefaultStyling.blurRadius,
    this.barBackgroundColor =
        LitBottomNavigationBarDefaultStyling.backgroundColor,
    this.tabItemBackgroundColor =
        LitBottomNavigationBarDefaultStyling.tabItemBackgroundColor,
    this.tabItemBackgroundColorSelected =
        LitBottomNavigationBarDefaultStyling.tabItemBackgroundColorSelected,
    this.tabItemColor = LitBottomNavigationBarDefaultStyling.tabItemColor,
    this.tabItemColorSelected =
        LitBottomNavigationBarDefaultStyling.tabItemColorSelected,
    this.initialTabIndex = 0,
    this.transitionListener,
  }) : super(key: key);

  /// The tabs the tab view should display.
  final List<LitNavigableTab> tabs;

  /// States whether to resize the tab view widgets when using a keyboard.
  final bool resizeToAvoidBottomInset;

  /// States whether to hide the navigation bar, if any widget should occupy
  /// its space temporarily (e.g. when expanding a panel).
  final bool hideNavigationBar;

  /// States how long each animation cycle should last.
  final Duration animationDuration;

  /// States the amount of blur applied to the navigation bar's background.
  final double barBlurRadius;

  /// The navigation bar's background color.
  final Color barBackgroundColor;

  /// The background color of the currently selected tab item.
  final Color tabItemBackgroundColorSelected;

  /// The background color of each unselected tab item.
  final Color tabItemBackgroundColor;

  /// The color of the currently selected tab item.
  final Color tabItemColor;

  /// The color of each unselected tab item.
  final Color tabItemColorSelected;

  /// The initial tab index (defaults to `0`)
  final int initialTabIndex;

  /// Called whenever the tab has been transitioned.
  final void Function(int index)? transitionListener;

  @override
  _LitTabViewState createState() => _LitTabViewState();
}

class _LitTabViewState extends State<LitTabView> {
  /// The currently user selected tab stated as its index value.
  late int tabIndex;

  /// All available tab screen [Widget] objects that can be navigated.
  List<Widget> _tabs = [];

  /// All tab data objects providing the meta data for the tabs.
  List<LitBottomNavigationTabData> _tabData = [];

  /// Sets the state to change the currently displayed tab.
  void _setTabIndex(int value) {
    setState(() {
      tabIndex = value;
    });
    if (widget.transitionListener != null) {
      widget.transitionListener!(value);
    }
  }

  /// Separetes the provided [LitNavigableTab] into individual [Widget] and
  /// [LitBottomNavigationTabData] lists.
  void bindWidgetsAndData() {
    for (LitNavigableTab item in widget.tabs) {
      _tabs.add(item.screen);
      _tabData.add(item.tabData);
    }
  }

  @override
  void initState() {
    tabIndex = widget.initialTabIndex;
    bindWidgetsAndData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              _tabs[tabIndex],
              LitBottomNavigation(
                selectedTabIndex: tabIndex,
                onTabSelect: _setTabIndex,
                tabs: _tabData,
                hide: widget.hideNavigationBar,
                animationDuration: widget.animationDuration,
                backgroundColor: widget.barBackgroundColor,
                blurRadius: widget.barBlurRadius,
                tabItemColor: widget.tabItemColor,
                tabItemColorSelected: widget.tabItemColorSelected,
                tabItemBackgroundColor: widget.tabItemBackgroundColor,
                tabItemBackgroundColorSelected:
                    widget.tabItemBackgroundColorSelected,
              )
            ],
          );
        },
      ),
    );
  }
}

/// A model class combining the [Widget] view layer and it's meta data object.
class LitNavigableTab {
  /// The meta data objects for the tab.
  final LitBottomNavigationTabData tabData;

  /// The screen tab.
  final Widget screen;

  /// Creates a [LitNavigableTab]
  const LitNavigableTab({required this.tabData, required this.screen});
}
