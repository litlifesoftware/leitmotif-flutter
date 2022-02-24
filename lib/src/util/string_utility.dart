extension StringUtility on String {
  /// Returns this [String] in captalized format.
  ///
  /// The first character of the string will be formatted in uppercase, while
  /// the remaining characters will be formatted in lowercase.
  String capitalize() {
    String upperCase = this[0].toUpperCase();
    String lowerCase = this.substring(1);
    return "$upperCase$lowerCase";
  }

  /// Converts this [String] to an initial.
  ///
  /// Commonly used to display the first letter of a name.
  String convertToInitial() {
    return String.fromCharCode(this.runes.first);
  }
}
