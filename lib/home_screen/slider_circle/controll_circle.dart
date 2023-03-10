import 'package:flutter/material.dart';
import 'package:untitled1/home_screen/slider_circle/cirle.dart';

class ControllCircle extends StatelessWidget {
  const ControllCircle(
      {Key? key,
      required this.top,
      required this.lefl,
      required this.onUpdate,
      required this.onEnd})
      : super(key: key);

  final double top;
  final double lefl;
  final Function(DragUpdateDetails details) onUpdate;
  final Function(DragEndDetails details) onEnd;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: lefl,
      child: GestureDetector(
        onPanUpdate: onUpdate,
        child: Center(child: Cirle()),
        onPanEnd: onEnd,
      ),
    );
  }
}
