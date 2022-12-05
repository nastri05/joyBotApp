import 'package:flutter/material.dart';

class CustomCirle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.blue.shade900
      ..style = PaintingStyle.fill;

    final path = Path(); //

    canvas.drawCircle(center, size.height / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
