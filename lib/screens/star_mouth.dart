import 'dart:math';
import 'package:flutter/material.dart';


class StarMouth {
  static void draw({
    required Canvas canvas,
    required double cx,
    required double cy,
    required double size,
    required bool talking,
  }) {
    final Paint smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    if (talking) {
      // الفم
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(
            cx,
            cy + size * .15,
          ),
          width: size * .20,
          height: size * .14,
        ),
        Paint()..color = Colors.red.shade900,
      );

      // اللسان
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(
            cx,
            cy + size * .18,
          ),
          width: size * .11,
          height: size * .05,
        ),
        Paint()..color = Colors.pinkAccent,
      );
    } else {
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(
            cx,
            cy + size * .12,
          ),
          width: size * .35,
          height: size * .25,
        ),
        0,
        pi,
        false,
        smilePaint,
      );
    }
  }
}