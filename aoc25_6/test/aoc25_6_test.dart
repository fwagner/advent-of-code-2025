import 'package:aoc25_6/aoc25_6.dart';
import 'package:aoc25_6/term.dart';
import 'package:test/test.dart';

void main() {
  final input = """123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  """;

  group('Part I', () {
    test('parse', () {
      final parser = WorksheetParser.fromString(input);
      final firstTerm = parser.nextTerm();
      expect(firstTerm, Term(operands: [123, 45, 6], operation: '*'));
      expect(firstTerm!.calculate(), 33210);

      final secondTerm = parser.nextTerm();
      expect(secondTerm, Term(operands: [328, 64, 98], operation: '+'));
      expect(secondTerm!.calculate(), 490);

      final thirdTerm = parser.nextTerm();
      expect(thirdTerm, Term(operands: [51, 387, 215], operation: '*'));
      expect(thirdTerm!.calculate(), 4243455);

      final fourthTerm = parser.nextTerm();

      expect(fourthTerm, Term(operands: [64, 23, 314], operation: '+'));
      expect(fourthTerm!.calculate(), 401);

      expect(parser.nextTerm(), isNull);
    });

    test('example result', () {
      final parser = WorksheetParser.fromString(input);

      final result = parser.allTerms.fold(0, (sum, term) => term + sum);
      expect(result, 4277556);
    });
  });

  group('Part II', () {
    test('parse', () {
      final parser = WorksheetParser.fromString(input, true);
      final firstTerm = parser.nextTerm();
      expect(firstTerm, Term(operands: [356, 24, 1], operation: '*'));
      expect(firstTerm!.calculate(), 8544);

      final secondTerm = parser.nextTerm();
      expect(secondTerm, Term(operands: [8, 248, 369], operation: '+'));
      expect(secondTerm!.calculate(), 625);

      final thirdTerm = parser.nextTerm();
      expect(thirdTerm, Term(operands: [175, 581, 32], operation: '*'));
      expect(thirdTerm!.calculate(), 3253600);

      final fourthTerm = parser.nextTerm();
      expect(fourthTerm, Term(operands: [4, 431, 623], operation: '+'));
      expect(fourthTerm!.calculate(), 1058);

      expect(parser.nextTerm(), isNull);
    });

    test('example result', () {
      final parser = WorksheetParser.fromString(input, true);

      final result = parser.allTerms.fold(0, (sum, term) => term + sum);
      expect(result, 3263827);
    });
  });
}
