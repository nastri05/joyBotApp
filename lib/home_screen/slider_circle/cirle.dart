import 'package:flutter/material.dart';
import 'package:untitled1/home_screen/slider_circle/custom_cirle.dart';

class Cirle extends StatelessWidget {
  const Cirle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      child: CustomPaint(
        painter: CustomCirle(),
      ),
    );
  }
}
