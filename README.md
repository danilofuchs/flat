# flat

Take a nested Map and flatten it with delimited keys. Entirely based on node.js [flat](https://www.npmjs.com/package/flat).

> It does not achieve feature parity yet, as some options are missing from `flatten` (maxDepth, transformKey).

> Currently, it bails out of a tree if it finds something different than a `Map` or `List`.

## Usage

```dart
import 'package:flat/flat.dart';

flatten(
    {
      "a": 1,
      "list1": ["item1", "item2"],
      "f": {
        "list2": ["item3", "item4", "item5"],
        "g": 2,
        "h": true,
        "j": "text",
      },
    },
  );
  
// {
//   "a": 1,
//   "list1.0": "item1",
//   "list1.1": "item2",
//   "f.list2.0": "item3",
//   "f.list2.1": "item4",
//   "f.list2.2": "item5",
//   "f.g": 2,
//   "f.h": true,
//   "f.j": "text"
// }

unflatten({
  "a": 1,
  "list1.0": "item1",
  "list1.1": "item2",
  "f.list2.0": "item3",
  "f.list2.1": "item4",
  "f.list2.2": "item5",
  "f.g": 2,
  "f.h": true,
  "f.j": "text"
});

// {
//   "a": 1,
//   "list1": ["item1", "item2"],
//   "f": {
//     "list2": ["item3", "item4", "item5"],
//     "g": 2,
//     "h": true,
//     "j": "text",
//   },
// }

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
