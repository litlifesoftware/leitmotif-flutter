import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

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
    this.barBackgroundColor,
    this.initialTabIndex = 0,
    this.transitionListener,
    this.dark = false,
    this.materialAppBar,
    this.materialDrawer,
    this.materialBottomSheet,
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
  final Color? barBackgroundColor;

  /// The initial tab index (defaults to `0`)
  final int initialTabIndex;

  /// States whether to apply a dark theme on the bottom navigation bar.
  final bool dark;

  /// Called whenever the tab has been transitioned.
  final void Function(int index)? transitionListener;

  final PreferredSizeWidget? materialAppBar;
  final Widget? materialDrawer;
  final Widget? materialBottomSheet;

  @override
  _LitTabViewState createState() => _LitTabViewState();
}

class _LitTabViewState extends State<LitTabView> {
  /// The currently user selected tab stated as its index value.
  late int tabIndex;

  /// All tab data objects providing the meta data for the tabs.
  List<LitBottomNavigationItemData> _tabData = [];

  /// Sets the state to change the currently displayed tab.
  void _setTabIndex(int value) {
    setState(() {
      tabIndex = value;
    });
    if (widget.transitionListener != null) {
      widget.transitionListener!(value);
    }
  }

  /// Separetes the provided [LitNavigableTab] into individual widgets and
  /// data object lists.
  void bindData() {
    for (LitNavigableTab item in widget.tabs) {
      _tabData.add(item.tabData);
    }
  }

  /// Returns the currently selected view.
  Widget get _selectedTabView {
    return widget.tabs[tabIndex].screen;
  }

  @override
  void initState() {
    tabIndex = widget.initialTabIndex;
    bindData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: widget.materialAppBar,
      drawer: widget.materialDrawer,
      bottomSheet: widget.materialBottomSheet,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              _selectedTabView,
              LitBottomNavigation(
                selectedTabIndex: tabIndex,
                onChangeTab: _setTabIndex,
                tabs: _tabData,
                animationDuration: widget.animationDuration,
                backgroundColor: widget.barBackgroundColor,
                blurRadius: widget.barBlurRadius,
                dark: widget.dark,
              )
            ],
          );
        },
      ),
    );
  }
}
