typedef Point = ({int x, int y});
typedef Location = ({bool isOccupied, bool canMove});

class Warehouse {
  static const neighbors = <Point>[
    (x: -1, y: -1),
    (x: -1, y: 0),
    (x: 0, y: -1),
    (x: 1, y: -1),
    (x: -1, y: 1),
    (x: 1, y: 0),
    (x: 0, y: 1),
    (x: 1, y: 1),
  ];
  final Map<Point, Location> plan;
  final Point maxDimensions;

  Warehouse({required this.plan, required this.maxDimensions});

  factory Warehouse.fromString(String input) {
    final List<String> lines = input.split("\n");
    if (lines.isEmpty) {
      return Warehouse(plan: {}, maxDimensions: (x: 0, y: 0));
    } else {
      final plan = <Point, Location>{};
      final maxDimensions = (x: lines.first.length, y: lines.length);
      for (var y = 0; y < lines.length; y++) {
        final line = lines[y].split('');
        for (var x = 0; x < lines.length; x++) {
          plan.putIfAbsent((
            x: x,
            y: y,
          ), () => (isOccupied: line[x] == "@", canMove: false));
        }
      }
      return Warehouse(plan: plan, maxDimensions: maxDimensions);
    }
  }

  int identifyMoveableRolls() {
    var movableRolls = 0;
    for (var y = 0; y < maxDimensions.y; y++) {
      for (var x = 0; x < maxDimensions.x; x++) {
        final location = plan[(x: x, y: y)];
        if (location?.isOccupied == false) continue;
        final occupiedNeighbors = neighbors
            .map(
              (n) => plan[(x: x + n.x, y: y + n.y)],
            ) // find all the adjacent fields to the current point (x, y)
            .map(
              (location) => switch (location) {
                (canMove: _, isOccupied: true) => true, // is occupied
                (canMove: _, isOccupied: false) || null =>
                  false, // is unoccupied or outside of our warehouse floor, in which case it also counts as unoccupied
              },
            )
            .where(
              (e) => e == true,
            ) // we're only interested in the occupied locations
            .length; // this gives us the number of occupied neighboring fields
        final canMove = occupiedNeighbors < 4;
        plan[(x: x, y: y)] = (
          isOccupied: location!.isOccupied,
          canMove: canMove,
        );
        movableRolls += canMove ? 1 : 0;
      }
    }
    return movableRolls;
  }

  int removeAllMoveableRolls() {
    var movableRolls = identifyMoveableRolls();
    var totalRollsRemoved = 0;
    while (movableRolls > 0) {
      _removeMoveableRolls();
      totalRollsRemoved += movableRolls;
      movableRolls = identifyMoveableRolls();
    }
    return totalRollsRemoved;
  }

  void _removeMoveableRolls() {
    for (var entry in plan.entries) {
      if (entry.value.canMove) {
        plan[entry.key] = (canMove: false, isOccupied: false);
      }
    }
  }

  @override
  String toString() {
    var output = <String>[];
    for (var y = 0; y < maxDimensions.y; y++) {
      var line = <String>[];
      for (var x = 0; x < maxDimensions.x; x++) {
        final location = plan[(x: x, y: y)];
        final char = switch (location) {
          (canMove: true, isOccupied: _) => "x",
          (canMove: _, isOccupied: true) => "@",
          (canMove: _, isOccupied: _) || null => ".",
        };
        line.add(char);
      }
      output.add(line.join(''));
    }
    return output.join("\n");
  }
}
