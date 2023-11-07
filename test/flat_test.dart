import 'package:flat/src/flatten.dart';
import 'package:flat/src/unflatten.dart';
import 'package:test/test.dart';

void main() {
  group('flatten and unflatten', () {
    test(
        'Order of keys should not be changed after round trip flatten/unflatten',
        () {
      const obj = {
        'b': 1,
        'abc': {
          'c': [
            {
              'd': 1,
              'bca': 1,
              'a': 1,
            },
          ],
        },
        'a': 1,
      };

      final result = unflatten(flatten(obj));

      expect(obj.keys, result.keys);
      expect((obj['abc']! as Map).keys, (result['abc']! as Map).keys);
      expect(
        // ignore: avoid_dynamic_calls
        (obj['abc']! as Map)['c'][0].keys,
        (result['abc']! as Map).keys,
      );
    });
  });
}
