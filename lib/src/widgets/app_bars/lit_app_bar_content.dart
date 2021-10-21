import 'package:flutter/material.dart';
import 'package:leitmotif/buttons.dart';

/// A Leitmotif `app_bars` widget allowing to build the content of a titled
/// app bar.
class LitAppBarContent extends StatelessWidget {
  /// The back button's background color.
  final Color backButtonBackgroundColor;

  /// The back button's icon color.
  final Color backButtonIconColor;

  /// The internal padding.
  final EdgeInsets margin;

  /// The bar's content.
  final Widget child;

  /// States whether to allow to navigate back.
  final bool shouldNavigateBack;

  /// Handles the action once navigating back has been denied.
  final void Function()? onInvalidNavigation;

  /// Creates a [LitAppBarContent].
  const LitAppBarContent({
    Key? key,
    required this.backButtonBackgroundColor,
    required this.backButtonIconColor,
    required this.margin,
    required this.child,
    this.shouldNavigateBack = LitBackButton.defaultShouldNavigateBack,
    this.onInvalidNavigation,
  }) : super(key: key);

  /// Calculates the text widget's padding on the left.
  double _calcMarginTextLeft(bool canPop) {
    return canPop ? margin.left / 2 : 0;
  }

  /// Calculates the back button's constraints.
  double _calcButtonConstraints(bool canPop) {
    return canPop ? LitBackButton.defaultWidth : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: Navigator.canPop(context)
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              Navigator.canPop(context)
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: LitBackButton(
                        backgroundColor: backButtonBackgroundColor,
                        iconColor: backButtonIconColor,
                        shouldNavigateBack: shouldNavigateBack,
                        onInvalidNavigation: onInvalidNavigation,
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                width: constraints.maxWidth -
                    _calcButtonConstraints(Navigator.canPop(context)) -
                    _calcMarginTextLeft(Navigator.canPop(context)),
                child: child,
              ),
            ],
          );
        },
      ),
    );
  }
}
