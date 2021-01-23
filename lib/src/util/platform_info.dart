import 'dart:io';

/// A controller class to implement platform related labeling such as the device's
/// operation system and its trademark notices.
///
/// Note that Apple Inc. requires to use the label 'iPhone' for their iOS based
/// smartphones. Therefore 'iOS' cannot be used as the platform label.
class PlatformInfo {
  /// Return the device's platform or device label.
  static String get platformLabel {
    String label = "";

    try {
      if (Platform.isAndroid) {
        label = "Android";
      } else if (Platform.isIOS) {
        label = "iPhone";
      }
    } catch (e) {
      label = "Unknown";
    }

    return label;
  }

  /// Return the platform's or device's trademark notice.
  static String get legalNotice {
    String legNote = "";
    try {
      if (Platform.isAndroid) {
        legNote = "Android is a trademark of Google LLC.";
      } else if (Platform.isIOS) {
        legNote = "iPhone is a trademark of Apple Inc.";
      }
    } catch (e) {
      legNote = "";
    }

    return legNote;
  }
}
