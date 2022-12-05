import 'package:flutter/material.dart';
import 'package:untitled1/screen_block/block/block.dart';
import 'package:untitled1/screen_block/paint/circle_paint.dart';

class StartDecoration extends StatelessWidget {
  const StartDecoration({
    Key? key,
    required this.ModeBlock,
    required this.widget,
  }) : super(key: key);

  final Map<String, Color> ModeBlock;
  final block widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              color: ModeBlock[widget.mode],
              border: Border.all(
                color: widget.border ? Colors.blue : Colors.white,
                width: widget.border ? 5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.border
                      ? Colors.blue.withOpacity(0.3)
                      : Colors.white.withOpacity(0.0),
                  blurRadius: 60,
                  offset: Offset(2, 2),
                )
              ],
              borderRadius: BorderRadius.circular(10)),
        ),
        Container(
          width: 80,
          height: 80,
          child: CustomPaint(
            foregroundPainter: CirclePaint(),
            //CirclePain(),
          ),
        ),
        Container(
          width: 80,
          height: 80,
          child: Center(
            child: Text(
              'Bắt đầu',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.0),
            ),
          ),
        )
      ],
    );
  }
}
