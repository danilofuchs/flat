/// Flatten a nested Map into a single level map
///
/// If no [delimiter] is specified, will separate depth levels by `.`.
///
/// If you don't want to flatten arrays (with 0, 1,... indexes), use [safe] mode.
///
/// To avoid circular reference issues or huge calculations, you can specify the [maxDepth]
/// the function will traverse.
Map<String, dynamic> flatten(
  Map<String, dynamic> target, {
  String delimiter = ".",
  bool safe = false,
  int maxDepth,
}) {
  Map<String, Object> result = {};

  void step(
    Map<String, dynamic> obj, [
    String previousKey,
    int currentDepth = 1,
  ]) {
    obj.forEach((key, value) {
      final newKey = previousKey != null ? "$previousKey$delimiter$key" : key;

      if (maxDepth != null && currentDepth >= maxDepth) {
        result[newKey] = value;
        return;
      }
      if (value is Map<String, dynamic>) {
        return step(value, newKey, currentDepth + 1);
      }
      if (value is List && !safe) {
        return step(_listToMap(value), newKey, currentDepth + 1);
      }
      result[newKey] = value;
    });
  }

  step(target);

  return result;
}

Map<String, dynamic> _listToMap(List<dynamic> list) =>
    list.asMap().map((key, value) => MapEntry(key.toString(), value));
