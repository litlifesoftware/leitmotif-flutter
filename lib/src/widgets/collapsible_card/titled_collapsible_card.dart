import 'package:flutter/widgets.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

class TitledCollapsibleCard extends StatefulWidget implements CollapsibleCard {
  final CollapsibleCardController collapsibleCardController;
  final double height;
  final Widget child;
  final Color closeButtonBorderColor;
  final Color closeButtonColor;
  final Color backgroundColor;
  final Color topBarColor;
  final void Function() onCloseCallback;
  final Widget title;
  const TitledCollapsibleCard({
    Key? key,
    required this.collapsibleCardController,
    this.height = 250.0,
    required this.closeButtonBorderColor,
    required this.closeButtonColor,
    required this.child,
    required this.backgroundColor,
    required this.topBarColor,
    required this.onCloseCallback,
    required this.title,
  }) : super(key: key);

  @override
  CollapsibleCardController get controller => this.collapsibleCardController;

  @override
  _TitledCollapsibleCardState createState() => _TitledCollapsibleCardState();
}

class _TitledCollapsibleCardState extends State<TitledCollapsibleCard> {
  void handleOnClose() {
    widget.collapsibleCardController.collapseCard(() {
      widget.onCloseCallback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedBuilder(
          animation: widget.collapsibleCardController.animationController,
          builder: (context, child) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SizedBox(
                height: widget.height,
                width: MediaQuery.of(context).size.width,
                child: Transform(
                  transform: Matrix4.translationValues(
                    0,
                    widget.height +
                        ((widget.collapsibleCardController.animationController
                                .value) *
                            -widget.height),
                    0,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: widget.backgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onVerticalDragEnd: (details) {
                                handleOnClose();
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0),
                                    ),
                                    color: widget.topBarColor,
                                  ),
                                  child: widget.title,
                                ),
                              ),
                            ),
                            widget.child,
                          ],
                        ),
                      ),
                      CircularCloseButton(
                        onPressed: handleOnClose,
                        borderColor: widget.closeButtonBorderColor,
                        color: widget.closeButtonColor,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
