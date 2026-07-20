import 'package:flutter/material.dart';


class StarFace {

  static void drawEyes({

    required Canvas canvas,
    required double cx,
    required double cy,
    required double size,
    required bool blink,

  }) {



    // الخدود
    final blushPaint = Paint()
      ..color = Colors.pinkAccent.withValues(alpha: 0.45);



    canvas.drawCircle(
      Offset(
        cx - size * .28,
        cy + size * .08,
      ),
      size * .07,
      blushPaint,
    );


    canvas.drawCircle(
      Offset(
        cx + size * .28,
        cy + size * .08,
      ),
      size * .07,
      blushPaint,
    );




    // الحواجب
    final eyebrowPaint = Paint()

      ..color = Colors.brown.shade700

      ..strokeWidth = size * .025

      ..strokeCap = StrokeCap.round;



    canvas.drawLine(

      Offset(
        cx - size * .22,
        cy - size * .18,
      ),

      Offset(
        cx - size * .08,
        cy - size * .20,
      ),

      eyebrowPaint,

    );



    canvas.drawLine(

      Offset(
        cx + size * .08,
        cy - size * .20,
      ),

      Offset(
        cx + size * .22,
        cy - size * .18,
      ),

      eyebrowPaint,

    );




    final eyePaint = Paint()
      ..color = Colors.black;



    if (blink) {


      eyePaint.strokeWidth = 3;



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



      canvas.drawCircle(

        Offset(
          cx - size * .15,
          cy - size * .05,
        ),

        size * .045,

        eyePaint,

      );



      canvas.drawCircle(

        Offset(
          cx + size * .15,
          cy - size * .05,
        ),

        size * .045,

        eyePaint,

      );


    }

  }

}