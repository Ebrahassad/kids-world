import 'package:flutter/material.dart';

class StarArmsLegs {


  static void draw(

    Canvas canvas,
    double cx,
    double cy,
    double size,
    double animation,

  ) {



    final Paint armPaint = Paint()

      ..color = Colors.orange.shade800

      ..strokeWidth = size * 0.035

      ..strokeCap = StrokeCap.round;



    final double wave =
        animation * size * 0.12;



    // اليد اليسرى مرفوعة
    canvas.drawLine(

      Offset(

        cx - size * .38,

        cy,

      ),

      Offset(

        cx - size * .65,

        cy - size * .15 - wave,

      ),

      armPaint,

    );




    // اليد اليمنى مرفوعة
    canvas.drawLine(

      Offset(

        cx + size * .38,

        cy,

      ),

      Offset(

        cx + size * .65,

        cy - size * .15 + wave,

      ),

      armPaint,

    );




    // الأرجل مع حركة القفز

    final double jump =
        animation * size * .06;



    canvas.drawLine(

      Offset(

        cx - size * .15,

        cy + size * .35,

      ),

      Offset(

        cx - size * .28,

        cy + size * .65 - jump,

      ),

      armPaint,

    );



    canvas.drawLine(

      Offset(

        cx + size * .15,

        cy + size * .35,

      ),

      Offset(

        cx + size * .28,

        cy + size * .65 + jump,

      ),

      armPaint,

    );





    // اليدين والرجلين

    final Paint circlePaint = Paint()

      ..color = Colors.orange.shade800;



    final points = [


      Offset(

        cx - size * .65,

        cy - size * .15 - wave,

      ),


      Offset(

        cx + size * .65,

        cy - size * .15 + wave,

      ),


      Offset(

        cx - size * .28,

        cy + size * .65 - jump,

      ),


      Offset(

        cx + size * .28,

        cy + size * .65 + jump,

      ),

    ];




    for (final point in points) {


      canvas.drawCircle(

        point,

        size * .05,

        circlePaint,

      );


    }




    // خطوط صغيرة كأنها أصابع

    final Paint fingerPaint = Paint()

      ..color = Colors.orange.shade900

      ..strokeWidth = size * .015;



    canvas.drawLine(

      points[0],

      points[0] + Offset(-size*.05, -size*.03),

      fingerPaint,

    );


    canvas.drawLine(

      points[1],

      points[1] + Offset(size*.05, -size*.03),

      fingerPaint,

    );


  }

}