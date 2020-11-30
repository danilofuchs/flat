import 'package:flat/flat.dart';

// ignore_for_file: avoid_print

void main() {
  final flat = flatten({
    "a": 1,
    "b": {"c": 2}
  });
  print(flat);
}
