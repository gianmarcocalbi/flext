extension FlextCoreString on String {
  /// Matches only the last `\n` of a series of newlines.
  static final matchOneNewLineRegex = RegExp(r'\n(?!\n)');

  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Converts [this] to Title Case.
  String toTitleCase() {
    if (isEmpty) {
      return this;
    }
    return split(' ').map((s) => s.capitalize()).join(' ');
  }

  /// Replaces the last newline of a serie of newlines.
  String replaceSingleNewLines() {
    return replaceAll(matchOneNewLineRegex, '');
  }

  String ellipsis(int maxLength) {
    if (length > maxLength) {
      return '${substring(0, maxLength - 3)}...';
    }
    return this;
  }

  String trimSubRight(String subStr) {
    if (subStr.isEmpty) {
      return trimRight();
    }
    String s = this;
    while (s.endsWith(subStr)) {
      s = s.substring(0, s.length - subStr.length);
    }
    return s;
  }

  String trimLeftChars(String chars) {
    if (chars.isEmpty) return this;
    var tmp = this;
    while (tmp.startsWith(chars)) {
      tmp = tmp.substring(chars.length);
    }
    return tmp;
  }
}
