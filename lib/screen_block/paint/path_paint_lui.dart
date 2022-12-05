import 'package:flutter/material.dart';

class PathPaintLui extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    final path = Path(); //41
    path.moveTo(68, 44); //1
    path.lineTo(30, 47); //2
    path.lineTo(39, 33); //3
    path.lineTo(6, 54); //4
    path.lineTo(39, 75); //5
    path.lineTo(30, 61); //6
    path.lineTo(68, 67); //7
    path.lineTo(58, 54); //8
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
