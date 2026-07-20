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
        cy - size * 0.12,
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
        cy - size * 0.12,
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
        cy + size * 0.65,
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
        cy + size * 0.65,
      ),
      paint,
    );


    // دوائر صغيرة للأيدي والأرجل
    final Paint circlePaint = Paint()
      ..color = Colors.orange.shade700;


    canvas.drawCircle(
      Offset(
        cx - size * 0.65,
        cy - size * 0.12,
      ),
      size * 0.05,
      circlePaint,
    );


    canvas.drawCircle(
      Offset(
        cx + size * 0.65,
        cy - size * 0.12,
      ),
      size * 0.05,
      circlePaint,
    );


    canvas.drawCircle(
      Offset(
        cx - size * 0.25,
        cy + size * 0.65,
      ),
      size * 0.05,
      circlePaint,
    );


    canvas.drawCircle(
      Offset(
        cx + size * 0.25,
        cy + size * 0.65,
      ),
      size * 0.05,
      circlePaint,
    );

  }
}