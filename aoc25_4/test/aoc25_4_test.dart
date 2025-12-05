import 'package:aoc25_4/aoc25_4.dart';
import 'package:test/test.dart';

void main() {
  final input = """..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.""";
  group("Warehouse", () {
    test("can parse successfully", () {
      final warehouse = Warehouse.fromString(input);
      expect(warehouse.toString(), input);
    });

    test("example_part1", () {
      final expectedResult = """..xx.xx@x.
x@@.@.@.@@
@@@@@.x.@@
@.@@@@..@.
x@.@@@@.@x
.@@@@@@@.@
.@.@.@.@@@
x.@@@.@@@@
.@@@@@@@@.
x.x.@@@.x.""";

      final warehouse = Warehouse.fromString(input);
      final movableRolls = warehouse.identifyMoveableRolls();
      expect(warehouse.toString(), expectedResult);
      expect(movableRolls, 13);
    });

    test("example_part2", () {
      final expectedResult = """..........
..........
..........
....@@....
...@@@@...
...@@@@@..
...@.@.@@.
...@@.@@@.
...@@@@@..
....@@@...""";

      final warehouse = Warehouse.fromString(input);
      final removeableRolls = warehouse.removeAllMoveableRolls();
      expect(warehouse.toString(), expectedResult);
      expect(removeableRolls, 43);
    });
  });
}
