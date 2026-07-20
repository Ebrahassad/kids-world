import 'package:flutter/material.dart';

class StarShine {

  static void draw(
    Canvas canvas,
    double cx,
    double cy,
    double size,
    double value,
  ) {

    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0),
          Colors.white.withOpacity(0.8),
          Colors.white.withOpacity(0),
        ],
      ).createShader(
        Rect.fromLTWH(
          cx - size,
          cy - size,
          size * 2,
          size * 2,
        ),
      );

    canvas.save();

    canvas.rotate(
      value,
      Offset(cx, cy),
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy),
        width: size * .25,
        height: size * 1.2,
      ),
      paint,
    );

    canvas.restore();
  }
}