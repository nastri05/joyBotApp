import 'package:flutter/material.dart';

class PathPaintXoayTrai extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    final path = Path();
    path.moveTo(16, 63); //10//59
    path.arcToPoint(Offset(67, 64), radius: Radius.circular(15));
    canvas.drawPath(path, paint);
    final paint1 = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    final path1 = Path();
    path1.moveTo(8, 50);
    path1.lineTo(15, 64); //2
    path1.lineTo(30, 59); //3
    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
