import 'package:flutter/material.dart';

class StarEffects {
  static void drawGlow({
    required Canvas canvas,
    required double cx,
    required double cy,
    required double radius,
  }) {
    final Paint glowPaint = Paint()
      ..color = Colors.amber.withOpacity(0.25)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        25,
      );

    canvas.drawCircle(
      Offset(cx, cy),
      radius,
      glowPaint,
    );
  }
}