import 'dart:math';
import 'package:flutter/material.dart';

import 'star_face.dart';
import 'star_mouth.dart';
import 'star_effects.dart';
import 'star_shine.dart';
import 'star_particles.dart';
import 'star_arms_legs.dart';



class StarPainter extends CustomPainter {


  final bool blink;
  final bool talking;
  final double glowScale;
  final double shineValue;
  final double particleValue;
  final double armAnimation;
  final bool happy;



  StarPainter({

    required this.blink,
    required this.talking,
    required this.glowScale,
    required this.shineValue,
    required this.particleValue,
    required this.armAnimation,
    required this.happy,

  });



  @override
  void paint(Canvas canvas, Size size) {


    final double cx = size.width / 2;
    final double cy = size.height / 2;

// ظل أسفل النجمة
canvas.drawOval(
  Rect.fromCenter(
    center: Offset(
      cx,
      cy + size.width * 0.60,
    ),
    width: size.width * 0.55,
    height: size.width * 0.12,
  ),
  Paint()
    ..color = Colors.black.withValues(alpha: 0.15),
);

    // لون النجمة
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



    // رسم شكل النجمة
    final Path path = Path();


    final double outer = size.width / 2;
    final double inner = outer * 0.45;



    for(int i = 0; i < 10; i++) {


      final double radius =
          i.isEven ? outer : inner;


      final double angle =
          -pi / 2 + i * pi / 5;



      final double x =
          cx + radius * cos(angle);


      final double y =
          cy + radius * sin(angle);



      if(i == 0){

        path.moveTo(x,y);

      } else {

        path.lineTo(x,y);

      }


    }


    path.close();



    // الهالة
    StarEffects.drawGlow(

      canvas: canvas,

      cx: cx,

      cy: cy,

      radius:
          size.width * 0.55 * glowScale,

    );



    // جسم النجمة
    canvas.drawPath(
      path,
      paint,
    );



    // اليدين والأرجل
    StarArmsLegs.draw(

      canvas,

      cx,

      cy,

      size.width,

      armAnimation,

    );



    // اللمعة
    StarShine.draw(

      canvas,

      cx,

      cy,

      size.width,

      shineValue,

    );



    // النجوم الصغيرة حولها
    StarParticles.draw(

      canvas,

      cx,

      cy,

      size.width,

      particleValue,

    );



    // العيون
    StarFace.drawEyes(

      canvas: canvas,

      cx: cx,

      cy: cy,

      size: size.width,

      blink: blink,

      happy: happy,

    );



    // الفم
    StarMouth.draw(

      canvas: canvas,

      cx: cx,

      cy: cy,

      size: size.width,

      talking: talking,

      happy: happy,

    );


  }



  @override
  bool shouldRepaint(
      covariant StarPainter oldDelegate) {


    return

      oldDelegate.blink != blink ||

      oldDelegate.talking != talking ||

      oldDelegate.glowScale != glowScale ||

      oldDelegate.shineValue != shineValue ||

      oldDelegate.particleValue != particleValue ||

      oldDelegate.armAnimation != armAnimation ||

      oldDelegate.happy != happy;


  }


}