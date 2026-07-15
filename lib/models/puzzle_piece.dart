class PuzzlePiece {
  final int id;
  final String imagePath;
  final bool isCorrect;

  const PuzzlePiece({
    required this.id,
    required this.imagePath,
    this.isCorrect = false,
  });

  PuzzlePiece copyWith({
    int? id,
    String? imagePath,
    bool? isCorrect,
  }) {
    return PuzzlePiece(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}