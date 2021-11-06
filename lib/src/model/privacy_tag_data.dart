import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `models` class providing data to privacy tags displayed on the
/// [LitPrivacyPolicyScreen].
class PrivacyTagData {
  final String text;
  final bool isConform;

  /// Creates a [PrivacyTagData].
  const PrivacyTagData({
    required this.text,
    required this.isConform,
  });
}
