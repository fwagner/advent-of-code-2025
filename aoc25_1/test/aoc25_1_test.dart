import 'package:aoc25_1/aoc25_1.dart';
import 'package:test/test.dart';

void main() {
  group('calc', () {
    test('moving to zero in one step', () {
      final moves = ["L50"];
      expect(calc(moves), 1);
    });

    test('from zero to zero', () {
      final moves = ["L50", "R1000"];
      expect(calc(moves), 11);
    });

    test('to zero with multiple revolutions (right)', () {
      final moves = ["R150"];
      expect(calc(moves), 2);
    });

    test('to zero with multiple revolutions (left)', () {
      final moves = ["L150"];
      expect(calc(moves), 2);
    });

    test('over zero with one revolution (left)', () {
      final moves = ["L70"];
      expect(calc(moves), 1);
    });

    test('over zero with one revolution (right)', () {
      final moves = ["R70"];
      expect(calc(moves), 1);
    });

    test('example', () {
      final moves = [
        "L68",
        "L30",
        "R48",
        "L5",
        "R60",
        "L55",
        "L1",
        "L99",
        "R14",
        "L82",
      ];
      expect(calc(moves), 6);
    });
  });
}
