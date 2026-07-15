import 'dart:math';

class GameService {
  List<int> generatePuzzle(int size) {
    List<int> pieces = List.generate(size, (index) => index);
    pieces.shuffle(Random());
    return pieces;
  }

  bool isSolved(List<int> pieces) {
    for (int i = 0; i < pieces.length; i++) {
      if (pieces[i] != i) {
        return false;
      }
    }
    return true;
  }
}