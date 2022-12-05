import 'package:flutter/material.dart';

class CustomSlider extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    final paint = Paint()
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    paint.shader = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.purple,
        Colors.red,
      ],
    ).createShader(rect);
    final path = Path(); //
    path.moveTo(20, size.height - 20); //1
    path.arcToPoint(Offset(size.width - 20, 20),
        radius: Radius.circular(size.width - 40));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
