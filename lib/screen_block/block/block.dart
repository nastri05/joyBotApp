import 'package:flutter/material.dart';
import 'package:untitled1/screen_block/design_block/dkcd/dkdcxt_decoration.dart';
import 'package:untitled1/screen_block/design_block/dkct/dk_servo_1_decoration.dart';
import 'package:untitled1/screen_block/design_block/dkct/dk_servo_2_decoration.dart';
import 'package:untitled1/screen_block/design_block/dkct/dk_servo_3_decoration.dart';
import 'package:untitled1/screen_block/design_block/dkct/dkct_bat_tay_decoration.dart';
import 'package:untitled1/screen_block/design_block/dkct/dkct_decoration.dart';
import 'package:untitled1/screen_block/design_block/dkct/dkct_ha_tay_decoration.dart';
import 'package:untitled1/screen_block/design_block/dkct/dkct_nghi_decoration.dart';
import 'package:untitled1/screen_block/design_block/dkcd/dkdcl_decoration.dart';
import 'package:untitled1/screen_block/design_block/dkcd/dkdct_decoration.dart';
import 'package:untitled1/screen_block/design_block/dkcd/dkdcx90_decoration.dart';
import 'package:untitled1/screen_block/design_block/dkcd/dkdcx90t_decoration.dart';
import 'package:untitled1/screen_block/design_block/dkct/dkct_vay_tay_decoration.dart';
import 'package:untitled1/screen_block/design_block/start_decoration.dart';

class block extends StatefulWidget {
  block({
    Key? key,
    required this.top,
    required this.left,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.onPanStart,
    required this.onsubmitt_speed,
    required this.onsubmitt_delay,
    required this.border,
    required this.mode,
    required this.onTap,
    required this.myController_speed,
    required this.myController_delay,
    required this.onsubmitt_angle,
    required this.myController_angle,
  }) : super(key: key);

  final double top;
  final double left;
  final Function(DragUpdateDetails details) onPanUpdate;
  final Function(DragEndDetails details) onPanEnd;
  final Function(DragStartDetails data) onPanStart;
  final Function() onTap;
  final bool border;
  final String mode;
  final Function(String value) onsubmitt_speed;
  final Function(String value) onsubmitt_delay;
  final Function(String value) onsubmitt_angle;
  final TextEditingController myController_speed;
  final TextEditingController myController_delay;
  final TextEditingController myController_angle;

  @override
  State<block> createState() => _blockState();
}

class _blockState extends State<block> {
  Map<String, Color> ModeBlock = {
    'START': Colors.green.shade900,
    'Tiến': Colors.red,
    'Lùi': Colors.red,
    'Xoay Phải': Colors.red,
    'Xoay Trái': Colors.red,
    'Xoay Tròn': Colors.red,
    'Chào': Colors.blue.shade900,
    'Nghỉ': Colors.blue.shade900,
    'Vẫy Tay': Colors.blue.shade900,
    'Hạ Tay': Colors.blue.shade900,
    'Bắt Tay': Colors.blue.shade900,
    'Servo 1': Colors.blue.shade900,
    'Servo 2': Colors.blue.shade900,
    'Servo 3': Colors.blue.shade900,
  };
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Positioned(
        top: widget.top,
        left: widget.left,
        child: GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onPanUpdate: (widget.mode == 'START') ? null : widget.onPanUpdate,
            onPanEnd: (widget.mode == 'START') ? null : widget.onPanEnd,
            onPanStart: (widget.mode == 'START') ? null : widget.onPanStart,
            onTap: (widget.mode == 'START') ? widget.onTap : null,
            child: GetBlocks(ModeBlock, widget.mode, widget)),
      ),
    );
  }
}

Widget GetBlocks(Map<String, Color> ModeBlock, String data, block widget) {
  if (data == 'START') {
    return StartDecoration(ModeBlock: ModeBlock, widget: widget);
  } else if (data == 'Tiến') {
    return DkdctDecoration(
      myController_delay: widget.myController_delay,
      myController_speed: widget.myController_speed,
      ModeBlock: ModeBlock,
      widget: widget,
      onsubmitt_speed: widget.onsubmitt_speed,
      onsubmitt_delay: widget.onsubmitt_delay,
    );
  } else if (data == 'Lùi') {
    return DkdclDecoration(
      myController_delay: widget.myController_delay,
      myController_speed: widget.myController_speed,
      ModeBlock: ModeBlock,
      widget: widget,
      onsubmitt_speed: widget.onsubmitt_speed,
      onsubmitt_delay: widget.onsubmitt_delay,
    );
  } else if (data == 'Xoay Phải') {
    return Dkdcx90Decoration(
      ModeBlock: ModeBlock,
      widget: widget,
      onsubmitt_speed: widget.onsubmitt_speed,
      onsubmitt_delay: widget.onsubmitt_delay,
      myController_speed: widget.myController_speed,
      myController_delay: widget.myController_delay,
    );
  } else if (data == 'Xoay Trái') {
    return Dkdcx90tDecoration(
      ModeBlock: ModeBlock,
      widget: widget,
      onsubmitt_speed: widget.onsubmitt_speed,
      onsubmitt_delay: widget.onsubmitt_delay,
      myController_speed: widget.myController_speed,
      myController_delay: widget.myController_delay,
    );
  } else if (data == 'Xoay Tròn') {
    return DkdcxtDecoration(ModeBlock: ModeBlock, widget: widget);
  } else if (data == 'Chào') {
    return DkctDecoration(ModeBlock: ModeBlock, widget: widget);
  } else if (data == 'Nghỉ') {
    return DkctNghiDecoration(ModeBlock: ModeBlock, widget: widget);
  } else if (data == 'Vẫy Tay') {
    return DkctVayTayDecoration(ModeBlock: ModeBlock, widget: widget);
  } else if (data == 'Bắt Tay') {
    return DkctBatTayDecoration(ModeBlock: ModeBlock, widget: widget);
  } else if (data == 'Hạ Tay') {
    return DkctHaTayDecoration(ModeBlock: ModeBlock, widget: widget);
  } else if (data == 'Servo 1') {
    return DkServo1(
      ModeBlock: ModeBlock,
      widget: widget,
      onsubmitt_angle: widget.onsubmitt_angle,
      myController_angle: widget.myController_angle,
    );
  } else if (data == 'Servo 2') {
    return DkServo2(
      ModeBlock: ModeBlock,
      widget: widget,
      onsubmitt_angle: widget.onsubmitt_angle,
      myController_angle: widget.myController_angle,
    );
  } else if (data == 'Servo 3') {
    return DkServo3(
      ModeBlock: ModeBlock,
      widget: widget,
      onsubmitt_angle: widget.onsubmitt_angle,
      myController_angle: widget.myController_angle,
    );
  }
  return Text('Lỗi');
}
