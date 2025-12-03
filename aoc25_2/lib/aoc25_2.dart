import 'dart:ffi';

int findAndAddInvalidIds(String input) {
  final ranges = input.split(",");
  return ranges.map(processRange).fold(0, (sum, result) => sum + result);
}

int processRange(String range) {
  final parts = range.split("-");
  final min = int.parse(parts[0]);
  final max = int.parse(parts[1]);
  var patternSum = 0;
  for (var id = min; id <= max; id++) {
    patternSum += containsPattern(id.toString()) ? id : 0;
  }
  return patternSum;
}

/*// Part I
bool containsPattern(String id) {
  if (id.length.isOdd) return false;
  final end = (id.length / 2).toInt();
  final pattern = id.substring(0, end);
  return id.endsWith(pattern);
}*/

bool containsPattern(String id) {
  final maxWindowSize = (id.length / 2).toInt();
  for (var windowSize = maxWindowSize; windowSize > 0; windowSize--) {
    if (id.length % windowSize != 0) continue;
    final pattern = id.substring(0, windowSize);
    final matcher = pattern
        .padRight(id.length, pattern)
        .substring(0, id.length);
    if (pattern.startsWith("0")) continue;
    if (id == matcher) {
      print("$id == $matcher");
      return true;
    }
  }
  return false;
}
