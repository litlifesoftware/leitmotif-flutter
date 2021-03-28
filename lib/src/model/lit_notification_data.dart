import 'package:flutter/widgets.dart';

/// A model class to describe a notification.
///
/// [LitNotificationData] are used to provide data to icon snackbars without
/// declaring the property values individually.
class LitNotificationData {
  final String description;
  final IconData icon;

  /// Creates a [LitNotificationData].
  ///
  /// * [description] is the text that will be displayed on the snackbar.
  ///
  /// * [icon] is the [IconData] used to assemble the icon next to the text.
  const LitNotificationData({
    @required this.description,
    @required this.icon,
  });
}
