import 'package:flutter/material.dart';


class HappyStar extends StatelessWidget {

  final double size;


  const HappyStar({
    super.key,
    this.size = 90,
  });



  @override
  Widget build(BuildContext context) {

    return CustomPaint(

      size: Size(size, size),

      painter: StarPainter(),

    );

  }

}



class StarPainter extends CustomPainter {


  @override
  void paint(Canvas canvas, Size size) {


    final Paint paint = Paint()
      ..shader = const LinearGradient(

        colors: [

          Color(0xfffff176),

          Color(0xffff9800),

        ],

      ).createShader(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );



    final Path path = Path();


    final double centerX =
        size.width / 2;

    final double centerY =
        size.height / 2;


    final double outer =
        size.width / 2;


    final double inner =
        outer * 0.45;



    for (int i = 0; i < 10; i++) {


      final double radius =
          i.isEven ? outer : inner;


      final double angle =
          -3.14159 / 2 +
          i * 3.14159 / 5;



      final double x =
          centerX +
          radius *
              cos(angle);


      final double y =
          centerY +
          radius *
              sin(angle);



      if (i == 0) {

        path.moveTo(x, y);

      } else {

        path.lineTo(x, y);

      }


    }


    path.close();


    canvas.drawPath(
      path,
      paint,
    );



    // العين اليمنى

    final eyePaint = Paint()
      ..color = Colors.black;



    canvas.drawCircle(

      Offset(
        centerX - size * 0.15,
        centerY - size * 0.05,
      ),

      size * 0.04,

      eyePaint,

    );



    // العين اليسرى

    canvas.drawCircle(

      Offset(
        centerX + size * 0.15,
        centerY - size * 0.05,
      ),

      size * 0.04,

      eyePaint,

    );



    // الابتسامة

    final smilePaint = Paint()

      ..color = Colors.black

      ..style = PaintingStyle.stroke

      ..strokeWidth = 3;



    canvas.drawArc(

      Rect.fromCenter(

        center:
            Offset(
              centerX,
              centerY + size * 0.12,
            ),

        width:
            size * 0.35,

        height:
            size * 0.25,

      ),

      0,

      3.14,

      false,

      smilePaint,

    );


  }



  @override
  bool shouldRepaint(
      CustomPainter oldDelegate) {

    return false;

  }

}