import 'package:flutter/material.dart';
import 'package:p88_admin/app/util/color_item.dart';

class CustomGrid extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()..color = ColorItem.secondary;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    double spacing = 50.0;

    for (double i = 0; i <= size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    for (double i = 0; i <= size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}