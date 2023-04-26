extension StringConversions on String {
  /// Capitalize first letter of the string.
  String get capitalizeFirstLetter =>
      replaceFirst(this[0], this[0].toUpperCase());

  // String get inCaps =>
  //     length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get capitalizeFirstofEach => replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.capitalizeFirstLetter)
      .join(" ");
}
