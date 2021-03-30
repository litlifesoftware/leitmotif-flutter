import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

import 'custom_info_bar.dart';

class TransparentInfoBar extends StatefulWidget implements CustomInfoBar {
  final String text;
  final TextStyle textStyle;
  final Color iconColor;

  const TransparentInfoBar({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.iconColor,
  }) : super(key: key);
  @override
  _TransparentInfoBarState createState() => _TransparentInfoBarState();
}

class _TransparentInfoBarState extends State<TransparentInfoBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return AnimatedOpacity(
                duration: _animationController.duration!,
                opacity: _animationController.value,
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: BluredBackgroundContainer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: LitColors.mediumGrey.withOpacity(0.1),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 50.0,
                                  child: AspectRatio(
                                    aspectRatio: 1.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          color: LitColors.mediumGrey
                                              .withOpacity(0.3)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          LitIcons.info,
                                          color: widget.iconColor,
                                          size: 14.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width -
                                      32 -
                                      32 -
                                      50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      widget.text,
                                      style: widget.textStyle,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      blurRadius: 4.0,
                    )),
              );
            }),
      ),
    );
  }
}
