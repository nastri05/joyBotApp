import 'package:flutter/material.dart';

class PathPaintTien extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(6, 44); //1
    path.lineTo(44, 47); //2
    path.lineTo(35, 33); //3
    path.lineTo(68, 54); //4
    path.lineTo(35, 75); //5
    path.lineTo(44, 61); //6
    path.lineTo(6, 67); //7
    path.lineTo(16, 54); //8
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
