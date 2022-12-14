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
    'Ti???n': Colors.red,
    'L??i': Colors.red,
    'Xoay Ph???i': Colors.red,
    'Xoay Tr??i': Colors.red,
    'Xoay Tr??n': Colors.red,
    'Ch??o': Colors.blue.shade900,
    'Ngh???': Colors.blue.shade900,
    'V???y Tay': Colors.blue.shade900,
    'H??? Tay': Colors.blue.shade900,
    'B???t Tay': Colors.blue.shade900,
    'Servo 1': Colors.blue.shade900,
    'Servo 2': Colors.blue.shade900,
    'Servo 3': Colors.blue.shade900,
  };
  @override
  Widget build(BuildContext context) {
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
  } else if (data == 'Ti???n') {
    return DkdctDecoration(
      myController_delay: widget.myController_delay,
      myController_speed: widget.myController_speed,
      ModeBlock: ModeBlock,
      widget: widget,
      onsubmitt_speed: widget.onsubmitt_speed,
      onsubmitt_delay: widget.onsubmitt_delay,
    );
  } else if (data == 'L??i') {
    return DkdclDecoration(
      myController_delay: widget.myController_delay,
      myController_speed: widget.myController_speed,
      ModeBlock: ModeBlock,
      widget: widget,
      onsubmitt_speed: widget.onsubmitt_speed,
      onsubmitt_delay: widget.onsubmitt_delay,
    );
  } else if (data == 'Xoay Ph???i') {
    return Dkdcx90Decoration(
      ModeBlock: ModeBlock,
      widget: widget,
      onsubmitt_speed: widget.onsubmitt_speed,
      onsubmitt_delay: widget.onsubmitt_delay,
      myController_speed: widget.myController_speed,
      myController_delay: widget.myController_delay,
    );
  } else if (data == 'Xoay Tr??i') {
    return Dkdcx90tDecoration(
      ModeBlock: ModeBlock,
      widget: widget,
      onsubmitt_speed: widget.onsubmitt_speed,
      onsubmitt_delay: widget.onsubmitt_delay,
      myController_speed: widget.myController_speed,
      myController_delay: widget.myController_delay,
    );
  } else if (data == 'Xoay Tr??n') {
    return DkdcxtDecoration(ModeBlock: ModeBlock, widget: widget);
  } else if (data == 'Ch??o') {
    return DkctDecoration(ModeBlock: ModeBlock, widget: widget);
  } else if (data == 'Ngh???') {
    return DkctNghiDecoration(ModeBlock: ModeBlock, widget: widget);
  } else if (data == 'V???y Tay') {
    return DkctVayTayDecoration(ModeBlock: ModeBlock, widget: widget);
  } else if (data == 'B???t Tay') {
    return DkctBatTayDecoration(ModeBlock: ModeBlock, widget: widget);
  } else if (data == 'H??? Tay') {
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
  return Text('L???i');
}
