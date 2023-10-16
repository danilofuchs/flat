/// Flatten a nested Map into a single level map
///
/// If no [delimiter] is specified, will separate depth levels by `.`.
///
/// If you don't want to flatten arrays (with 0, 1,... indexes),
/// use [safe] mode.
///
/// To avoid circular reference issues or huge calculations,
/// you can specify the [maxDepth] the function will traverse.
Map<String, dynamic> flatten(
  Map<String, dynamic> target, {
  String delimiter = ".",
  bool safe = false,
  int? maxDepth,
}) {
  final result = <String, dynamic>{};

  void step(
    Map<String, dynamic> obj, [
    String? previousKey,
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
        return step(
          _listToMap(value),
          newKey,
          currentDepth + 1,
        );
      }
      result[newKey] = value;
    });
  }

  step(target);

  return result;
}

Map<String, T> _listToMap<T>(List<T> list) =>
    list.asMap().map((key, value) => MapEntry(key.toString(), value));

Map<String, dynamic> unflatten(
  Map<String, dynamic> flatMap, {
  String delimiter = ".",
}) {
  final Map<String, dynamic> result = {};

  flatMap.forEach((key, value) {
    // Split the flattened key by the specified delimiter.
    final keys = key.split(
      delimiter,
    );

    dynamic current = result;

    for (int i = 0; i < keys.length; i++) {
      final k = keys[i];
      if (i == keys.length - 1) {
        if (_isInteger(k)) {
          // This means that we have to do with a list instead
          (current as List).add(value);
        } else {
          // If we're at the last key in the hierarchy, assign the value.
          (current as Map)[k] = value;
        }
      } else {
        // If the key doesn't exist, create a new map or list for it.
        final nextKey = keys[i + 1];
        if (_isInteger(nextKey)) {
          // This means that we have to do with a list so we create a list instead of a Map
          (current as Map)[k] ??= [];
        } else {
          (current as Map)[k] ??= <String, dynamic>{};
        }
        // Move one level deeper into the map.
        current = current[k];
      }
    }
  });

  return result;
}

bool _isInteger(String? value) {
  if (value == null) {
    return false;
  }
  return int.tryParse(value) != null;
}
