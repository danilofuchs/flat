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
      if (value is Map) {
        for (final entry in value.entries) {
          current[k] ??= <String, dynamic>{};
          current[k][entry.key] = entry.value;
        }
      } else if (i == keys.length - 1) {
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
