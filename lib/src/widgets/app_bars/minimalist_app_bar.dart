import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class MinimalistAppBar extends StatelessWidget implements CustomAppBar {
  final Color backButtonBackgroundColor;
  final Color backButtonIconColor;

  /// The app bar height is depending on the abstract [CustomAppBar] height.
  static const height = CustomAppBar.height;

  const MinimalistAppBar({
    Key? key,
    this.backButtonBackgroundColor =
        LitBackButtonDefaultStyling.backgroundColor,
    this.backButtonIconColor = LitBackButtonDefaultStyling.iconColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Container(
            height: height,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
          ),
          Navigator.of(context).canPop()
              ? Container(
                  height: height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SafeArea(
                      child: LitBackButton(
                        backgroundColor: backButtonBackgroundColor,
                        iconColor: backButtonIconColor,
                      ),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
