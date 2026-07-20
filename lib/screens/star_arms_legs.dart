import 'package:flutter/material.dart';

class StarArmsLegs {

  static void draw(
    Canvas canvas,
    double cx,
    double cy,
    double size,
    double animation,
  ) {

    final Paint paint = Paint()
      ..color = Colors.orange.shade700
      ..strokeWidth = size * 0.035
      ..strokeCap = StrokeCap.round;


    // اليد اليسرى
    canvas.drawLine(
      Offset(
        cx - size * 0.38,
        cy,
      ),
      Offset(
        cx - size * 0.65,
        cy - size * 0.12 +
            animation * size * 0.08,
      ),
      paint,
    );


    // اليد اليمنى
    canvas.drawLine(
      Offset(
        cx + size * 0.38,
        cy,
      ),
      Offset(
        cx + size * 0.65,
        cy - size * 0.12 -
            animation * size * 0.08,
      ),
      paint,
    );


    // الرجل اليسرى
    canvas.drawLine(
      Offset(
        cx - size * 0.15,
        cy + size * 0.35,
      ),
      Offset(
        cx - size * 0.25,
        cy + size * 0.65 +
            animation * size * 0.05,
      ),
      paint,
    );


    // الرجل اليمنى
    canvas.drawLine(
      Offset(
        cx + size * 0.15,
        cy + size * 0.35,
      ),
      Offset(
        cx + size * 0.25,
        cy + size * 0.65 -
            animation * size * 0.05,
      ),
      paint,
    );


    // دوائر اليدين والأرجل
    final Paint circlePaint = Paint()
      ..color = Colors.orange.shade700;


    // اليد اليسرى
    canvas.drawCircle(
      Offset(
        cx - size * 0.65,
        cy - size * 0.12 +
            animation * size * 0.08,
      ),
      size * 0.05,
      circlePaint,
    );


    // اليد اليمنى
    canvas.drawCircle(
      Offset(
        cx + size * 0.65,
        cy - size * 0.12 -
            animation * size * 0.08,
      ),
      size * 0.05,
      circlePaint,
    );


    // الرجل اليسرى
    canvas.drawCircle(
      Offset(
        cx - size * 0.25,
        cy + size * 0.65 +
            animation * size * 0.05,
      ),
      size * 0.05,
      circlePaint,
    );


    // الرجل اليمنى
    canvas.drawCircle(
      Offset(
        cx + size * 0.25,
        cy + size * 0.65 -
            animation * size * 0.05,
      ),
      size * 0.05,
      circlePaint,
    );

  }
}