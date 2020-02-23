import 'package:flat/flat.dart';

void main() {
  final flat = flatten({
    "a": 1,
    "b": {"c": 2}
  });
  print(flat);
}
