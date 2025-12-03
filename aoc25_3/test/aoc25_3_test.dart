import 'package:aoc25_3/aoc25_3.dart';
import 'package:test/test.dart';

void main() {
  final input = [
    "987654321111111",
    "811111111111119",
    "234234234234278",
    "818181911112111",
  ];

  test('sumJoltages', () {
    expect(totalJoltage(input), 3121910778619);
  });

  test('maxJoltagePerBank', () {
    expect(joltagePerBank("987654321111111"), 987654321111);
    expect(joltagePerBank("811111111111119"), 811111111119);
    expect(joltagePerBank("234234234234278"), 434234234278);
    expect(joltagePerBank("818181911112111"), 888911112111);
  });
}
