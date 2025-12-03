import 'dart:math';

int totalJoltage(List<String> banks) {
  return banks.map(joltagePerBank).fold(0, (sum, element) => sum + element);
}

int joltagePerBank(String bank) {
  final length = 12;
  var sum = 0;
  var prevPos = -1;

  for (int i = 0; i < length; i++) {
    final digit = findMaxInRange(
      bank,
      prevPos + 1,
      bank.length - (length - i - 1),
    );
    prevPos = digit.position;
    print(digit);
    sum += (digit.element * pow(10, length - i - 1)).toInt();
  }
  return sum;
}
/* PART I
int joltagePerBank(String bank) {
  final firstDigit = findMaxInRange(bank, 0, bank.length - 1);

  final lastDigit = findMaxInRange(bank, firstDigit.position + 1, bank.length);

  return (firstDigit.element * 10) + lastDigit.element;
}*/

({int element, int position}) findMaxInRange(
  String string,
  int start,
  int end,
) {
  var max = (0, 0);

  for (var i = start; i < end; i++) {
    final element = int.parse(string.substring(i, i + 1));
    if (element > max.$1) {
      max = (element, i);
    }
  }

  return (element: max.$1, position: max.$2);
}
