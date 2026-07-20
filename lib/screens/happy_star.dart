import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';


class HappyStar extends StatefulWidget {

  final double size;

  const HappyStar({
    super.key,
    this.size = 90,
  });


  @override
  State<HappyStar> createState() =>
      _HappyStarState();

}



class _HappyStarState extends State<HappyStar> {


  bool blink = false;


  @override
  void initState() {

    super.initState();

    startBlink();

  }



  void startBlink() {

    Timer.periodic(
      const Duration(seconds: 3),

      (timer) {

        if (mounted) {

          setState(() {

            blink = true;

          });


          Future.delayed(
            const Duration(milliseconds: 180),

            () {

              if (mounted) {

                setState(() {

                  blink = false;

                });

              }

            },

          );

        }

      },

    );

  }



  @override
  Widget build(BuildContext context) {

    return CustomPaint(

      size: Size(
        widget.size,
        widget.size,
      ),

      painter: StarPainter(
        blink: blink,
      ),

    );

  }

}





class StarPainter extends CustomPainter {


  final bool blink;


  StarPainter({
    required this.blink,
  });



  @override
  void paint(
      Canvas canvas,
      Size size) {


    final Paint paint = Paint()

      ..shader =
          const LinearGradient(

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


    final double cx =
        size.width / 2;


    final double cy =
        size.height / 2;


    final double outer =
        size.width / 2;


    final double inner =
        outer * 0.45;



    for (int i = 0; i < 10; i++) {

      final double r =
          i.isEven ? outer : inner;


      final double angle =
          -pi / 2 +
          i * pi / 5;


      final double x =
          cx + r * cos(angle);


      final double y =
          cy + r * sin(angle);



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



    final Paint eyePaint =
        Paint()
          ..color = Colors.black;



    if (blink) {


      canvas.drawLine(

        Offset(
          cx - size.width * .22,
          cy - size.height * .05,
        ),

        Offset(
          cx - size.width * .08,
          cy - size.height * .05,
        ),

        eyePaint
          ..strokeWidth = 3,

      );


      canvas.drawLine(

        Offset(
          cx + size.width * .08,
          cy - size.height * .05,
        ),

        Offset(
          cx + size.width * .22,
          cy - size.height * .05,
        ),

        eyePaint
          ..strokeWidth = 3,

      );


    } else {


      canvas.drawCircle(

        Offset(
          cx - size.width * .15,
          cy - size.height * .05,
        ),

        size.width * .04,

        eyePaint,

      );


      canvas.drawCircle(

        Offset(
          cx + size.width * .15,
          cy - size.height * .05,
        ),

        size.width * .04,

        eyePaint,

      );

    }




    // الابتسامة

    final smilePaint =
        Paint()

          ..color = Colors.black

          ..style =
              PaintingStyle.stroke

          ..strokeWidth = 3;



    canvas.drawArc(

      Rect.fromCenter(

        center:
            Offset(
              cx,
              cy + size.height * .12,
            ),

        width:
            size.width * .35,

        height:
            size.height * .25,

      ),

      0,

      pi,

      false,

      smilePaint,

    );

  }



  @override
  bool shouldRepaint(
      covariant StarPainter oldDelegate) {

    return oldDelegate.blink != blink;

  }

}