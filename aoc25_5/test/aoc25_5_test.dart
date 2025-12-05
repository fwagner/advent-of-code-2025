import 'package:aoc25_5/aoc25_5.dart';
import 'package:test/test.dart';

void main() {
  final input = """3-5
10-14
16-20
12-18

1
5
8
11
17
32""";

  test('example', () {
    final inventory = Inventory.fromString(input);
    expect(inventory.numberOfFreshIngredients(), 3);
  });

  test('deduplicate ranges', () {
    final inventory = Inventory.fromString(input);
    expect(inventory.numberOfAllFreshIngredients(), 14);
  });
}
