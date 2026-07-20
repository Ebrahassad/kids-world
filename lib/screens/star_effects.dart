import 'dart:math';
import 'package:flutter/material.dart';


class StarEffects {


  static void drawGlow({

    required Canvas canvas,
    required double cx,
    required double cy,
    required double radius,

    double animation = 0,

  }) {



    final double pulse =
        1 + (sin(animation * pi * 2) * 0.08);



    final Paint glowPaint = Paint()

      ..shader = RadialGradient(

        colors: [

          Colors.amber.withValues(
            alpha: 0.45,
          ),

          Colors.orange.withValues(
            alpha: 0.25,
          ),

          Colors.transparent,

        ],

      ).createShader(

        Rect.fromCircle(

          center: Offset(cx, cy),

          radius: radius * pulse,

        ),

      )

      ..maskFilter = const MaskFilter.blur(

        BlurStyle.normal,

        25,

      );



    canvas.drawCircle(

      Offset(cx, cy),

      radius * pulse,

      glowPaint,

    );





    // نقاط لمعان صغيرة حول النجمة

    final Paint shinePaint = Paint()

      ..color = Colors.white.withValues(
        alpha: 0.8,
      );



    final List<Offset> stars = [


      Offset(
        cx - radius * .8,
        cy - radius * .4,
      ),


      Offset(
        cx + radius * .75,
        cy - radius * .3,
      ),


      Offset(
        cx + radius * .6,
        cy + radius * .6,
      ),


    ];



    for (final point in stars) {


      canvas.drawCircle(

        point,

        radius * .04,

        shinePaint,

      );


    }


  }


}