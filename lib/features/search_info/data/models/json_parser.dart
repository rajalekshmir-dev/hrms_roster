class JsonParser {
  static double? toDouble(dynamic value) {
    if (value == null) return null;

    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);

    return null;
  }

  static int? toInt(dynamic value) {
    if (value == null) return null;

    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);

    return null;
  }

  static String? toStringValue(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }
}
