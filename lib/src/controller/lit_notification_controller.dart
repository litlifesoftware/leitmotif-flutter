import 'package:lit_ui_kit/src/model/lit_notification_data.dart';

class LitNotificationController {
  /// States the threshold of notifications that should be displayed at once.
  final int maxAtOnce;

  /// Creates a [LitNotificationController].
  ///
  /// [maxAtOnce] defaults to 3 to avoid any pixel overflow.
  ///
  /// {@tool snippet}
  /// The [LitNotificationController] should be initialized on state of a
  /// stateful widget:
  /// ```dart
  ///  _notificationController = LitNotificationController();
  /// ```
  /// {@end-tool}
  ///
  LitNotificationController({this.maxAtOnce = 10});

  /// All current notifications<.
  List<LitNotificationData> notifications = [];

  /// Adds a notification to the current notification list.
  ///
  /// If the [maxAtOnce] threshold is reached, the list will be reset to enable
  /// adding another notification to the list without causing a pixel overflow.
  void add(LitNotificationData notificationData) {
    if (maxAtOnce > notifications.length) {
      notifications.add(notificationData);
    } else {
      notifications = [];
      notifications.add(notificationData);
    }
  }

  /// Resets all notifications.
  void reset() {
    notifications = [];
  }

  /// Removes a specific notification using its [LitNotificationData] object from
  /// the current notification list.
  ///
  /// Based on its success it will either return a boolean value.
  bool remove(LitNotificationData notificationData) {
    return notifications.remove(notificationData);
  }

  /// Removes a specific notification using its index from the current notification
  /// list.
  void removeAtIndex(int index) {
    notifications.removeAt(index);
  }

  /// Replaces a notification with the provided data.
  void replaceNotification(int index, LitNotificationData notificationData) {
    try {
      notifications[index] = notificationData;
    } catch (e) {
      print(
          "LitNotificationController.replaceNotification: Tried to remove notification at invalid index");
    }
  }
}
