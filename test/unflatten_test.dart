import 'package:flat/flat.dart';
import 'package:test/test.dart';

void main() {
  test('Unflattens map', () {
    const obj = {
      "a": 1,
      "list1.0": "item1",
      "list1.1": "item2",
      "f.list2.0": "item3",
      "f.list2.1": "item4",
      "f.list2.2": "item5",
      "f.g": 2,
      "f.h": true,
      "f.j": "text"
    };

    const expected = {
      "a": 1,
      "list1": ["item1", "item2"],
      "f": {
        "list2": ["item3", "item4", "item5"],
        "g": 2,
        "h": true,
        "j": "text",
      },
    };

    final result = unflatten(obj);

    expect(result, expected);
  });
}
