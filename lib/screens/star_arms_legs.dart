import 'dart:math';
import 'package:flutter/material.dart';

class StarArmsLegs {
  static void draw(
    Canvas canvas,
    double cx,
    double cy,
    double size,
    double animation,
  ) {
    final Paint limbPaint = Paint()
      ..color = Colors.orange.shade800
      ..strokeWidth = size * .035
      ..strokeCap = StrokeCap.round;

    final Paint handPaint = Paint()
      ..color = Colors.orange.shade700;

    final Paint fingerPaint = Paint()
      ..color = Colors.orange.shade900
      ..strokeWidth = size * .012
      ..strokeCap = StrokeCap.round;

    final double armWave = sin(animation * pi * 2) * size * .08;
    final double jump = sin(animation * pi * 2) * size * .05;

    // =====================
    // الذراع اليسرى
    // =====================

    final Offset leftShoulder = Offset(
      cx - size * .35,
      cy,
    );

    final Offset leftHand = Offset(
      cx - size * .63,
      cy - size * .15 - armWave,
    );

    canvas.drawLine(
      leftShoulder,
      leftHand,
      limbPaint,
    );

    // =====================
    // الذراع اليمنى
    // =====================

    final Offset rightShoulder = Offset(
      cx + size * .35,
      cy,
    );

    final Offset rightHand = Offset(
      cx + size * .63,
      cy - size * .15 + armWave,
    );

    canvas.drawLine(
      rightShoulder,
      rightHand,
      limbPaint,
    );

    // =====================
    // الرجل اليسرى
    // =====================

    final Offset leftHip = Offset(
      cx - size * .15,
      cy + size * .34,
    );

    final Offset leftFoot = Offset(
      cx - size * .28,
      cy + size * .64 - jump,
    );

    canvas.drawLine(
      leftHip,
      leftFoot,
      limbPaint,
    );

    // =====================
    // الرجل اليمنى
    // =====================

    final Offset rightHip = Offset(
      cx + size * .15,
      cy + size * .34,
    );

    final Offset rightFoot = Offset(
      cx + size * .28,
      cy + size * .64 + jump,
    );

    canvas.drawLine(
      rightHip,
      rightFoot,
      limbPaint,
    );

    // =====================
    // الكفين والقدمين
    // =====================

    for (final point in [
      leftHand,
      rightHand,
      leftFoot,
      rightFoot,
    ]) {
      canvas.drawCircle(
        point,
        size * .045,
        handPaint,
      );
    }

    // =====================
    // أصابع اليد اليسرى
    // =====================

    canvas.drawLine(
      leftHand,
      leftHand + Offset(-size * .05, -size * .02),
      fingerPaint,
    );

    canvas.drawLine(
      leftHand,
      leftHand + Offset(-size * .05, size * .01),
      fingerPaint,
    );

    // =====================
    // أصابع اليد اليمنى
    // =====================

    canvas.drawLine(
      rightHand,
      rightHand + Offset(size * .05, -size * .02),
      fingerPaint,
    );

    canvas.drawLine(
      rightHand,
      rightHand + Offset(size * .05, size * .01),
      fingerPaint,
    );
  }
}