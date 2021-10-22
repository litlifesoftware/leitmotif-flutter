import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `bottom_navigation` widget displaying an individual tab item
/// on a bottom navigation bar.
class LitBottomNavigationItem extends StatelessWidget {
  /// The controller animating the item.
  final AnimationController animationController;

  /// The data providing the item's styling.
  final LitBottomNavigationBarItemData data;

  /// States whether the item is currently selected.
  final bool isSelected;

  /// The total height of the navigation bar.
  final double height;

  /// The borderRadius applied on the item decoration.
  final BorderRadius borderRadius;

  /// Handles the `change` action.
  final void Function(int) onChange;

  /// Creates a [LitBottomNavigationItem].
  const LitBottomNavigationItem({
    Key? key,
    required this.data,
    required this.isSelected,
    required this.onChange,
    required this.animationController,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(18.0),
    ),
    this.height = LitBottomNavigation.defaultHeight,
  }) : super(key: key);

  /// Returns the background color depending on the current state..
  Color get _backgroundColor {
    return isSelected ? data.tabBackgroundColorAlt : Colors.transparent;
  }

  /// Returns the color depending on the current state.
  Color get _color {
    return isSelected ? data.tabColorAlt : data.tabColor;
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
    if (!isSelected) onChange(data.index);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return _AnimatedContent(
          animationController: animationController,
          backgroundColor: _backgroundColor,
          borderRadius: borderRadius,
          boxShadow: _boxShadow,
          color: _color,
          data: data,
          icon: _icon,
          iconSize: _iconSize,
          isSelected: isSelected,
          onTap: _onTap,
          opacity: _opacity,
          padding: _padding,
          height: height,
        );
      },
      child: _AnimatedContent(
        animationController: animationController,
        backgroundColor: _backgroundColor,
        borderRadius: borderRadius,
        boxShadow: _boxShadow,
        color: _color,
        data: data,
        icon: _icon,
        iconSize: _iconSize,
        isSelected: isSelected,
        onTap: _onTap,
        opacity: _opacity,
        padding: _padding,
        height: height,
      ),
    );
  }
}

/// The [LitBottomNavigationItem]'s animated content.
class _AnimatedContent extends StatelessWidget {
  final AnimationController animationController;
  final LitBottomNavigationBarItemData data;
  final bool isSelected;
  final double height;
  final IconData icon;
  final Color color;
  final double iconSize;

  final double opacity;
  final EdgeInsets padding;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final List<BoxShadow> boxShadow;
  final void Function() onTap;
  const _AnimatedContent({
    Key? key,
    required this.animationController,
    required this.data,
    required this.isSelected,
    required this.height,
    required this.icon,
    required this.color,
    required this.iconSize,
    required this.opacity,
    required this.padding,
    required this.backgroundColor,
    required this.borderRadius,
    required this.boxShadow,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: animationController.duration!,
      child: CleanInkWell(
        onTap: onTap,
        child: Container(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: backgroundColor,
                      boxShadow: boxShadow,
                    ),
                    child: Padding(
                      padding: padding,
                      child: Center(
                        child: Icon(
                          icon,
                          color: color,
                          size: iconSize,
                        ),
                      ),
                    ),
                  ),
                  isSelected
                      ? _Indicator(
                          animationController: animationController,
                        )
                      : SizedBox(),
                ],
              ),
              data.title != null
                  ? _Title(
                      isSelected: isSelected,
                      data: data,
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

/// A widget allowing to display a tab title on a [LitBottomNavigationItem].
class _Title extends StatelessWidget {
  final bool isSelected;
  final LitBottomNavigationBarItemData data;

  const _Title({
    Key? key,
    required this.isSelected,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isSelected ? 2.0 : 2.0,
      ),
      child: Text(
        data.title!.capitalize(),
        style: LitSansSerifStyles.caption.copyWith(
          color: isSelected ? data.tabColorAlt : data.tabColor,
          fontWeight: isSelected
              ? FontWeight.bold
              : LitSansSerifStyles.caption.fontWeight,
        ),
      ),
    );
  }
}

/// A widget allowing to display a `selected` indicator on a
/// [LitBottomNavigationItem].
class _Indicator extends StatelessWidget {
  final AnimationController animationController;
  final double height;
  final double width;
  const _Indicator(
      {Key? key,
      required this.animationController,
      this.height = 1,
      this.width = 8.0})
      : super(key: key);

  /// Returns an animated transform matrix.
  Matrix4 get _transform {
    final y = 46.0 - (8.0 * animationController.value);
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
        height / 2 + (height / 2 * animationController.value),
      ),
    );
  }

  /// Returns an animated height.
  double get _height {
    return height + (height * animationController.value);
  }

  /// Returns an animated width.
  double get _width {
    return width + (width * animationController.value);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        duration: animationController.duration!,
        opacity: animationController.value,
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
      ),
    );
  }
}
