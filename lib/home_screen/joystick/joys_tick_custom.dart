import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class JoysTickCustom extends StatelessWidget {
  JoysTickCustom({
    Key? key,
    required this.listener,
    required this.onStickDragEnd,
  }) : super(key: key);
  final Function(StickDragDetails details) listener;
  final Function() onStickDragEnd;
  @override
  Widget build(BuildContext context) {
    return Joystick(
      listener: listener,
      mode: JoystickMode.all,
      onStickDragEnd: onStickDragEnd,
    );
  }
}
