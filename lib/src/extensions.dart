/// Extension for capitalizing a string.
extension StringCapitalizationExtension on String {
  /// Capitalize the first letter of the string.
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
