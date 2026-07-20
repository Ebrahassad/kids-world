import 'package:flutter/material.dart';

class StarFace {

  static void drawEyes({
    required Canvas canvas,
    required double cx,
    required double cy,
    required double size,
    required bool blink,
    required bool happy,
  }) {

    final eyePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;


    // ⭐ وجه سعيد عند الفوز
    if (happy) {

      eyePaint.style = PaintingStyle.stroke;


      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(
            cx - size * .15,
            cy - size * .05,
          ),
          width: size * .16,
          height: size * .10,
        ),
        0,
        3.14,
        false,
        eyePaint,
      );


      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(
            cx + size * .15,
            cy - size * .05,
          ),
          width: size * .16,
          height: size * .10,
        ),
        0,
        3.14,
        false,
        eyePaint,
      );


      return;
    }



    // 👀 رمش
    if (blink) {

      eyePaint.style = PaintingStyle.stroke;


      canvas.drawLine(
        Offset(
          cx - size * .22,
          cy - size * .05,
        ),
        Offset(
          cx - size * .08,
          cy - size * .05,
        ),
        eyePaint,
      );


      canvas.drawLine(
        Offset(
          cx + size * .08,
          cy - size * .05,
        ),
        Offset(
          cx + size * .22,
          cy - size * .05,
        ),
        eyePaint,
      );


    } else {


      // 🙂 عيون عادية
      eyePaint.style = PaintingStyle.fill;


      canvas.drawCircle(
        Offset(
          cx - size * .15,
          cy - size * .05,
        ),
        size * .04,
        eyePaint,
      );


      canvas.drawCircle(
        Offset(
          cx + size * .15,
          cy - size * .05,
        ),
        size * .04,
        eyePaint,
      );



      // لمعة العين
      final Paint shine = Paint()
        ..color = Colors.white;


      canvas.drawCircle(
        Offset(
          cx - size * .135,
          cy - size * .065,
        ),
        size * .012,
        shine,
      );


      canvas.drawCircle(
        Offset(
          cx + size * .165,
          cy - size * .065,
        ),
        size * .012,
        shine,
      );

    }

  }
}