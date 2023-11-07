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
        'hello.0.again': 'good morning',
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

    test('nested objects do not clobber each other when a.b inserted before a',
        () {
      final obj = <String, dynamic>{};
      obj['foo.bar'] = {'t': 123};
      obj['foo'] = {'p': 333};

      const expected = {
        "foo": {
          "bar": {
            't': 123,
          },
          'p': 333,
        },
      };

      final result = unflatten(obj);

      expect(result, expected);
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

    test('Messy', () {
      const obj = {
        'hello.world': 'again',
        'lorem.ipsum': 'another',
        'good.morning': {
          'hash.key': {
            'nested.deep': {
              'and.even.deeper.still': 'hello',
            },
          },
        },
        'good.morning.again': {'testing.this': 'out'},
      };

      const expected = {
        'hello': {'world': 'again'},
        'lorem': {'ipsum': 'another'},
        'good': {
          'morning': {
            'hash': {
              'key': {
                'nested': {
                  'deep': {
                    'and': {
                      'even': {
                        'deeper': {'still': 'hello'},
                      },
                    },
                  },
                },
              },
            },
            'again': {
              'testing': {'this': 'out'},
            },
          },
        },
      };

      final result = unflatten(obj);

      expect(result, expected);
    });

    test('Should be unflatten array', () {
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

    test('Empty objects should not be removed', () {
      const obj = {'foo': [], 'bar': {}};

      const expected = {
        'foo': [],
        'bar': {},
      };

      final result = unflatten(obj);

      expect(result, expected);
    });
  });
}
