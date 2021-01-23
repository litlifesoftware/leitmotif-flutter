import 'package:flutter/material.dart';
import 'package:lit_ui_kit/src/widgets/settings_panel/settings_panel_controller.dart';

class SettingsPanelBackgroundOverlay extends StatelessWidget {
  final SettingsPanelController controller;

  const SettingsPanelBackgroundOverlay({
    Key key,
    @required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animationController,
      builder: (BuildContext context, Widget widget) {
        return SizedBox(
          child: AnimatedOpacity(
            duration: controller.animationController.duration,
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
