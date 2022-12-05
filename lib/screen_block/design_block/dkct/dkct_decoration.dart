import 'package:flutter/material.dart';
import 'package:untitled1/screen_block/block/block.dart';

class DkctDecoration extends StatelessWidget {
  const DkctDecoration({
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Chào',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.0),
              ),
              Container(
                width: 50,
                height: 50,
                child: Image(
                  image: AssetImage('assets/svg_icon/tay.png'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
