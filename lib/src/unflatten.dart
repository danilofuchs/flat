/// Unflatten a map with keys such as `a.b.c: value` to a nested Map structure `{a: {b: {c: value}}}`.
///
/// If no [delimiter] is specified, will separate depth levels by `.`.
///
/// Unflattens arrays given that the keys are integers.
///
/// Throws [ArgumentError] if any key is already a Map or List.
///
/// Throws [ArgumentError] if there are conflicting keys.
Map<String, dynamic> unflatten(
  Map<String, dynamic> flatMap, {
  String delimiter = ".",
}) {
  final Map<String, dynamic> result = {};

  flatMap.forEach((key, value) {
    if (value is Map) {
      throw ArgumentError('Expected flat map, but key "$key" is a Map');
    }
    if (value is List) {
      throw ArgumentError('Expected flat map, but key "$key" is a List');
    }
  });

  flatMap.forEach((key, value) {
    final keys = key.split(delimiter);
    dynamic current = result;

    for (int i = 0; i < keys.length; i++) {
      final k = keys[i];
      if (i == keys.length - 1) {
        // Last key, assign the value
        if (_isInteger(k)) {
          final int index = int.parse(k);
          while ((current as List).length <= index) {
            current.add(null); // Padding the array
          }
          current[index] = value;
        } else {
          if ((current as Map).containsKey(k)) {
            throw ArgumentError('Cannot unflatten, key "$k" already exists');
          }
          current[k] = value;
        }
      } else {
        // Not the last key, we might need to create a map or array
        if (_isInteger(k)) {
          final int index = int.parse(k);
          while ((current as List).length <= index) {
            current.add(null); // Padding the array
          }
          // Ensure that we have a Map at the index if the next key is not an integer
          if (!_isInteger(keys[i + 1]) &&
              (current[index] == null || current[index] is! Map)) {
            current[index] = {};
          }
          current = current[index];
        } else {
          if ((current as Map)[k] == null) {
            // Next key will tell us whether to create a list or a map
            current[k] = _isInteger(keys[i + 1]) ? [] : <String, dynamic>{};
          }
          current = current[k];
        }
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
