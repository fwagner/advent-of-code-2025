import 'package:aoc25_2/aoc25_2.dart';
import 'package:test/test.dart';

void main() {
  test("example", () {
    final input =
        "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124";

    expect(findAndAddInvalidIds(input), 4174379265);
  });
  group("singlePatterns", () {
    final params = {
      "11-22": 33,
      "95-115": 210,
      "998-1012": 2009,
      "1188511880-1188511890": 1188511885,
      "222220-222224": 222222,
      "1698522-1698528": 0,
      "446443-446449": 446446,
      "38593856-38593862": 38593859,
      "565653-565659": 565656,
      "824824821-824824827": 824824824,
      "2121212118-2121212124": 2121212121,
    };

    for (var entry in params.entries) {
      test("pattern_${entry.key}", () {
        expect(processRange(entry.key), entry.value);
      });
    }
  });
  group('containsPattern', () {
    test("containsPattern", () {
      expect(containsPattern("11"), isTrue);
      expect(containsPattern("22"), isTrue);
      expect(containsPattern("1010"), isTrue);
      expect(containsPattern("1188511885"), isTrue);
      expect(containsPattern("222222"), isTrue);
      expect(containsPattern("446446"), isTrue);
      expect(containsPattern("38593859"), isTrue);
    });
  });
}
