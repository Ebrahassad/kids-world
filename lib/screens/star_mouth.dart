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

      ..strokeWidth = size * 0.025

      ..strokeCap = StrokeCap.round;



    if (talking) {



      // الفم المفتوح
      canvas.drawOval(

        Rect.fromCenter(

          center: Offset(

            cx,

            cy + size * .15,

          ),

          width: size * .24,

          height: size * .18,

        ),

        Paint()

          ..color = Colors.red.shade900,

      );




      // الأسنان
      canvas.drawArc(

        Rect.fromCenter(

          center: Offset(

            cx,

            cy + size * .12,

          ),

          width: size * .18,

          height: size * .08,

        ),

        pi,

        pi,

        false,

        Paint()

          ..color = Colors.white

          ..style = PaintingStyle.fill,

      );




      // اللسان

      canvas.drawOval(

        Rect.fromCenter(

          center: Offset(

            cx,

            cy + size * .20,

          ),

          width: size * .12,

          height: size * .05,

        ),

        Paint()

          ..color = Colors.pinkAccent,

      );



    } else {



      // ابتسامة كبيرة

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



      // خدود صغيرة

      final Paint cheekPaint = Paint()

        ..color = Colors.pink.withOpacity(0.5);



      canvas.drawCircle(

        Offset(

          cx - size * .27,

          cy + size * .12,

        ),

        size * .035,

        cheekPaint,

      );


      canvas.drawCircle(

        Offset(

          cx + size * .27,

          cy + size * .12,

        ),

        size * .035,

        cheekPaint,

      );



    }

  }


}