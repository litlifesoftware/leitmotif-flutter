import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class MinimalistAppBar extends StatelessWidget implements CustomAppBar {
  /// The app bar height is depending on the abstract [CustomAppBar] height.
  static const height = CustomAppBar.height;
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
                      backgroundColor: LitColors.mediumGrey,
                      iconColor: Colors.white,
                    )),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
