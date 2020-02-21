Map<String, dynamic> flatten(
  Map<String, dynamic> obj, {
  String delimiter = ".",
  bool safe = false,
}) {
  scopedFlatten(
    Map<String, dynamic> obj, {
    String newDelimiter,
    bool newSafe,
  }) {
    return flatten(obj,
        delimiter: newDelimiter ?? delimiter, safe: newSafe ?? safe);
  }

  Map<String, Object> result = {};
  obj.forEach((key, value) {
    if (value is Map) {
      result.addAll(scopedFlatten(value).map((deepKey, deepValue) =>
          MapEntry("$key$delimiter$deepKey", deepValue)));
      return;
    }
    if (value is List) {
      if (safe) {
        print(value);
        result[key] = value;
      } else {
        result.addAll(scopedFlatten(listToMap(value)).map(
            (deepKey, deepValue) =>
                MapEntry("$key$delimiter$deepKey", deepValue)));
      }
      return;
    }
    result[key] = value;
  });
  return result;
}

Map<String, dynamic> listToMap(List<dynamic> list) =>
    list.asMap().map((key, value) => MapEntry(key.toString(), value));

main() {
  flatten({"a": 1});
}
