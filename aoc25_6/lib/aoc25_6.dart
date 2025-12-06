import 'dart:math';

import 'package:aoc25_6/term.dart';

class WorksheetParser {
  final List<String> worksheetLines;
  final bool useCephalopodMath;
  var position = 0;

  WorksheetParser({
    required this.worksheetLines,
    this.useCephalopodMath = false,
  });

  factory WorksheetParser.fromString(
    String input, [
    useCephalopodMath = false,
  ]) => WorksheetParser(
    worksheetLines: input.split('\n'),
    useCephalopodMath: useCephalopodMath,
  );

  int get _numberOfColumns => worksheetLines.first.length;

  List<Term> get allTerms {
    final terms = <Term>[];
    var term = nextTerm();
    while (term != null) {
      terms.add(term);
      term = nextTerm();
    }
    return terms;
  }

  Term? nextTerm() {
    if (position >= _numberOfColumns) {
      return null;
    }
    final nextColumnEnd = _findColumnEnd();
    final items = worksheetLines
        .map((l) => l.substring(position, nextColumnEnd + 1))
        .toList();
    position = nextColumnEnd + 1;
    return useCephalopodMath
        ? _createCephalopodTerm(items)
        : _createTerm(items);
  }

  int _findColumnEnd() {
    var idx = position;
    var found = false;
    while (idx < _numberOfColumns && !found) {
      found = worksheetLines.every((l) => l[idx] == ' ');
      idx += 1;
    }
    return idx - 1;
  }

  Term _createTerm(List<String> items) {
    final operands = items
        .take(items.length - 1)
        .map((e) => int.parse(e.trim()))
        .toList();
    final operation = items.last.trim();
    return Term(operands: operands, operation: operation);
  }

  Term _createCephalopodTerm(List<String> items) {
    final operands = _getOperands(items.take(items.length - 1));
    final operation = items.last.trim();
    return Term(operands: operands, operation: operation);
  }

  List<int> _getOperands(Iterable<String> items) {
    return List.generate(
          items.first.length,
          (idx) => items.map((l) => l[idx]).toList(),
        ).reversed
        .where((e) => !e.every((s) => s.trim().isEmpty))
        .map((e) => int.parse(e.join('')))
        .toList();
  }
}
