import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:untitled1/native_screen/rectan_face.dart';

import 'coordinates_translator.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.faces, this.absoluteImageSize, this.rotation);

  final Rectan_face faces;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.red;

    canvas.drawRect(
      Rect.fromLTRB(
        faces.left > 210
            ? translateX(
                faces.left + faces.left, rotation, size, absoluteImageSize)
            : faces.left > 130
                ? translateX(faces.left + faces.left * 0.8, rotation, size,
                    absoluteImageSize)
                : translateX(
                    faces.left + 60, rotation, size, absoluteImageSize),
        translateY(faces.top + 10, rotation, size, absoluteImageSize),
        faces.left > 210
            ? translateX(faces.right + 240, rotation, size, absoluteImageSize)
            : faces.left > 110
                ? translateX(
                    faces.right + 200, rotation, size, absoluteImageSize)
                : translateX(
                    faces.right + 160, rotation, size, absoluteImageSize),
        translateY(faces.bot + 50, rotation, size, absoluteImageSize),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}
