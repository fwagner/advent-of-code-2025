import 'package:equatable/equatable.dart';

class Term extends Equatable {
  final List<int> operands;
  final String operation;

  Term({required this.operands, required this.operation});

  int calculate() {
    if (operands.isEmpty) {
      throw ArgumentError("Term cannot be calculated.");
    }
    if (operands.length == 1) {
      return operands.first;
    }

    return operands
        .skip(1)
        .fold(
          operands.first,
          (result, item) => _performOperation(result, item),
        );
  }

  int _performOperation(int left, int right) => switch (operation) {
    '*' => left * right,
    '+' => left + right,
    _ => throw ArgumentError("Unknown operation '$operation"),
  };

  int operator +(int other) => calculate() + other;

  @override
  List<Object?> get props => [operands, operation];
}
