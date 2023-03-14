import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/home_screen/slider_circle/gradient_rect_slider_track_shape.dart';
import 'package:untitled1/screen_block/block/block.dart';
import 'package:untitled1/screen_block/list_box/list_box.dart';

import 'vi_tri_block/vi_tri_block.dart';

class ScreenBlock extends StatefulWidget {
  // final BluetoothConnection connection;
  ScreenBlock({
    Key? key,
    this.connection,
  }) : super(key: key);
  final BluetoothConnection? connection;

  @override
  State<ScreenBlock> createState() => _ScreenBlockState();
}

Uint8List convertStringToUint8List(String str) {
  final List<int> codeUnits = str.codeUnits;
  final Uint8List unit8List = Uint8List.fromList(codeUnits);

  return unit8List;
}

class _ScreenBlockState extends State<ScreenBlock> {
  List<VitriBlock> listBlock = [
    VitriBlock(top: 80, left: 20, border: false, mode: 'START'),
  ];
  // bool isConnect() {
  //   return widget.connection != null && widget.connection!.isConnected;
  // }

  Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }

  bool isConnect() {
    return widget.connection != null && widget.connection!.isConnected;
  }

  bool IsClickBook = false;
  static const Map<String, String> LenhDieuKhien = {
    'START': 's',
    'Tiến': 'T',
    'Lùi': 'B',
    'Xoay Phải': 'R',
    'Xoay Trái': 'L',
    'Xoay Tròn': 'A',
    'Servo 1': 's1:',
    'Servo 2': 's2:',
    'Servo 3': 's3:',
    'Chào': 'a1',
    'Vẫy Tay': 'a2',
    'Nghỉ': 'a3',
    'Bắt Tay': 'a4',
    'Hạ Tay': 'a5',
    'Giơ Tay': 'a6',
  };
  static const List<String> ListBlockDc = [
    'Tiến',
    'Lùi',
    'Xoay Phải',
    'Xoay Trái',
    'Xoay Tròn'
  ];
  static const List<String> ListBlockTayMay = [
    'Servo 1',
    'Servo 2',
    'Servo 3',
    'Chào',
    'Vẫy Tay',
    'Nghỉ',
    'Bắt Tay',
    'Gắp Vật',
    'Hạ Tay',
  ];
  double widget_scale = 1;
  List<String> ListViewBlock = [];
  Color ListColor = Colors.pinkAccent;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    listBlock.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        drawer: Drawer(
          width: 250,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ...ListViewBlock.map((element) {
                  return Container(
                    child: GestureDetector(
                      onTap: () {
                        listBlock.add(
                          VitriBlock(
                              top: 270,
                              left: 300,
                              border: false,
                              mode: element),
                        );
                        setState(() {});
                        _closeDrawer();
                      },
                      child: ListBox(
                        element: element,
                        color: ListColor,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ...listBlock.map(
                    (e) => block(
                      scale: widget_scale,
                      myController_angle: e.myController_angle,
                      myController_speed: e.myController_speed,
                      myController_delay: e.myController_delay,
                      // myController: e.ModeBlock!.myController,
                      onsubmitt_angle: (data) {
                        e.ModeBlock!.setCmdAngle = data;
                      },
                      onsubmitt_delay: (data) {
                        e.ModeBlock!.setCmdDelay = data;
                        print(e.myController_delay.text);
                        // e.myController_delay.text = e.ModeBlock!.cmd_delay;
                        //setState(() {});
                        // print(e.myController_delay.text);
                      },
                      onsubmitt_speed: (data) {
                        e.ModeBlock!.setCmdSpeed = data;
                        // e.ModeBlock!.myController.text = data;
                        // print(e.ModeBlock.cmd_speed);
                      },
                      mode: e.mode,
                      top: e.top,
                      left: e.left,
                      border: e.border,
                      onTap: () async {
                        String cmd = 'Z';
                        // print(ListBlock[0].left);
                        // print(ListBlock[0].size_Box.width);
                        double Left_position = listBlock[0].left * widget_scale;
                        double Width =
                            listBlock[0].size_Box.width * widget_scale;
                        // print(Left_position + Width);
                        for (int i = 1; i < listBlock.length; i++) {
                          // print(
                          //     '${listBlock[i].top}  ${listBlock[i].left} +${listBlock[i].size_Box.width} ');
                          // print(
                          //     '${listBlock[0].top}  ${listBlock[0].left} +${listBlock[0].size_Box.width} ');
                          if (listBlock[i].top == listBlock[0].top &&
                              ((listBlock[i].left - Left_position) - Width <
                                      0.5 ||
                                  (listBlock[i].left - Left_position) - Width >
                                      -0.5)) {
                            Width = listBlock[i].size_Box.width * widget_scale;
                            Left_position = listBlock[i].left;
                            if (listBlock[i].ModeBlock != null) {
                              if (listBlock[i].mode == 'Tiến' ||
                                  listBlock[i].mode == 'Lùi' ||
                                  listBlock[i].mode == 'Xoay Phải' ||
                                  listBlock[i].mode == 'Xoay Trái') {
                                cmd = cmd +
                                    '/' +
                                    LenhDieuKhien[listBlock[i].mode]! +
                                    listBlock[i].ModeBlock!.getCmd_T;
                              } else {
                                cmd = cmd +
                                    '/' +
                                    LenhDieuKhien[listBlock[i].mode]! +
                                    listBlock[i].ModeBlock!.getCmd_S;
                              }
                            } else {
                              cmd =
                                  cmd + '/' + LenhDieuKhien[listBlock[i].mode]!;
                            }
                          }
                        }
                        cmd = cmd + '/n';
                        print(cmd);
                        if (isConnect()) {
                          try {
                            widget.connection!.output
                                .add(convertStringToUint8List(cmd));
                            await widget.connection!.output.allSent;
                          } catch (error) {
                            //print(error);
                          }
                        }
                        setState(() {});
                      },
                      onPanUpdate: (element) {
                        e.GetTop = max(0, e.top + element.delta.dy);
                        e.left = max(0, e.left + element.delta.dx);
                        setState(() {});
                      },
                      onPanEnd: (value) {
                        //print(e.ModeBlock.myController.text + ' day la dc');
                        setState(() {
                          IsClickBook = false;
                          e.GetBorder = false;
                        });
                        bool isRemove = true;
                        double lelf_e = e.left;
                        double Position_e_left = e.left;
                        double Position_e_top = e.top;
                        double width_e = e.size_Box.width;
                        // print('width e ${listBlock[0].size_Box.width}');
                        double width_list = listBlock[0].size_Box.width;
                        listBlock.remove(e);
                        for (int i = 0; i < listBlock.length; i++) {
                          if (e.top > listBlock[i].top - 20 &&
                              e.top <
                                  listBlock[i].top +
                                      listBlock[i].size_Box.height *
                                          widget_scale &&
                              e.left >
                                  listBlock[i].left + 0.01 * widget_scale &&
                              e.left <
                                  listBlock[i].left +
                                      listBlock[i].size_Box.width *
                                          widget_scale) {
                            // print(ListBlock[i].size_Box.width.toString() +
                            //     ' ' +
                            //     ListBlock[i].size_Box.height.toString() +
                            //     ListBlock[i].mode.toString());
                            isRemove = false;
                            Position_e_top = listBlock[i].top;
                            width_list = listBlock[i].size_Box.width;
                            Position_e_left =
                                listBlock[i].left + (width_list * widget_scale);
                            if (i == 0) {
                              Position_e_left = 20 * widget_scale +
                                  (width_list * widget_scale);
                            }
                            // print(
                            //     'e_left = ${Position_e_left}  width = ${listBlock[i].left} + ${listBlock[i].size_Box.width * widget_scale}');
                            lelf_e = Position_e_left;
                            // print(ListBlock.length);
                            for (int j = i; j < listBlock.length; j++) {
                              print(
                                  'e_left = ${Position_e_left}  width = ${listBlock[j].left} + ${listBlock[j].size_Box.width * widget_scale}');
                              if (listBlock[j].top == Position_e_top &&
                                  listBlock[j].left == lelf_e) {
                                listBlock[j].left =
                                    lelf_e + width_e * widget_scale;
                                width_list = listBlock[j].size_Box.width;
                                lelf_e = lelf_e + width_list * widget_scale;

                                //print('co vao ori');
                                //print(j);
                                setState(() {});
                                listBlock.forEach((element) {
                                  print(element.left);
                                });
                              }
                            }
                            // ListBlock.forEach((element) {
                            //   print(element.left);
                            // });
                            // print('---------');
                            listBlock.insert(
                              i + 1,
                              VitriBlock(
                                  top: Position_e_top,
                                  left: Position_e_left,
                                  border: e.border,
                                  mode: e.mode),
                            );
                            if (listBlock[i + 1].ModeBlock != null) {
                              listBlock[i + 1].ModeBlock!.setCmdDelay =
                                  e.ModeBlock!.cmd_delay;
                              listBlock[i + 1].ModeBlock!.setCmdSpeed =
                                  e.ModeBlock!.cmd_speed;
                              listBlock[i + 1].ModeBlock!.setCmdAngle =
                                  e.ModeBlock!.cmd_Angle;
                              if (listBlock[i + 1].ModeBlock!.cmd_delay !=
                                  '0') {
                                listBlock[i + 1].myController_delay.text =
                                    listBlock[i + 1].ModeBlock!.cmd_delay;
                              }
                              if (listBlock[i + 1].ModeBlock!.cmd_speed !=
                                  '0') {
                                listBlock[i + 1].myController_speed.text =
                                    e.ModeBlock!.cmd_speed;
                              }

                              if (listBlock[i + 1].ModeBlock!.cmd_Angle !=
                                  '0') {
                                listBlock[i + 1].myController_angle.text =
                                    e.ModeBlock!.cmd_Angle;
                              }
                              // print(ListBlock[i + 1].myController_delay.text);
                            }

                            setState(() {});
                            break;
                          }
                        }
                        if (isRemove) {
                          listBlock.add(VitriBlock(
                              top: e.top,
                              left: e.left,
                              border: e.border,
                              mode: e.mode));
                          if (listBlock[listBlock.length - 1].ModeBlock !=
                              null) {
                            listBlock[listBlock.length - 1]
                                .ModeBlock!
                                .cmd_delay = e.ModeBlock!.cmd_delay;
                            listBlock[listBlock.length - 1]
                                .ModeBlock!
                                .cmd_speed = e.ModeBlock!.cmd_speed;
                            listBlock[listBlock.length - 1]
                                .ModeBlock!
                                .cmd_Angle = e.ModeBlock!.cmd_Angle;
                            if (e.ModeBlock!.cmd_delay != '0') {
                              listBlock[listBlock.length - 1]
                                  .myController_delay
                                  .text = e.ModeBlock!.cmd_delay;
                            }
                            if (e.ModeBlock!.cmd_speed != '0') {
                              listBlock[listBlock.length - 1]
                                  .myController_speed
                                  .text = e.ModeBlock!.cmd_speed;
                            }
                            if (e.ModeBlock!.cmd_Angle != '0') {
                              listBlock[listBlock.length - 1]
                                  .myController_angle
                                  .text = e.ModeBlock!.cmd_Angle;
                            }

                            // print(
                            //     ListBlock[ListBlock.length - 1].ModeBlock.getCmd_T);
                          }
                          setState(() {});
                        }
                      },
                      onPanStart: (data) {
                        setState(() {
                          IsClickBook = true;
                          e.GetBorder = true;
                        });
                        double Left_e = e.left;
                        double size_e = e.size_Box.width * widget_scale;
                        double size_last = e.size_Box.width * widget_scale;
                        for (int i = 1; i < listBlock.length; i++) {
                          if (listBlock[i].top == e.top &&
                              listBlock[i].left == Left_e + size_last) {
                            Left_e = listBlock[i].left;
                            listBlock[i].GetLeft = listBlock[i].left - size_e;
                            size_last =
                                listBlock[i].size_Box.width * widget_scale;
                            // print(i);
                            // print(Left_e.toString() + ' ' + size_e.toString());
                            // if (i == ListBlock.length - 1) {
                            //   break;
                            // }
                            setState(() {});
                          }
                        }
                      },
                    ),
                  ),
                ],
                // This trailing comma makes auto-formatting nicer for build methods.
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Container(
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: [Colors.pink, Colors.purple]),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Container(
                                  height: 40,
                                  width: 70,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    CupertinoIcons.back,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ListViewBlock = ListBlockDc;
                            ListColor = Colors.red;
                            //print(ListBlock.length);
                            setState(() {});
                            _openDrawer();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: Icon(Icons.add),
                          label: Text('Động cơ '),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ListViewBlock = ListBlockTayMay;
                            ListColor = Colors.blue.shade900;
                            setState(() {});
                            //print(ListBlock.length);
                            _openDrawer();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade900,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: Icon(Icons.add),
                          label: Text('Cánh tay'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            String cmd = 'Z';
                            // print(ListBlock[0].left);
                            // print(ListBlock[0].size_Box.width);
                            listBlock.forEach((element) {
                              print('${element.top}+ ${element.left} ');
                            });
                            double Left_position =
                                listBlock[0].left * widget_scale;
                            double Width =
                                listBlock[0].size_Box.width * widget_scale;
                            //print(Left_position + Width);
                            for (int i = 1; i < listBlock.length; i++) {
                              print(
                                  (listBlock[i].left - Left_position) - Width);
                              if (listBlock[i].top == listBlock[0].top &&
                                  ((listBlock[i].left - Left_position) - Width <
                                          1 ||
                                      (listBlock[i].left - Left_position) -
                                              Width >
                                          -1)) {
                                Width =
                                    listBlock[i].size_Box.width * widget_scale;
                                Left_position = listBlock[i].left;
                                if (listBlock[i].ModeBlock != null) {
                                  if (listBlock[i].mode == 'Tiến' ||
                                      listBlock[i].mode == 'Lùi' ||
                                      listBlock[i].mode == 'Xoay Phải' ||
                                      listBlock[i].mode == 'Xoay Trái') {
                                    cmd = cmd +
                                        '/' +
                                        LenhDieuKhien[listBlock[i].mode]! +
                                        listBlock[i].ModeBlock!.getCmd_T;
                                  } else {
                                    cmd = cmd +
                                        '/' +
                                        LenhDieuKhien[listBlock[i].mode]! +
                                        listBlock[i].ModeBlock!.getCmd_S;
                                  }
                                } else {
                                  cmd = cmd +
                                      '/' +
                                      LenhDieuKhien[listBlock[i].mode]!;
                                }
                              }
                            }
                            cmd = cmd + '/n';
                            print(cmd);
                            if (isConnect()) {
                              try {
                                widget.connection!.output
                                    .add(convertStringToUint8List(cmd));
                                await widget.connection!.output.allSent;
                              } catch (error) {
                                //print(error);
                              }
                            }
                            setState(() {});
                            // if (isConnect()) {
                            //   try {
                            //     widget.connection!.output.add(
                            //       convertStringToUint8List(cmd),
                            //     );
                            //     await widget.connection!.output.allSent;
                            //   } catch (error) {
                            //     print(error);
                            //   }
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade900,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: Icon(Icons.start),
                          label: Text('Chạy'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (listBlock.length > 1) {
                              listBlock.removeAt(listBlock.length - 1);
                            }
                            //print(ListBlock.length);
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: Icon(Icons.remove),
                          label: Text('Xóa'),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 20,
                            thumbColor: Colors.blue.shade900,
                            trackShape: const GradientRectSliderTrackShape(
                                gradient: LinearGradient(
                                    colors: <Color>[Colors.red, Colors.purple]),
                                darkenInactive: false),
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 17.0),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 30.0),
                          ),
                          child: Slider(
                            value: widget_scale,
                            onChangeEnd: (val) {
                              print(
                                  '${listBlock[1].top} + ${listBlock[1].size_Box.height}');
                              print(
                                  '${listBlock[0].top} + ${listBlock[0].size_Box.height}');
                              // print(val);
                              for (int i = 1; i < listBlock.length; i++) {
                                if (listBlock[i].top != listBlock[i - 1].top) {
                                } else if (i == 1) {
                                  listBlock[i].left =
                                      listBlock[0].left * widget_scale +
                                          listBlock[0].size_Box.width *
                                              widget_scale;
                                } else {
                                  listBlock[i].left = listBlock[i - 1].left +
                                      listBlock[i - 1].size_Box.width *
                                          widget_scale;
                                }
                                setState(() {});
                              }
                            },
                            onChanged: (val) async {
                              val = val ~/ 0.1 * 0.1;

                              widget_scale = val;
                              setState(() {});
                            },
                            max: 1,
                            min: 0.00,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
