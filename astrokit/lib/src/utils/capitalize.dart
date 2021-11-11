extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    if (length == 1) return toUpperCase();
    if (split(' ').length > 1) {
      return split(' ').map((word) => word.capitalize()).join(' ');
    }
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
