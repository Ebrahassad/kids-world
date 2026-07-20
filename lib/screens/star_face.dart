import 'package:flutter/material.dart';

class StarFace {
  static void drawEyes({
    required Canvas canvas,
    required double cx,
    required double cy,
    required double size,
    required bool blink,
  }) {
    final eyePaint = Paint()..color = Colors.black;

    if (blink) {
      eyePaint.strokeWidth = 3;

      canvas.drawLine(
        Offset(cx - size * .22, cy - size * .05),
        Offset(cx - size * .08, cy - size * .05),
        eyePaint,
      );

      canvas.drawLine(
        Offset(cx + size * .08, cy - size * .05),
        Offset(cx + size * .22, cy - size * .05),
        eyePaint,
      );
    } else {
      canvas.drawCircle(
        Offset(cx - size * .15, cy - size * .05),
        size * .04,
        eyePaint,
      );

      canvas.drawCircle(
        Offset(cx + size * .15, cy - size * .05),
        size * .04,
        eyePaint,
      );
    }
  }
}