import 'dart:math';

class Range implements Comparable {
  final int start;
  final int end;

  Range({required this.start, required this.end});

  factory Range.fromString(String input) {
    final parts = input.split('-');
    if (parts.length < 2) {
      throw ArgumentError(
        "A range should have at least two parts, found: ${parts.length} in $input.",
      );
    }
    return Range(start: int.parse(parts[0]), end: int.parse(parts[1]));
  }

  bool contains(int number) => number >= start && number <= end;

  bool overlaps(Range other) => contains(other.start) || contains(other.end);

  Range union(Range other) {
    if (!overlaps(other)) {
      throw ArgumentError("Range $this and $other have no overlap.");
    }

    return Range(start: min(start, other.start), end: max(end, other.end));
  }

  int get length => end - start + 1;

  @override
  int compareTo(other) => start.compareTo(other.start);
}

class Inventory {
  final List<Range> freshRanges;
  final List<int> ingredientIds;

  Inventory({required this.freshRanges, required this.ingredientIds});

  factory Inventory.fromString(String input) {
    final parts = input.split('\n\n');
    if (parts.length != 2) {
      throw ArgumentError(
        "Expecting two sections in input, found: ${parts.length}",
      );
    }
    final freshRanges = parts[0].split('\n').map(Range.fromString).toList();
    freshRanges.sort();
    final ingredientIds = parts[1].split('\n').map(int.parse).toList();
    return Inventory(freshRanges: freshRanges, ingredientIds: ingredientIds);
  }

  int numberOfFreshIngredients() {
    return ingredientIds
        .where((id) => freshRanges.any((r) => r.contains(id)))
        .length;
  }

  int numberOfAllFreshIngredients() {
    _deduplicateRanges();
    return freshRanges
        .map((r) => r.length)
        .fold(0, (sum, length) => sum + length);
  }

  void _deduplicateRanges() {
    var idx = 0;
    while (idx < freshRanges.length) {
      var range = freshRanges[idx];
      final idxsToRemove = <int>[];
      for (var y = idx + 1; y < freshRanges.length; y++) {
        final other = freshRanges[y];
        if (range.overlaps(other)) {
          range = range.union(other);
          idxsToRemove.add(y);
        } else {
          // As freshRanges is ordered by start, there cannot be a range with a start that is larger than range.start that we haven't already processed.
          // So, when other is not overlapping range, we know that there cannot be another range with a start that is smaller than other.start.
          // Thus no range from the list can overlap range anymore and we can stop looking.
          break;
        }
      }
      freshRanges[idx] = range;
      for (var i in idxsToRemove.reversed) {
        freshRanges.removeAt(i);
      }
      idx += 1;
    }
  }
}
