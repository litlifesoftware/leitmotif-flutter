import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

class LitSettingsPanelBackgroundOverlay extends StatelessWidget {
  final LitSettingsPanelController controller;

  const LitSettingsPanelBackgroundOverlay({
    Key? key,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animationController,
      builder: (BuildContext context, Widget? widget) {
        return SizedBox(
          child: AnimatedOpacity(
            duration: controller.animationController.duration!,
            opacity: controller.animationController.value,
            child: controller.isAnimatingOrShown
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      color: Colors.black45,
                    ))
                : SizedBox(),
          ),
        );
      },
    );
  }
}
