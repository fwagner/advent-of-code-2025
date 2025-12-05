import 'package:aoc25_5/aoc25_5.dart';
import 'package:aoc25_5/input.dart';

void main(List<String> arguments) {
  final inventory = Inventory.fromString(input);
  print(
    'Number of fresh ingredient ids: ${inventory.numberOfFreshIngredients()}',
  );

  print(
    'Number of all fresh ingredient ids in ranges: ${inventory.numberOfAllFreshIngredients()}',
  );
}
