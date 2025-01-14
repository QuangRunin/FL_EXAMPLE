import 'dart:math';
import 'package:example/base/base_mixin.dart';
import 'package:example/data/model/spin/spin_data.dart';
import 'package:flutter/material.dart';

class SpinPainter extends CustomPainter with BaseMixin {
  SpinPainter({required this.data})
      : assert(data.isNotEmpty, 'Colors cannot be empty');
  final List<SpinData> data;

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width / 2, size.height / 2);
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double angle = 2 * pi / data.length;

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, 5);

    canvas.drawCircle(center, radius, shadowPaint);
    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    for (int i = 0; i < data.length; i++) {
      final double startAngle = i * angle;
      final Paint paint = Paint()
        ..style = PaintingStyle.fill
        ..isAntiAlias = true
        ..color = data[i].color!;

      final Paint borderPaint = Paint()
        ..style = PaintingStyle.stroke
        ..isAntiAlias = true
        ..color = Colors.white
        ..strokeWidth = 1.0;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - 5),
        startAngle,
        angle,
        true,
        paint,
      );

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - 5),
        startAngle,
        angle,
        true,
        borderPaint,
      );
      final String text = data[i].name!;
      final TextSpan span = TextSpan(
        text: text,
        style: textStyle.regular(size: 12, color: color.white),
      );
      textPainter.text = span;
      textPainter.layout();

      final double textAngle = startAngle + angle / 2;
      final double textRadius = radius - size.width / 4;

      final double x = center.dx + textRadius * cos(textAngle);
      final double y = center.dy + textRadius * sin(textAngle);

      final double rotationAngle = textAngle;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotationAngle);
      textPainter.paint(
          canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
