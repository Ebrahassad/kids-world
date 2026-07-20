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

  StarPainter({
  required this.blink,
  required this.talking,
  required this.glowScale,
  required this.shineValue,
required this.particleValue,
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

    // الهالة الذهبية
StarEffects.drawGlow(
  canvas: canvas,
  cx: cx,
  cy: cy,
  radius: size.width * 0.55 * glowScale,
);

// جسم النجمة
canvas.drawPath(
  path,
  paint,
);

StarArmsLegs.draw(
  canvas,
  cx,
  cy,
  size.width,
  talking ? 0.2 : 0,
);

StarShine.draw(
  canvas,
  cx,
  cy,
  size.width,
  shineValue,
);

StarParticles.draw(
  canvas,
  cx,
  cy,
  size.width,
  particleValue,
);

StarFace.drawEyes(
  canvas: canvas,
  cx: cx,
  cy: cy,
  size: size.width,
  blink: blink,
);

StarMouth.draw(
  canvas: canvas,
  cx: cx,
  cy: cy,
  size: size.width,
  talking: talking,
);

}

  @override
bool shouldRepaint(
    covariant StarPainter oldDelegate) {
  return oldDelegate.blink != blink ||
    oldDelegate.talking != talking ||
    oldDelegate.glowScale != glowScale ||
    oldDelegate.shineValue != shineValue ||
    oldDelegate.particleValue != particleValue;
}
}