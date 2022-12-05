import 'package:flutter/material.dart';
import 'package:untitled1/screen_block/block/block.dart';

class DkServo3 extends StatelessWidget {
  const DkServo3({
    Key? key,
    required this.ModeBlock,
    required this.widget,
    required this.onsubmitt_angle,
    required this.myController_angle,
  }) : super(key: key);

  final Map<String, Color> ModeBlock;
  final block widget;
  final Function(String value) onsubmitt_angle;
  final TextEditingController myController_angle;
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
          width: 120,
          height: 90,
          padding: EdgeInsets.only(top: 5),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Servo 3',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.0),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: Image(image: AssetImage('assets/svg_icon/tay.png')
                          //CirclePain(),
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 20,
                      child:
                          Image(image: AssetImage('assets/svg_icon/angle.png')),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 44,
                      height: 20,
                      child: TextField(
                        controller: myController_angle,
                        onChanged: onsubmitt_angle,
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
                      height: 20,
                    ),
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
