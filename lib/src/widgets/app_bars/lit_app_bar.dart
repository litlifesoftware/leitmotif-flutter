import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

/// The default [CustomAppBar] implementetion.
///
/// The background [Color] will depend on the provided [darkMode] value.
class LitAppBar extends StatelessWidget implements CustomAppBar {
  final String title;
  final TextStyle textStyle;
  final List<BoxShadow> boxShadow;
  final Color backgroundColor;
  final bool elevated;

  /// The app bar height is depending on the abstract [CustomAppBar] height.
  static final height = CustomAppBar.height;

  /// Creates a [LitAppBar].
  ///
  const LitAppBar({
    Key? key,
    required this.title,
    this.textStyle = LitTextStyles.sansSerif,
    this.elevated = false,
    this.boxShadow = const [
      BoxShadow(
        blurRadius: 12.0,
        color: Colors.black26,
        offset: Offset(0, 4),
        spreadRadius: 1.0,
      )
    ],
    this.backgroundColor = Colors.white,
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
            decoration: BoxDecoration(
                color: backgroundColor, boxShadow: elevated ? [] : boxShadow),
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ClippedText(
                    "$title",
                    style: textStyle,
                  ),
                ),
              ),
            ),
          ),
          Navigator.canPop(context)
              ? Container(
                  height: height,
                  width: MediaQuery.of(context).size.width,
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
