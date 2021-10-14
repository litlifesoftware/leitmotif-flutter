/// A Leitmotif `model` class describing persons or entites taken part on an
/// app's development using a specific [role] (kind of service provided)
/// and the [names] of the persons/entities.
class CreditData {
  /// The role taken.
  final String role;

  /// The attributed person's name.
  final List<String> names;

  /// Creates a [CreditData].
  const CreditData({
    required this.role,
    required this.names,
  });
}
