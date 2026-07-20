import 'dart:math';
import 'package:flutter/material.dart';

class StarPainter extends CustomPainter {
  final bool blink;
  final bool talking;

  StarPainter({
    required this.blink,
    required this.talking,
  });

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

    final double cx = size.width / 2;
    final double cy = size.height / 2;

    final double outer = size.width / 2;
    final double inner = outer * 0.45;

    for (int i = 0; i < 10; i++) {
      final double radius =
          i.isEven ? outer : inner;

      final double angle =
          -pi / 2 + i * pi / 5;

      final double x =
          cx + radius * cos(angle);

      final double y =
          cy + radius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();

    // جسم النجمة
    canvas.drawPath(path, paint);

    final Paint eyePaint = Paint()
      ..color = Colors.black;

    // العيون
    if (blink) {
      eyePaint.strokeWidth = 3;

      canvas.drawLine(
        Offset(
          cx - size.width * .22,
          cy - size.height * .05,
        ),
        Offset(
          cx - size.width * .08,
          cy - size.height * .05,
        ),
        eyePaint,
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
        eyePaint,
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

    final Paint smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    if (talking) {
      // الفم
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(
            cx,
            cy + size.height * .15,
          ),
          width: size.width * .20,
          height: size.height * .14,
        ),
        Paint()..color = Colors.red.shade900,
      );

      // اللسان
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(
            cx,
            cy + size.height * .18,
          ),
          width: size.width * .11,
          height: size.height * .05,
        ),
        Paint()..color = Colors.pinkAccent,
      );
    } else {
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(
            cx,
            cy + size.height * .12,
          ),
          width: size.width * .35,
          height: size.height * .25,
        ),
        0,
        pi,
        false,
        smilePaint,
      );
    }
  }

  @override
  bool shouldRepaint(
      covariant StarPainter oldDelegate) {
    return oldDelegate.blink != blink ||
        oldDelegate.talking != talking;
  }
}