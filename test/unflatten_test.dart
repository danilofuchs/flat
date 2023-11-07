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
        },
      };

      final result = unflatten(obj);

      expect(result, expected);
    });

    test('Object inside array', () {
      const obj = {
        'hello.0.world.again': 'good morning',
      };

      const expected = {
        "hello": [
          {
            "world": {
              "again": 'good morning',
            },
          },
        ],
      };

      final result = unflatten(obj);

      expect(result, expected);
    });

    test('Fails on repeated key', () {
      const obj = {
        'hello.lorem.ipsum': 'again',
        'hello.lorem.dolor': 'sit',
        'world.lorem.ipsum': 'again',
        'world.lorem.dolor': 'sit',
        'world': {'greet': 'hello'},
      };

      expect(() => unflatten(obj), throwsArgumentError);
    });

    test('Fails on nested Map', () {
      const obj = {
        'world': {'greet': 'hello'},
      };

      expect(() => unflatten(obj), throwsArgumentError);
    });

    test('Fails on nested nested Map', () {
      const obj = {
        'hello.lorem.ipsum': {
          'world': {'greet': 'hello'},
        },
      };

      expect(() => unflatten(obj), throwsArgumentError);
    });

    test('Custom Delimiter', () {
      const obj = {
        'hello world again': 'good morning',
      };

      const expected = {
        "hello": {
          "world": {
            "again": 'good morning',
          },
        },
      };

      final result = unflatten(obj, delimiter: ' ');

      expect(result, expected);
    });

    test('Should unflatten array', () {
      const obj = {
        'a.0': 'foo',
        'a.1': 'bar',
      };

      const expected = {
        'a': ['foo', 'bar'],
      };

      final result = unflatten(obj);

      expect(result, expected);
    });

    test('Does not interpret keys with numbers as arrays', () {
      const obj = {'1key.2_key': 'ok'};

      const expected = {
        '1key': {'2_key': 'ok'},
      };

      final result = unflatten(obj);

      expect(result, expected);
    });
  });
}
