const startingPosition = 50;

int calc(List<String> moves) {
  int lastPos = startingPosition;
  int numberOfZeros = 0;
  for (var i = 0; i < moves.length; i++) {
    final move = parseMove(moves[i]);
    final normalizedSteps = move.normalizedSteps;
    numberOfZeros += move.revolutionsOverZero;

    if (normalizedSteps != 0) {
      var result = turn(lastPos, normalizedSteps);
      numberOfZeros += result.hasMovedToOrOverZero ? 1 : 0;
      lastPos = result.nextPos;
    }
  }
  return numberOfZeros;
}

/// Takes the encoded move and splits into direction and steps
/// It automatically checks if the steps constitute one ore more full revolution of the dial.
///
/// * move: The move to parse
///
/// Returns:
/// * normalizedSteps: The number of steps the dial needs to be turned. If the step count constitutes on or more full revolutions of the dial
///    , it will only output the number of steps beyond the full revolution(s). The direction is encoded into the sign of the normalizedStep (Left: negative steps, right: positive steps).
/// * revolutionsOverZero: Contains the number of times the dial moves over 0 depending of the number of full revolutions contained in steps.
({int normalizedSteps, int revolutionsOverZero}) parseMove(String move) {
  final direction = move.substring(0, 1);
  final steps = int.parse(move.substring(1));
  final normalizedSteps = steps % 100;
  final revolutionsOverZero = (steps / 100).toInt();
  return (
    normalizedSteps: directionToSign(direction) * normalizedSteps,
    revolutionsOverZero: revolutionsOverZero,
  );
}

int directionToSign(String direction) {
  return switch (direction) {
    "L" => -1,
    "R" => 1,
    _ => throw ArgumentError("Invalid direction: $direction"),
  };
}

/// Calculates the position of the dial after moving it the given number of steps.
/// This returns the nextPos and if the dial was moved over 0 during the operation.
/// This method can only handle partial revolutions, as full revolutions are already handled by parseMove.
({int nextPos, bool hasMovedToOrOverZero}) turn(int currentPos, int steps) {
  final pos = currentPos + steps;
  final nextPos =
      pos % 100; // This works because dart implements euklidian modulo.

  // Either the dial rested on zero...
  // or it moved left or right over 0 but the revolution did not start at 0.
  final hasMovedToOrOverZero =
      nextPos == 0 || (currentPos != 0 && (pos < 0 || pos >= 100));

  return (nextPos: nextPos, hasMovedToOrOverZero: hasMovedToOrOverZero);
}
