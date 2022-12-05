import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:untitled1/home_screen/joystick/joys_tick_custom.dart';
import 'package:untitled1/home_screen/loading/loading_app.dart';
import 'package:untitled1/home_screen/show_dialog_title/show_dialog_title.dart';
import 'package:untitled1/home_screen/slider_circle/controll_circle.dart';
import 'package:untitled1/screen_block/sreen_block.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'slider_circle/custom_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  BluetoothConnection? _connection;
  Timer? _discoverableTimeoutTimer;
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice? _device;
  List<DropdownMenuItem<BluetoothDevice>> ComboxList = [];
  bool _connect = false;
  bool _disconnect = false;
  late WebViewController controller;
  Set<String> listToTalk = {
    'Hello Google',
    'hello Google',
    'hey Google',
    'Hey Google',
    'hey robot',
    ' Hello Google',
    'hello.',
    'hello robot',
    'hello robo',
    'turn around',
    'hands up',
    'hands down',
    'hand up',
    'where are you now',
    'are you happy',
    'are you a robot',
    'are you robot',
    'him down',
    'and down',
    'you are dancing',
    'dancing'
  };
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = true;
  String _lastWords = '';
  String _value = '';
  double top_servo1 = 0;
  double lefl_servo1 = 0;
  double top_servo2 = 0;
  double lefl_servo2 = 0;
  void DefaultPosition() {
    top_servo1 = 62;
    lefl_servo1 =
        -(sqrt(160 * 160 - (top_servo1 - 160) * (top_servo1 - 160))) + 160;
    top_servo2 = 80;
    lefl_servo2 =
        -(sqrt(110 * 110 - (top_servo2 - 160) * (top_servo2 - 160))) + 160;
    setState(() {});
  }

  Future<void> Controll_Circle1(
    DragUpdateDetails details,
  ) async {
    if (lefl_servo1 > 35) {
      lefl_servo1 = max(0, lefl_servo1 + details.delta.dx);
      lefl_servo1 = min(lefl_servo1, 160);
      top_servo1 =
          -(sqrt(160 * 160 - (lefl_servo1 - 160) * (lefl_servo1 - 160))) + 160;
    } else {
      top_servo1 = max(0, top_servo1 + details.delta.dy);
      top_servo1 = min(top_servo1, 160);
      lefl_servo1 =
          -(sqrt(160 * 160 - (top_servo1 - 160) * (top_servo1 - 160))) + 160;
    }
    //_top = min(_top, 180);
    if (isConnect()) {
      try {
        _connection!.output.add(convertStringToUint8List(
            's1:' + ((160 - top_servo1) / 160 * 180).toInt().toString() + 'n'));
        await _connection!.output.allSent;
      } catch (error) {
        //print(error);
      }
    }
    // print(lefl_servo1);
    // // print(top);
    // print('-------');
    print(((160 - top_servo1) / 160 * 180).toInt());
    setState(() {});
  }

  Future<void> Controll_Circle2(DragUpdateDetails details) async {
    if (lefl_servo2 > 60) {
      lefl_servo2 = max(50, lefl_servo2 + details.delta.dx);
      lefl_servo2 = min(lefl_servo2, 160);
      //_top = min(_top, 180);
      top_servo2 =
          -(sqrt(110 * 110 - (lefl_servo2 - 160) * (lefl_servo2 - 160))) + 160;
    } else {
      top_servo2 = max(50, top_servo2 + details.delta.dy);
      top_servo2 = min(top_servo2, 160);
      //_top = min(_top, 180);
      lefl_servo2 =
          -(sqrt(110 * 110 - (top_servo2 - 160) * (top_servo2 - 160))) + 160;
    }
    if (isConnect()) {
      try {
        _connection!.output.add(convertStringToUint8List(
            's1:' + ((160 - top_servo2) / 160 * 180).toInt().toString() + 'n'));
        await _connection!.output.allSent;
      } catch (error) {
        //print(error);
      }
    }
    // print(lefl_servo2);
    // print(top_servo2);
    // print('-------');
    print(((160 - top_servo2) / 160 * 180).toInt());
    // print('=======');
    setState(() {});
  }

  @override
  void initState() {
    DefaultPosition();
    super.initState();
    _initSpeech();
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        if (_bluetoothState == BluetoothState.STATE_OFF) {}
        // Discoverable mode is disabled when Bluetooth gets disabled
        getPairedDevices();
      });
    });
    setState(() {
      getPairedDevices();
    });
  }

  // Bluetooth
  bool isConnect() {
    return _connection != null && _connection!.isConnected;
  }

  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];
    try {
      devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    } on PlatformException {
      print('error');
    }
    devices.forEach((element) {
      print(element.name);
    });
    if (devices.isEmpty) {
      _devicesList = devices;
      ComboxList = _getDeviceItems(_devicesList);
      setState(() {});
      return;
    }
    setState(() {
      _devicesList = devices;
      ComboxList = _getDeviceItems(_devicesList);
    });
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems(
      List<BluetoothDevice> devicesList) {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (devicesList.isEmpty) {
      //print('rong roi anh oi');
      items.add(DropdownMenuItem(
        child: Text(
          'NONE',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ));
    } else {
      devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name.toString(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          value: device,
        ));
      });
    }
    return items;
  }

  //convert String -> Unt8
  Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }

  Future<void> _connectBluetooth() async {
    await BluetoothConnection.toAddress(_device!.address).then((connection) {
      print('ket noi roi anh oi');
      _disconnect = false;
      _connection = connection;
      _connect = true;
      _connection!.input!.listen(null).onDone(
        () {
          if (!_disconnect) {
            _connect = false;
            _disconnectBluetooth();
            ShowDialogTitle.MyShowDialogTitle(
                context, 'Thiết bị đã bị tắt', 'Hãy kiểm tra lại Robot');
            setState(() {});
          }
        },
      );
    }).catchError((onError) {
      throw (onError);
      print('Cannot connect, exception occurred');
      print(onError);
    });
    setState(() {});
  }

  Future<void> _disconnectBluetooth() async {
    await _connection!.close();
    if (!isConnect()) {
      _connect = false;
      setState(() {});
    }
  }
  // kết thúc bluetooth

  // mic
  void _initSpeech() async {
    try {
      _speechEnabled = await _speechToText.initialize(onError: (error) {
        print('erro');
      });
      setState(() {});
    } catch (error) {
      setState(() {
        print(error);
      });
    }
  }

  void _stopListening() async {
    _value = '';
    await _speechToText.stop();
    setState(() {});
  }

  void _startListening() async {
    _isListening = true;
    var future_close = Future.doWhile(() async {
      await Future.delayed(
        const Duration(milliseconds: 100),
      );
      if (_speechToText.isNotListening) {
        return false;
      }
      return true;
    });
    var future = _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: Duration(seconds: 8),
      pauseFor: Duration(seconds: 5),
    );
    var future123 = LoadingApp.Loading_Mic(context, future_close);
    future123.whenComplete(() {
      if (_speechToText.isNotListening && _isListening) {
        ShowDialogTitle.ShowLoi(context);
        _isListening = false;
        setState(() {});
      }
    });
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      if (_value != result.recognizedWords) {
        print(result.recognizedWords);
        _value = result.recognizedWords;
        listToTalk.forEach((element1) {
          if (element1 == _value) {
            _isListening = false;
            print('chuẩn nhé');
            _speechToText.stop();
            setState(() {});
          }
        });
      }
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _discoverableTimeoutTimer?.cancel();
    if (isConnect()) {
      _connection!.dispose();
      _connection = null;
    }
    super.dispose();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    int controll_x = 0;
    int controll_y = 0;
    int controll_servo = 73;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height,
                width: size.width,
                child: WebView(
                  initialUrl: "http://192.168.50.243:4747/video",
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    this.controller = controller;
                  },
                  zoomEnabled: false,
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, left: 5, right: 5),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (!isConnect()) {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ScreenBlock(
                                              //connection: _connection!,
                                              ),
                                        ),
                                      );
                                    } else {
                                      await ShowDialogTitle.MyShowDialogTitle(
                                        context,
                                        'Chưa kết nối Bluetooth',
                                        'Hãy kết nối',
                                      );
                                    }
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Colors.pink,
                                          Colors.purple
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      width: 70,
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Icon(
                                        CupertinoIcons.book,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0, left: 5),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    bool result =
                                        await InternetConnectionChecker()
                                            .hasConnection;
                                    if (result) {
                                      controller.loadUrl(
                                          "http://192.168.50.243:4747/video");
                                    } else {
                                      await ShowDialogTitle.MyShowDialogTitle(
                                        context,
                                        'Kiểm tra lại kết nối mạng',
                                        'Hãy thử lại',
                                      );
                                    }
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Colors.pink,
                                          Colors.purple
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      width: 70,
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        CupertinoIcons.arrow_2_circlepath,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (ctx, setState) {
                                          return Dialog(
                                            elevation: 16,
                                            child: Container(
                                              height: 450.0,
                                              width: 360.0,
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Align(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        icon: Icon(
                                                          Icons.arrow_back_ios,
                                                          size: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      alignment:
                                                          Alignment.topLeft,
                                                    ),
                                                  ),
                                                  SwitchListTile(
                                                    title: Text(
                                                      'Enable Bluetooth',
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                    value: _bluetoothState
                                                        .isEnabled,
                                                    secondary: _bluetoothState
                                                            .isEnabled
                                                        ? Icon(
                                                            Icons.bluetooth,
                                                            size: 30,
                                                          )
                                                        : Icon(Icons
                                                            .bluetooth_disabled),
                                                    onChanged: (bool value) {
                                                      // Do the request and update with the true value then
                                                      future() async {
                                                        // async lambda seems to not working
                                                        if (value) {
                                                          var future =
                                                              FlutterBluetoothSerial
                                                                  .instance
                                                                  .requestEnable();
                                                          var resust =
                                                              await LoadingApp
                                                                  .Loading_Login(
                                                                      context,
                                                                      future);
                                                          await getPairedDevices();
                                                        } else {
                                                          var future =
                                                              FlutterBluetoothSerial
                                                                  .instance
                                                                  .requestDisable();
                                                          var resust =
                                                              await LoadingApp
                                                                  .Loading_Login(
                                                                      context,
                                                                      future);
                                                        }
                                                      }

                                                      future().then((_) {
                                                        // chờ future hoàn thành thì set lại
                                                        setState(() {});
                                                      });
                                                    },
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Device',
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                        ),
                                                        DropdownButton(
                                                          items: ComboxList,
                                                          //style: TextStyle(fontSize: 20),
                                                          onChanged:
                                                              _devicesList
                                                                      .isEmpty
                                                                  ? null
                                                                  : (value) {
                                                                      //print(value.toString());
                                                                      _device =
                                                                          value
                                                                              as BluetoothDevice;
                                                                      setState(
                                                                          () {});
                                                                    },

                                                          value: _devicesList
                                                                  .isNotEmpty
                                                              ? _device
                                                              : null,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 118,
                                                    height: 55,
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .indigo),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          18.0),
                                                                  side: BorderSide(
                                                                      color: Colors
                                                                          .red)))),
                                                      onPressed: _connect
                                                          ? () async {
                                                              _disconnect =
                                                                  true;
                                                              setState(() {});
                                                              await _disconnectBluetooth();
                                                              setState(() {});
                                                            }
                                                          : () async {
                                                              var futture =
                                                                  _connectBluetooth();
                                                              try {
                                                                var result = await LoadingApp
                                                                    .Loading_Login(
                                                                        context,
                                                                        futture);
                                                              } catch (error) {
                                                                ShowDialogTitle
                                                                    .MyShowDialogTitle(
                                                                        context,
                                                                        'Lỗi kết nối',
                                                                        'Kiểm tra lại thiết bị');
                                                              }
                                                              setState(() {});
                                                            },
                                                      child: Text(_connect
                                                          ? 'Disconnect'
                                                          : 'Connect'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                    );
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Colors.pink,
                                          Colors.purple
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      width: 70,
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Icon(
                                        CupertinoIcons.bluetooth,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: (_speechToText.isNotListening)
                                      ? _startListening
                                      : _stopListening,
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Colors.pink,
                                          Colors.purple
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      width: 70,
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: (_speechToText.isNotListening)
                                          ? Icon(
                                              CupertinoIcons.mic,
                                            )
                                          : Icon(CupertinoIcons.mic_off),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              child: JoysTickCustom(
                                listener: (details) async {
                                  setState(() {
                                    controll_x = (details.x * 100).ceil();
                                    controll_y = (details.y * 100).ceil();
                                  });
                                  print((controll_x * 2.55).toInt().toString() +
                                      '/' +
                                      (-1 * controll_y * 2.55)
                                          .toInt()
                                          .toString());
                                  if (isConnect()) {
                                    try {
                                      _connection!.output.add(
                                          convertStringToUint8List('m:' +
                                              (controll_x * 2.55)
                                                  .toInt()
                                                  .toString() +
                                              '/' +
                                              ((controll_y * -2.55).toInt())
                                                  .toString() +
                                              'n'));
                                      await _connection!.output.allSent;
                                    } catch (error) {
                                      //print(error);
                                    }
                                  }
                                },
                                onStickDragEnd: () async {
                                  if (isConnect()) {
                                    try {
                                      _connection!.output
                                          .add(convertStringToUint8List('m:'
                                                  '0' +
                                              '/' +
                                              '0' +
                                              'n'));
                                      await _connection!.output.allSent;
                                    } catch (error) {
                                      //print(error);
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   width: size.width * 0.05,
                  // ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 200,
                            height: 200,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: 200,
                                  height: 200,
                                  child: CustomPaint(
                                    painter: CustomSlider(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    child: CustomPaint(
                                      painter: CustomSlider(),
                                    ),
                                  ),
                                ),
                                ControllCircle(
                                  top: top_servo2,
                                  lefl: lefl_servo2,
                                  onUpdate: Controll_Circle2,
                                ),
                                ControllCircle(
                                  top: top_servo1,
                                  lefl: lefl_servo1,
                                  onUpdate: Controll_Circle1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                width: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
