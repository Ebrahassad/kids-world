import 'dart:math';
import 'package:flutter/material.dart';


class StarParticles {


  static void draw(

    Canvas canvas,
    double cx,
    double cy,
    double size,
    double animation,

  ) {



    final List<Color> colors = [

      Colors.white,
      Colors.yellow,
      Colors.orange,
      Colors.amber,

    ];



    final particles = [


      Offset(
        cx - size * .65,
        cy - size * .40,
      ),


      Offset(
        cx + size * .65,
        cy - size * .30,
      ),


      Offset(
        cx + size * .55,
        cy + size * .55,
      ),


      Offset(
        cx - size * .55,
        cy + size * .50,
      ),


      Offset(
        cx,
        cy - size * .75,
      ),


    ];




    for (int i = 0; i < particles.length; i++) {


      final double pulse =

          0.5 +
          ((sin(animation * pi * 2 + i) + 1) / 2);



      final Paint paint = Paint()

        ..color = colors[i % colors.length]

        ..style = PaintingStyle.fill;



      final double radius =

          size * .035 * pulse;



      canvas.save();



      canvas.translate(

        particles[i].dx,

        particles[i].dy,

      );



      canvas.rotate(

        animation * pi * 2 + i,

      );



      // شكل نجمة صغيرة

      final Path star = Path();


      for (int j = 0; j < 10; j++) {


        final double r =

            j.isEven

                ? radius

                : radius * .45;



        final double angle =

            -pi / 2 + j * pi / 5;



        final double x =

            cos(angle) * r;



        final double y =

            sin(angle) * r;



        if (j == 0) {

          star.moveTo(x, y);

        } else {

          star.lineTo(x, y);

        }

      }



      star.close();



      canvas.drawPath(

        star,

        paint,

      );



      canvas.restore();


    }

  }

}