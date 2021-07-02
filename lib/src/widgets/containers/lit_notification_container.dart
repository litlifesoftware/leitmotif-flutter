import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:lit_ui_kit/src/controller/lit_notification_controller.dart';

/// A widget to show multiple notifications on top of the provided [child].
///
/// The [LitNotificationController] will be used to add [LitIconSnackbar]s to the
/// current view. Once the snackbar has reached it's maximum display duration,
/// the snackbar will be disposed.
class LitNotificationContainer extends StatefulWidget {
  final Widget child;
  final LitNotificationController controller;

  /// Creates a [LitNotificationContainer].
  ///
  /// * [child] is the widget wrapped inside the container.
  ///
  /// * [controller] provides functionality to access and mutate the underlying
  ///   notification data.
  ///
  /// {@tool snippet}
  /// The [LitNotificationController] should wrap your child widget:
  /// ```dart
  ///  LitNotificationContainer(
  ///     controller: _notificationController,
  ///     child: SizedBox(),
  /// );
  /// ```
  /// {@end-tool}
  ///
  const LitNotificationContainer({
    Key? key,
    this.child = const SizedBox(),
    required this.controller,
  }) : super(key: key);

  @override
  _LitNotificationContainerState createState() =>
      _LitNotificationContainerState();
}

class _LitNotificationContainerState extends State<LitNotificationContainer> {
  void _onRemove(LitNotificationData data) {
    /// States whether the maximum notifications are reached.
    bool maxLengthReached =
        widget.controller.notifications.length == widget.controller.maxAtOnce;

    /// If there should be any additional more notifications displayed
    if (maxLengthReached) {
      // Remove all notifications.
      setState(() {
        widget.controller.reset();
      });
    } else {
      // Remove the provided notification.
      setState(() {
        widget.controller.remove(data);
      });
    }
  }

  /// The view model of [LitNotificationController]'s notification list is
  /// compound of multiple snackbars to be displayed on a list.
  List<Widget> get snackbars {
    List<Widget> snackbars = [];
    // Iterate through the controller's list and add snackbars to the view
    // model.
    for (int i = 0; i < widget.controller.notifications.length; i++) {
      {
        snackbars.add(
          _NotificationItem(
            notificationController: widget.controller,
            notificationData: widget.controller.notifications[i],
            onRemove: _onRemove,
          ),
        );
      }
    }
    return snackbars;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: widget.child,
            ),
            Builder(builder: (context) {
              return Column(
                children: snackbars,
              );
            })
          ],
        ),
      ),
    );
  }
}

/// A item on the snackbar column to display an individual notification.
class _NotificationItem extends StatefulWidget {
  /// The controller to provide the required data and enabling to add or remove
  /// notifications.
  final LitNotificationController notificationController;

  /// The data to provide to the snackbar.
  final LitNotificationData notificationData;

  /// The callback function to set the state on the parent widget.
  final void Function(LitNotificationData) onRemove;

  /// Creates a [_NotificationItem].
  const _NotificationItem({
    Key? key,
    required this.notificationController,
    required this.notificationData,
    required this.onRemove,
  }) : super(key: key);
  @override
  __NotificationItemState createState() => __NotificationItemState();
}

class __NotificationItemState extends State<_NotificationItem>
    with TickerProviderStateMixin {
  late LitSnackbarController _snackbarController;

  /// Removes the notification data object from the list.
  void _remove(void value) {
    widget.onRemove(widget.notificationData);
  }

  @override
  void initState() {
    super.initState();
    // Initialize the snackbar controller.
    _snackbarController = LitSnackbarController()..init(this);
    // Try to play the snackbar animation without reverse animating at the end.
    try {
      // And remove the data notification data object from the list.
      _snackbarController.showSnackBar(reverseAnimation: false).then(_remove);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _snackbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitIconSnackbar(
      snackBarController: _snackbarController,
      text: widget.notificationData.description,
      iconData: widget.notificationData.icon,
    );
  }
}
