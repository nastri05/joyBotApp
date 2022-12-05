import 'package:flutter/material.dart';

class BoxControllcmd {
  BoxControllcmd({required this.mode});
  final String mode;
  String cmd_speed = '0';
  String cmd_delay = '0';
  String cmd_Angle = '0';
  Size getSize() {
    return Size(120, 80);
  }

  set setCmdSpeed(String cmd_speed) {
    this.cmd_speed = cmd_speed;
  }

  set setCmdAngle(String cmd_Angle) {
    this.cmd_Angle = cmd_Angle;
  }

  set setCmdDelay(String cmd_Delay) {
    this.cmd_delay = cmd_Delay;
  }

  String get getCmd_T {
    String cmd = 's' + cmd_speed + 'd' + cmd_delay;
    return cmd;
  }

  String get getCmd_S {
    String cmd = cmd_Angle;
    return cmd;
  }
}
