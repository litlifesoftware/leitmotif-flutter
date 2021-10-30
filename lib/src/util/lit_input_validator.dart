/// A Leitmotif `controllers` class allowing to validate user input.
class LitInputValidator {
  /// Validates the provided name and returns a validation result.
  static bool validateName(String input) {
    return input.isNotEmpty;
  }

  /// Validates the provided username and returns a validation result.
  static bool validateUsername(String input) {
    return input.isNotEmpty && !input.contains(' ');
  }
}
