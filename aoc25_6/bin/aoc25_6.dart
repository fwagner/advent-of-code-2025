import 'package:aoc25_6/aoc25_6.dart' as aoc25_6;
import 'package:aoc25_6/input.dart';

void main(List<String> arguments) {
  final parser = aoc25_6.WorksheetParser.fromString(input);
  final result = parser.allTerms.fold(0, (sum, term) => term + sum);
  print('Sum of all terms (our math): $result');

  final cephalopodParser = aoc25_6.WorksheetParser.fromString(input, true);
  final cephalopodResult = cephalopodParser.allTerms.fold(
    0,
    (sum, term) => term + sum,
  );
  print('Sum of all terms (cephalopod math): $cephalopodResult');
}
