import 'package:flutter/material.dart';

class ZoomPainter extends CustomPainter {
  ZoomPainter({
    required this.color,
    required this.zoomSize,
  });

  Color color;
  double zoomSize;

  @override
  void paint(Canvas canvas, Size size) {
    double radius = zoomSize / 2;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect outerCircleRect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius);

    Path transparentHole = Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      Path()
        ..addOval(outerCircleRect)
        ..close(),
    );

    canvas.drawPath(transparentHole, Paint()..color = color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
