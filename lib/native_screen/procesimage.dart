import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled1/home_screen/joystick/joys_tick_custom.dart';
import 'package:untitled1/native_screen/data_joytich.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:async';
import 'painter/face_detector_painter.dart';
import 'rectan_face.dart';

class ProcessImage extends StatefulWidget {
  const ProcessImage({Key? key, required this.Url_socketweb, this.connection})
      : super(key: key);
  final String Url_socketweb;
  final BluetoothConnection? connection;
  @override
  State<ProcessImage> createState() => _ProcessImageState();
}

class _ProcessImageState extends State<ProcessImage> {
  MyBloc bloc = MyBloc();
  StreamController<Data_Joytich> controller =
      StreamController<Data_Joytich>.broadcast();
  StreamController<double> controller_slider =
      StreamController<double>.broadcast();
  //String Url = '10.97.6.136';
  double rating = 50;
  int CountNotface = 0;
  bool Checkface = false;
  int check = 0;
  Uint8List? bytes;
  bool loadanh = false;
  File? file;
  Image? img;
  Uint8List? imageData;
  Timer? mytimer;
  IOWebSocketChannel? channel;
  StreamController<int> counterController = StreamController<int>.broadcast();
  var receivePort;
  final faceDetector = FaceDetector(
      options: FaceDetectorOptions(
    // enableClassification: f,
    performanceMode: FaceDetectorMode.accurate,
  ));
  bool isConnect() {
    return widget.connection != null && widget.connection!.isConnected;
  }

  Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }

  @override
  void initState() {
    Stream stream = controller.stream;
    Stream slider_servo = controller_slider.stream;
    Stream detectfae = counterController.stream;
    detectfae.listen((event) {});
    slider_servo.listen((data) async {
      if (rating + data > 50) {
        if (isConnect()) {
          //print(top_servo1 ~/ 10 * 10);
          // print(top_servo1_last);
          try {
            widget.connection!.output.add(convertStringToUint8List('s4:50n'));
            //top_servo1_last = top_servo1 ~/ 10 * 10;
            await widget.connection!.output.allSent;
          } catch (error) {
            //print(error);
          }
        }
      } else if (rating + data < 0) {
        if (isConnect()) {
          //print(top_servo1 ~/ 10 * 10);
          // print(top_servo1_last);
          try {
            widget.connection!.output.add(convertStringToUint8List('s4:0n'));
            //top_servo1_last = top_servo1 ~/ 10 * 10;
            await widget.connection!.output.allSent;
          } catch (error) {
            //print(error);
          }
        }
      } else {
        rating = rating + data;
        // setState(() {});
        if (isConnect()) {
          //print(top_servo1 ~/ 10 * 10);
          // print(top_servo1_last);
          try {
            widget.connection!.output
                .add(convertStringToUint8List('s4:${rating.toInt()}n'));
            //top_servo1_last = top_servo1 ~/ 10 * 10;
            await widget.connection!.output.allSent;
          } catch (error) {
            //print(error);
          }
        }
      }
    });
    stream.listen((data) async {
      var controll_x = (data.x * 100).ceil();
      var controll_y = (data.y * 100).ceil();
      print((controll_x * 2.55).toInt().toString() +
          '/' +
          (-1 * controll_y * 2.55).toInt().toString());
      if (isConnect()) {
        try {
          widget.connection!.output.add(convertStringToUint8List('m:' +
              (controll_x * 2.55).toInt().toString() +
              '/' +
              ((controll_y * -2.55).toInt()).toString() +
              'n'));
          await widget.connection!.output.allSent;
        } catch (error) {
          //print(error);
        }
      }
    });
    mytimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      //code to run on every 5 seconds
      if (imageData != null) {
        buildwidget(imageData);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    faceDetector.close();
    mytimer!.cancel();
    channel!.sink.close();
    bloc.dispose();
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int controll_x = 0;
    int controll_y = 0;
    var size = MediaQuery.of(context).size;
    channel = IOWebSocketChannel.connect(
        Uri.parse('ws://${widget.Url_socketweb}:81'));
    //InputImageData? data_image;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Center(
              child: Stack(
                children: <Widget>[
                  Container(
                      width: size.width,
                      height: size.height,
                      child: StreamBuilder(
                          stream: channel?.stream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              //imageData = (assetName)
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.deepOrange),
                                ),
                              );
                            } else {
                              imageData = snapshot.data;
                              //setState(() {});
                              return Image.memory(
                                imageData!,
                                width: 672,
                                height: 360,
                                gaplessPlayback: true,
                                fit: BoxFit.contain,
                              );
                            }
                          })),
                  Center(
                    child: Container(
                      height: size.height,
                      width: size.width,
                      child: StreamBuilder(
                        stream: bloc.counterStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Rectan_face data = snapshot.data;
                            print(
                                ' ${data.Check_face}  + ${data.top} +  ${data.left}');
                            if (data.Check_face == true) {
                              counterController.add(0);
                              return CustomPaint(
                                foregroundPainter: FaceDetectorPainter(
                                    data,
                                    Size(672, 360),
                                    InputImageRotation.rotation0deg),
                              );
                            } else {
                              counterController.add(1);
                              return Container();
                            }
                          } else {
                            // print('not data');
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      faceDetector.close();
                      mytimer!.cancel();
                      channel!.sink.close();
                      bloc.dispose();
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
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: JoysTickCustom(
                    listener: (details) {
                      Data_Joytich data =
                          Data_Joytich(x: details.x, y: details.y);
                      controller.add(data);
                    },
                    onStickDragEnd: () {
                      Data_Joytich data = Data_Joytich(x: 0, y: 0);
                      controller.add(data);
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        print("nhả");
                        controller_slider.add(-5);
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // circular shape
                          gradient: LinearGradient(
                            colors: [Colors.pink, Colors.purple],
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    GestureDetector(
                      onTap: () async {
                        print("Nhấn");
                        controller_slider.add(5);
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // circular shape
                          gradient: LinearGradient(
                            colors: [Colors.pink, Colors.purple],
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () async {
                        //print("nhả");
                        channel!.sink.close();
                        channel = IOWebSocketChannel.connect(
                            Uri.parse('ws://${widget.Url_socketweb}:81'));
                        setState(() {});
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // circular shape
                          gradient: LinearGradient(
                            colors: [Colors.pink, Colors.purple],
                          ),
                        ),
                        child: Icon(
                          Icons.auto_mode,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
                SizedBox(
                  width: 30,
                )
              ],
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     //buildwidget(imageData);
        //     channel!.sink.close();
        //     channel = IOWebSocketChannel.connect(
        //         Uri.parse('ws://${widget.Url_socketweb}:81'));
        //     setState(() {});
        //   },
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  // }
  buildwidget(Uint8List? data) async {
    //print('123');
    final dir = (await getTemporaryDirectory()).path;
    final imageFile = File('$dir/a.png')..writeAsBytesSync(imageData!);
    final image = InputImage.fromFile(imageFile);
    processImage(image);
  }

  Future<void> processImage(InputImage inputImage) async {
    final faces = await faceDetector.processImage(inputImage);
    if (faces.length == 0) {
      //print('Hong co ai');
      Rectan_face data =
          Rectan_face(Check_face: false, top: 0, left: 0, bot: 0, right: 0);
      bloc.SendFace(data);
      return;
    } else {
      // if (inputImage.inputImageData?.size != null &&
      //     inputImage.inputImageData?.imageRotation != null) {
      //   //   final painter = FaceDetectorPainter(
      //   //       faces,
      //   //       inputImage.inputImageData!.size,
      //   //       inputImage.inputImageData!.imageRotation);
      //   //   // _customPaint = CustomPaint(painter: painter);
      String text = 'Faces found 1 : ${faces.length}\n\n';
      for (final face in faces) {
        text +=
            'face 1 :  ${face.boundingBox.left}  ${face.boundingBox.right} ${face.boundingBox.height} \n\n';
        Rectan_face data = Rectan_face(
          Check_face: true,
          top: face.boundingBox.top,
          left: face.boundingBox.left,
          bot: face.boundingBox.bottom,
          right: face.boundingBox.right,
        );
        bloc.SendFace(data);
        print(text);
        return;
      }
    }
    //_isBusy = false;
    // if (mounted) {
    //   setState(() {});
    // }
  }
}
