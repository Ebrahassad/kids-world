import 'dart:math';
import 'package:flutter/material.dart';

class StarMouth {
  static void draw({
    required Canvas canvas,
    required double cx,
    required double cy,
    required double size,
    required bool talking,
    required bool happy,
  }) {
    final Paint smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = size * 0.025
      ..strokeCap = StrokeCap.round;

    // =========================
    // وجه سعيد جداً
    // =========================
    if (happy) {
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(
            cx,
            cy + size * .11,
          ),
          width: size * .45,
          height: size * .30,
        ),
        0,
        pi,
        false,
        smilePaint,
      );

      final Paint blush = Paint()
        ..color = Colors.pink.withValues(alpha: 0.45);

      canvas.drawCircle(
        Offset(
          cx - size * .28,
          cy + size * .12,
        ),
        size * .04,
        blush,
      );

      canvas.drawCircle(
        Offset(
          cx + size * .28,
          cy + size * .12,
        ),
        size * .04,
        blush,
      );

      return;
    }

    // =========================
    // أثناء الكلام
    // =========================
    if (talking) {
      // الفم
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(
            cx,
            cy + size * .15,
          ),
          width: size * .24,
          height: size * .19,
        ),
        Paint()
          ..color = Colors.red.shade900,
      );

      // الأسنان
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(
              cx,
              cy + size * .115,
            ),
            width: size * .16,
            height: size * .05,
          ),
          Radius.circular(size * .02),
        ),
        Paint()..color = Colors.white,
      );

      // اللسان
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(
            cx,
            cy + size * .19,
          ),
          width: size * .11,
          height: size * .05,
        ),
        Paint()
          ..color = Colors.pinkAccent,
      );

      // خدود
      final Paint blush = Paint()
        ..color = Colors.pink.withValues(alpha: 0.35);

      canvas.drawCircle(
        Offset(
          cx - size * .27,
          cy + size * .10,
        ),
        size * .03,
        blush,
      );

      canvas.drawCircle(
        Offset(
          cx + size * .27,
          cy + size * .10,
        ),
        size * .03,
        blush,
      );
    } else {
      // =========================
      // ابتسامة عادية
      // =========================
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(
            cx,
            cy + size * .10,
          ),
          width: size * .38,
          height: size * .28,
        ),
        0,
        pi,
        false,
        smilePaint,
      );

      final Paint blush = Paint()
        ..color = Colors.pink.withValues(alpha: 0.35);

      canvas.drawCircle(
        Offset(
          cx - size * .27,
          cy + size * .12,
        ),
        size * .035,
        blush,
      );

      canvas.drawCircle(
        Offset(
          cx + size * .27,
          cy + size * .12,
        ),
        size * .035,
        blush,
      );
    }
  }
}