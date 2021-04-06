import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class LitBottomNavigation extends StatefulWidget {
  final int selectedTabIndex;
  final void Function(int) onTabSelect;
  final double landscapeWidthFactor;
  final Axis axis;
  final List<LitBottomNavigationTabData> tabs;
  const LitBottomNavigation({
    Key? key,
    required this.selectedTabIndex,
    required this.onTabSelect,
    this.landscapeWidthFactor = 0.65,
    this.axis = Axis.horizontal,
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
            child: LayoutBuilder(builder: (context, constraints) {
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
                            child: Builder(builder: (context) {
                              final List<Widget> children = [];
                              widget.tabs
                                  .forEach((LitBottomNavigationTabData data) {
                                children.add(
                                  _BottomNavigationItem(
                                    index: data.index,
                                    icon: data.icon,
                                    iconSelected: data.iconSelected,
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
                            })),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        });
  }
}

class _BottomNavigationItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final IconData iconSelected;
  final bool selected;
  final void Function(int) setSelectedTab;
  final AnimationController animationController;
  const _BottomNavigationItem({
    Key? key,
    required this.index,
    required this.icon,
    required this.iconSelected,
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
                    setSelectedTab(index);
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
                      selected ? iconSelected : icon,
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
/// Provide an index value, and a selected and an unselected icon either of them displayed
/// depending on the current state.
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
