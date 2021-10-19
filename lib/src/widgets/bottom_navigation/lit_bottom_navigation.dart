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
  static const defaultBackgroundColor = const Color(0x82e7e7E7);

  @override
  _LitBottomNavigationState createState() => _LitBottomNavigationState();
}

class _LitBottomNavigationState extends State<LitBottomNavigation>
    with TickerProviderStateMixin {
  /// Controller to animate the tab change transition.
  late AnimationController _animationController;

  /// Changes the currently selected tab by setting the state using the
  /// provided index value.
  void _changeTab(int value) {
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
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            child: Padding(
              padding: widget.padding,
              child: BluredBackgroundContainer(
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
                            _BarItem(
                              data: data,
                              isSelected: checkIsSelected(data),
                              onChangeTab: _changeTab,
                              animationController: _animationController,
                              tabBackgroundColor: data.tabBackgroundColor,
                              tabBackgroundColorAlt: data.tabBackgroundColorAlt,
                              tabColor: data.tabColor,
                              tabColorAlt: data.tabColorAlt,
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
            ),
          ),
        );
      },
    );
  }
}

/// An individual tab item on the bottom navigation bar.
class _BarItem extends StatelessWidget {
  final LitBottomNavigationBarItemData data;
  final bool isSelected;
  final void Function(int) onChangeTab;
  final AnimationController animationController;
  final Color tabBackgroundColorAlt;
  final Color tabBackgroundColor;
  final Color tabColor;
  final Color tabColorAlt;
  final BorderRadius borderRadius;
  const _BarItem({
    Key? key,
    required this.data,
    required this.isSelected,
    required this.onChangeTab,
    required this.animationController,
    required this.tabBackgroundColorAlt,
    required this.tabBackgroundColor,
    required this.tabColor,
    required this.tabColorAlt,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(18.0),
    ),
  }) : super(key: key);

  /// Returns the background color depending on the current state..
  Color get _backgroundColor {
    return isSelected ? tabBackgroundColorAlt : Colors.transparent;
  }

  /// Returns the color depending on the current state.
  Color get _color {
    return isSelected ? tabColorAlt : tabColor;
  }

  /// Returns the icon depending on the current state.
  IconData get _icon {
    return isSelected ? data.iconAlt : data.icon;
  }

  /// Returns the padding depending on the current state.
  EdgeInsets get _padding {
    return isSelected
        ? EdgeInsets.symmetric(
            horizontal: 22.0,
            vertical: 8.0,
          )
        : EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 4.0,
          );
  }

  /// Returns the icon size depending on the current state.
  double get _iconSize {
    return (animationController.value * (isSelected ? 16.0 : 18.0));
  }

  /// Returns the box shadow depending on the current state.
  List<BoxShadow> get _boxShadow {
    return isSelected ? LitBoxShadows.sm : [];
  }

  /// Returns an animated opacity.
  double get _opacity {
    return 0.25 + (0.75 * animationController.value);
  }

  /// Handles the `change` event.
  ///
  /// Executes the callback, only if the tab is not currently selected.
  void _onTap() {
    if (!isSelected) onChangeTab(data.index);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return AnimatedOpacity(
          opacity: _opacity,
          duration: animationController.duration!,
          child: CleanInkWell(
            onTap: _onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        color: _backgroundColor,
                        boxShadow: _boxShadow,
                      ),
                      child: Padding(
                        padding: _padding,
                        child: Icon(
                          _icon,
                          color: _color,
                          size: _iconSize,
                        ),
                      ),
                    ),
                    isSelected
                        ? _BarItemSelectedIndicator(
                            animationController: animationController,
                          )
                        : SizedBox(),
                  ],
                ),
                data.title != null
                    ? _BarItemTitle(
                        isSelected: isSelected,
                        tabColor: tabColor,
                        tabColorAlt: tabColorAlt,
                        title: data.title!,
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

/// A widget allowing to display a tab title on a [_BarItem].
class _BarItemTitle extends StatelessWidget {
  final bool isSelected;
  final String title;
  final Color tabColor;
  final Color tabColorAlt;
  const _BarItemTitle({
    Key? key,
    required this.isSelected,
    required this.title,
    required this.tabColor,
    required this.tabColorAlt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isSelected ? 2.0 : 2.0,
      ),
      child: Text(
        title.capitalize(),
        style: LitSansSerifStyles.caption.copyWith(
          color: isSelected ? tabColorAlt : tabColor,
          fontWeight: isSelected
              ? FontWeight.bold
              : LitSansSerifStyles.caption.fontWeight,
        ),
      ),
    );
  }
}

/// A widget allowing to display a `selected` indicator on a [_BarItem].
class _BarItemSelectedIndicator extends StatelessWidget {
  final AnimationController animationController;
  final EdgeInsets padding;
  final double size;
  const _BarItemSelectedIndicator({
    Key? key,
    required this.animationController,
    this.padding = const EdgeInsets.symmetric(
      vertical: 6.0,
      horizontal: 10.0,
    ),
    this.size = 4,
  }) : super(key: key);

  /// Returns an animated transform matrix.
  Matrix4 get _transform {
    final y = 25.0 - (25.0 * animationController.value);
    return Matrix4.translationValues(
      0,
      y,
      0,
    );
  }

  /// Returns an animated border radius.
  BorderRadius get _borderRadius {
    return BorderRadius.all(
      Radius.circular(
        size / 2 + (size / 2 * animationController.value),
      ),
    );
  }

  /// Returns an animated height.
  double get _height {
    return size + (size * animationController.value);
  }

  /// Returns an animated width.
  double get _width {
    return size + (size * animationController.value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Transform(
        transform: _transform,
        child: Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
            borderRadius: _borderRadius,
            color: Color.lerp(
              Colors.white,
              LitColors.red400,
              animationController.value,
            ),
          ),
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
  ///
  /// * [index] is the index value of the tab.
  ///
  /// * [icon] is the icon in `unselected` state.
  ///
  /// * [iconAlt] is the icon in `selected` state.
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
