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

  /// The app bar height is depending on the abstract [CustomAppBar] height.
  static final height = CustomAppBar.height;

  /// Creates a [LitAppBar].
  ///
  const LitAppBar({
    Key key,
    @required this.title,
    this.textStyle = LitTextStyles.sansSerif,
    this.boxShadow = const [
      BoxShadow(
        blurRadius: 8.0,
        color: Colors.black45,
        offset: Offset(0, 2),
        spreadRadius: 1.0,
      )
    ],
    this.backgroundColor = LitColors.lightGrey,
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
            decoration:
                BoxDecoration(color: backgroundColor, boxShadow: boxShadow),
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
