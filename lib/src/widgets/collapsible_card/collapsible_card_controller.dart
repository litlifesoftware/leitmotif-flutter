import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

class CollapsibleCardController {
  AnimationController animationController;

  /// Initializes the [AnimationController] of this [CollapsibleCardController].
  /// This method will be called on the [LitScaffold] [StatefulWidget] by
  /// overriding the corresponding initState method.
  void init(TickerProvider vsync) {
    animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: vsync,
    );
  }

  /// Dispose this [CollapsibleCardController].
  ///
  /// The [AnimationController] of this [CollapsibleCardController] will be
  /// dispose to ensure no [TickerProvider] leak will occur.  Call this method
  /// on the [StatefulWidget] by overriding its dispose method.
  void dispose() {
    animationController.dispose();
  }

  void expandCard(void Function() setStateCallback) {
    setStateCallback();
    animationController.forward(from: 0.0);
  }

  void collapseCard(void Function() setStateCallback) {
    animationController.reverse(from: 1.0).then((value) => setStateCallback());
  }
}
