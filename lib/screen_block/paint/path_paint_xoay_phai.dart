import 'package:flutter/material.dart';

class PathPaintXoayPhai extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    final path = Path(); //
    path.moveTo(10, 64); //1
    path.arcToPoint(Offset(61, 63), radius: Radius.circular(15));
    canvas.drawPath(path, paint);
    final paint1 = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    final path1 = Path();
    path1.moveTo(67, 50); //1
    path1.lineTo(63, 64); //2
    path1.lineTo(48, 61); //3
    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
