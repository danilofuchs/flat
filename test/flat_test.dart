import 'package:test/test.dart';

import 'package:flat/flat.dart';

void main() {
  test('Flattens nested Map', () {
    const obj = {
      "a": 1,
      "b": {"c": 2}
    };

    const expected = {"a": 1, "b.c": 2};

    final result = flatten(obj);

    expect(result, expected);
  });

  test('Preserves empty Map', () {
    const obj = {"a": {}};

    const expected = {"a": {}};

    final result = flatten(obj);

    expect(result, expected);
  });

  test('Flattens List', () {
    const obj = {
      "a": "item",
      "b": [0, 1]
    };

    const expected = {"a": "item", "b.0": 0, "b.1": 1};

    final result = flatten(obj);

    expect(result, expected);
  });

  test('Flattens complex Map', () {
    const obj = {
      "a": 1,
      "b": {
        "c": 2,
        "d": "asd",
        "a": {
          "a": [
            {"where": "a"}
          ]
        }
      }
    };

    const expected = {"a": 1, "b.c": 2, "b.d": "asd", "b.a.a.0.where": "a"};

    final result = flatten(obj);

    expect(result, expected);
  });

  test('Should delimit with optional delimiter parameter', () {
    const obj = {
      "a": 1,
      "b": {"c": 2}
    };

    const expected = {"a": 1, "b_c": 2};

    final result = flatten(obj, delimiter: "_");

    expect(result, expected);
  });

  test('Should not flatten array when in safe mode', () {
    const obj = {
      "a": 1,
      "b": {
        "c": [
          {"d": 2}
        ]
      }
    };

    const expected = {
      "a": 1,
      "b.c": [
        {"d": 2}
      ]
    };

    final result = flatten(obj, safe: true);

    expect(result, expected);
  });

  // test('Should limit depth by maxDepth', () {
  //   const obj = {
  //     "a": {
  //       "b": {
  //         "c": {
  //           "d": {"e": 1}
  //         }
  //       }
  //     }
  //   };

  //   const maxDepth = 3;

  //   const expected = {
  //     "a": {
  //       "b": {"c.d.e": 1}
  //     }
  //   };

  //   final result = flatten(obj, maxDepth: maxDepth);

  //   expect(result, expected);
  // });
}
