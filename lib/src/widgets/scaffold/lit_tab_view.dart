import 'package:flutter/material.dart';
import 'package:leitmotif/bottom_navigation.dart';

/// A Leitmotif `scaffold` widget displaying a bottom navigation view wrapping
/// the provided [tabs].
///
/// It tracks the current navigation state and transitioning through the tabs.
/// The view will ignore any overlapping widgets when using a keyboard
/// by disabling the [Scaffold.resizeToAvoidBottomInset]. To reenable
/// this option, set the [resizeToAvoidBottomInset] to `true`.
///
/// Accoring to Material Design's guidelines (https://material.io/components/),
/// bottom app bars should be able to overlap when using the keyboard.
class LitTabView extends StatefulWidget {
  /// Creates a [LitTabView].
  const LitTabView({
    Key? key,
    required this.tabs,
    this.resizeToAvoidBottomInset = false,
    this.animationDuration = LitBottomNavigation.defaultAnimationDuration,
    this.barBlurRadius = LitBottomNavigation.defaultBlurRadius,
    this.barBackgroundColor = LitBottomNavigation.defaultBackgroundColor,
    this.initialTabIndex = 0,
    this.transitionListener,
  }) : super(key: key);

  /// The tabs the tab view should display.
  final List<LitNavigableTab> tabs;

  /// States whether to resize the tab view widgets when using a keyboard.
  final bool resizeToAvoidBottomInset;

  /// States how long each animation cycle should last.
  final Duration animationDuration;

  /// States the amount of blur applied to the navigation bar's background.
  final double barBlurRadius;

  /// The navigation bar's background color.
  final Color barBackgroundColor;

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
  List<LitBottomNavigationBarItemData> _tabData = [];

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
  /// [LitBottomNavigationBarItemData] lists.
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
                onChangeTab: _setTabIndex,
                tabs: _tabData,
                animationDuration: widget.animationDuration,
                backgroundColor: widget.barBackgroundColor,
                blurRadius: widget.barBlurRadius,
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
  final LitBottomNavigationBarItemData tabData;

  /// The screen tab.
  final Widget screen;

  /// Creates a [LitNavigableTab]
  const LitNavigableTab({required this.tabData, required this.screen});
}
