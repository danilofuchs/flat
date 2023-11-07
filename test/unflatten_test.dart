import 'package:flat/flat.dart';
import 'package:test/test.dart';

void main() {
  group('unflatten', () {
    test('Nested once', () {
      const obj = {
        'hello.world': 'good morning',
      };

      const expected = {
        "hello": {
          "world": "good morning",
        },
      };

      final result = unflatten(obj);

      expect(result, expected);
    });

    test('Nested twice', () {
      const obj = {
        'hello.world.again': 'good morning',
      };

      const expected = {
        "hello": {
          "world": {
            "again": 'good morning',
          },
        }
      };

      final result = unflatten(obj);

      expect(result, expected);
    });

    test('Multiple Keys', () {
      const obj = {
        'hello.lorem.ipsum': 'again',
        'hello.lorem.dolor': 'sit',
        'world.lorem.ipsum': 'again',
        'world.lorem.dolor': 'sit',
        'world': {'greet': 'hello'},
      };

      const expected = {
        "hello": {
          "lorem": {
            'ipsum': 'again',
            'dolor': 'sit',
          },
        },
        'world': {
          'greet': 'hello',
          'lorem': {
            'ipsum': 'again',
            'dolor': 'sit',
          },
        },
      };

      final result = unflatten(obj);

      expect(result, expected);
    });
  });
}
