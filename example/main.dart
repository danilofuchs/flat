import 'package:flat/flat.dart';

main() {
  final flat = flatten({
    "a": 1,
    "b": {"c": 2}
  });
  print(flat);
}
