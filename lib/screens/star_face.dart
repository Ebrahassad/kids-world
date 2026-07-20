import 'package:flutter/material.dart';


class StarFace {


  static void drawEyes({

    required Canvas canvas,
    required double cx,
    required double cy,
    required double size,
    required bool blink,

  }) {


    final Paint eyePaint = Paint()
      ..color = Colors.black;


    final Paint shinePaint = Paint()
      ..color = Colors.white;



    final Paint browPaint = Paint()
      ..color = Colors.brown.shade700
      ..strokeWidth = size * 0.025
      ..strokeCap = StrokeCap.round;



    // الحواجب
    canvas.drawLine(

      Offset(
        cx - size * .22,
        cy - size * .16,
      ),

      Offset(
        cx - size * .08,
        cy - size * .19,
      ),

      browPaint,

    );


    canvas.drawLine(

      Offset(
        cx + size * .08,
        cy - size * .19,
      ),

      Offset(
        cx + size * .22,
        cy - size * .16,
      ),

      browPaint,

    );




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


      // العين اليسرى
      canvas.drawCircle(

        Offset(
          cx - size * .15,
          cy - size * .05,
        ),

        size * .055,

        eyePaint,

      );


      // العين اليمنى
      canvas.drawCircle(

        Offset(
          cx + size * .15,
          cy - size * .05,
        ),

        size * .055,

        eyePaint,

      );



      // لمعة العين
      canvas.drawCircle(

        Offset(
          cx - size * .13,
          cy - size * .07,
        ),

        size * .018,

        shinePaint,

      );


      canvas.drawCircle(

        Offset(
          cx + size * .17,
          cy - size * .07,
        ),

        size * .018,

        shinePaint,

      );


    }


  }


}