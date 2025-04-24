extension Time on DateTime {
  DateTime get withoutTime => DateTime(year, month, day);
}
extension BoolParsing on String {
  bool toBool() {
    return this == "true" || this == "1";
  }
}

extension Parse on String? {
  double? get toDouble => double.tryParse(this?.replaceAll(',', '') ?? '');
}
