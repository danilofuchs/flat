import 'package:flat/flat.dart';

// ignore_for_file: avoid_print

void main() {
  final flat = flatten(
    {
      "a": 1,
      "list1": ["item1", "item2"],
      "f": {
        "list2": ["item3", "item4", "item5"],
        "list3": [
          {"item3": "item47"},
          {"item4": "item48"},
          {"item5": "item49"},
        ],
        "g": 2,
        "h": true,
        "j": "text",
      },
    },
  );
  print(flat);

  print(unflatten(flat));
}
