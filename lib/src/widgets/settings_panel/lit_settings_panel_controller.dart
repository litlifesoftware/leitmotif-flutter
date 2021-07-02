import 'package:flutter/widgets.dart';

class LitSettingsPanelController {
  late AnimationController animationController;

  void init(TickerProvider vsync) {
    animationController = AnimationController(
        vsync: vsync,
        duration: Duration(
          milliseconds: 350,
        ));
  }

  /// Dispose this [LitSettingsPanelController].
  ///
  /// The [AnimationController] of this [LitSettingsPanelController] will be
  /// dispose to ensure no [TickerProvider] leak will occur.  Call this method
  /// on the [StatefulWidget] by overriding its dispose method.
  void dispose() {
    _listeners = [];
    animationController.dispose();
  }

  void dismissSettingsPanel() {
    animationController.reverse();
    _callListerns();
  }

  void showSettingsPanel() {
    animationController.forward();
    _callListerns();
  }

  bool get isShown {
    return animationController.value == 1.0;
  }

  bool get isAnimating {
    return animationController.isAnimating;
  }

  bool get isAnimatingOrShown {
    return animationController.isAnimating || isShown;
  }

  /// A list currently added listeners.
  List<Function> _listeners = [];

  /// Calls all provided listeners one by one.
  void _callListerns() {
    for (Function func in _listeners) {
      func();
    }
  }

  /// Adds a listener to the panel.
  ///
  /// Each action ([dismissSettingsPanel],[showSettingsPanel]) will trigger the
  /// provided callbacks.
  void addListener(void Function() func) {
    _listeners.add(func);
  }
}
