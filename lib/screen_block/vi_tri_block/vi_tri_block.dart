import 'package:flutter/material.dart';
import 'package:untitled1/screen_block/block/types_block.dart';

class VitriBlock {
  VitriBlock(
      {required this.top,
      required this.left,
      required this.border,
      required this.mode}) {
    if (mode == 'Tiến' ||
        mode == 'Lùi' ||
        mode == 'Xoay Phải' ||
        mode == 'Xoay Trái' ||
        mode == 'Servo 1' ||
        mode == 'Servo 2' ||
        mode == 'Servo 3') {
      ModeBlock = BoxControllcmd(mode: mode);
      size_Box = ModeBlock!.getSize();
    } else {
      size_Box = Size(80, 80);
    }
  }
  BoxControllcmd? ModeBlock;
  late Size size_Box;
  TextEditingController myController_speed = TextEditingController();
  TextEditingController myController_delay = TextEditingController();
  TextEditingController myController_angle = TextEditingController();
  double top;
  double left;
  bool border;
  late String mode;
  void set GetTop(double top1) {
    top = top1;
  }

  void set GetBorder(bool border1) {
    border = border1;
  }

  void set GetLeft(double left1) {
    left = left1;
  }
}
