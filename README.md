# flat

Take a nested Map and flatten it with delimited keys. Entirely based on node.js [flat](https://www.npmjs.com/package/flat).

> It does not achieve feature parity yet, as some options are missing from `flatten` (maxDepth, transformKey) and `unflatten` is not yet implemented.

> Currently, it bails out of a tree if it finds something different than a `Map` or `List`.

## Usage

```dart
import 'package:flat/flat.dart';

flatten({
  'key1': {'keyA': 'valueI'},
  'key2': {'keyB': 'valueII'},
  'key3': {
    'a': {
      'b': {'c': 2}
    }
  }
});

// {
//   'key1.keyA': 'valueI',
//   'key2.keyB': 'valueII',
//   'key3.a.b.c': 2
// };
```

## Options

### delimiter

Use a custom delimiter for flattening your objects, instead of `.`

### safe

When enabled, flat will preserve arrays and their contents. This is disabled by default.

```dart
import 'package:flat/flat.dart';

flatten({
  'this': [
    {'contains': 'arrays'},
    {
      'preserving': {'them': 'for you'}
    }
  ]
}, safe: true);

// {
//   'this': [
//     {'contains': 'arrays'},
//     {
//       'preserving': {'them': 'for you'}
//     }
//   ]
// };
```

### maxDepth

Maximum number of nested objects to flatten.

```dart
import 'package:flat/flat.dart';

flatten({
  'key1': {'keyA': 'valueI'},
  'key2': {'keyB': 'valueII'},
  'key3': {
    'a': {
      'b': {'c': 2}
    }
  }
}, maxDepth: 2);

// {
//   'key1.keyA': 'valueI',
//   'key2.keyB': 'valueII',
//   'key3.a': {
//     'b': {'c': 2}
//   }
// };
```
