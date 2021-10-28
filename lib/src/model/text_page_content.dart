/// A Leitmotif `models` class containing data required to build text page
/// views.
class TextPageContent {
  /// The subtitle.
  final String? subtitle;

  /// The title.
  final String title;

  /// The text body.
  final String text;

  /// Creates a [TextPageContent].
  const TextPageContent({
    this.subtitle,
    required this.title,
    required this.text,
  });
}
