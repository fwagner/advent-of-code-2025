import 'package:aoc25_4/aoc25_4.dart';
import 'package:aoc25_4/input.dart';

void main(List<String> arguments) {
  final warehouse = Warehouse.fromString(input);
  print(
    'Number of moveable rolls (first iteration): ${warehouse.identifyMoveableRolls()}!',
  );

  final warehouse2 = Warehouse.fromString(input);
  print(
    'Total number of moveable rolls (multiple iterations): ${warehouse2.removeAllMoveableRolls()}',
  );
}
