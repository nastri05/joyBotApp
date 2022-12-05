import 'package:flutter/material.dart';
import 'package:untitled1/screen_block/block/block.dart';
import 'package:untitled1/screen_block/paint/path_paint_lui.dart';

class DkdclDecoration extends StatelessWidget {
  const DkdclDecoration({
    Key? key,
    required this.ModeBlock,
    required this.widget,
    required this.onsubmitt_speed,
    required this.onsubmitt_delay,
    required this.myController_speed,
    required this.myController_delay,
  }) : super(key: key);

  final Map<String, Color> ModeBlock;
  final block widget;
  final Function(String value) onsubmitt_speed;
  final Function(String value) onsubmitt_delay;
  final TextEditingController myController_speed;
  final TextEditingController myController_delay;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 90,
          width: 120,
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
            foregroundPainter: PathPaintLui(),
            //CirclePain(),
          ),
        ),
        Container(
          width: 120,
          height: 90,
          padding: EdgeInsets.only(top: 5),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Lùi',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.0),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.speed,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 20,
                      child: TextField(
                        controller: myController_speed,
                        onChanged: onsubmitt_speed,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.zero,
                          hintText: '0',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      child: Icon(
                        Icons.hourglass_bottom,
                        size: 17,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Container(
                      width: 40,
                      height: 20,
                      child: TextField(
                        controller: myController_delay,
                        onChanged: onsubmitt_delay,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.zero,
                          hintText: '0',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
