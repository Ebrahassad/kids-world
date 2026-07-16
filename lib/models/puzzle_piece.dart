import 'dart:ui';

class PuzzlePiece {
  final int id;

  /// ترتيب القطعة الصحيح داخل الصورة
  final int correctIndex;

  /// ترتيبها الحالي داخل اللوحة
  int currentIndex;

  /// الجزء المقتطع من الصورة
  final Rect sourceRect;

  PuzzlePiece({
    required this.id,
    required this.correctIndex,
    required this.currentIndex,
    required this.sourceRect,
  });

  bool get isCorrect => currentIndex == correctIndex;

  void moveTo(int newIndex) {
    currentIndex = newIndex;
  }
}