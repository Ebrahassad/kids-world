import 'dart:math';
import 'package:flutter/material.dart';

class StarParticles {

  static void draw(
    Canvas canvas,
    double cx,
    double cy,
    double size,
    double animation,
  ) {

    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final random = [
      Offset(
        cx - size * .55,
        cy - size * .35,
      ),
      Offset(
        cx + size * .55,
        cy - size * .20,
      ),
      Offset(
        cx + size * .40,
        cy + size * .45,
      ),
      Offset(
        cx - size * .45,
        cy + size * .40,
      ),
    ];

    for (int i = 0; i < random.length; i++) {

      final double scale =
          0.5 + ((sin(animation + i) + 1) / 2);

      canvas.drawCircle(
        random[i],
        size * .04 * scale,
        paint,
      );
    }
  }
}