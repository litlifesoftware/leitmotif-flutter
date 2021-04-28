extension DateTimeAgeConversion on DateTime {
  /// Calculates the age of a provided event.
  ///
  /// Returns an [int] value describing the age in years.
  int get convertToAgeInYears {
    // Store the current time.
    DateTime now = DateTime.now();
    // Calculate the raw age.
    int age = now.year - this.year;
    // Decrease the age depending on the event's month and day.
    //
    // If the event's month is after the current calendar month, decrease the
    // age by one.
    if (this.month > now.month) {
      age--;
      // Else if the same month is present, check the day value and decrease the
      // age by one if necessary.
    } else if ((now.month == this.month) && this.day > now.day) {
      age--;
    }
    return age;
  }
}
