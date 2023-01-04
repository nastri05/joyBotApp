import 'package:flutter/material.dart';
import 'package:untitled1/native_screen/native_add.dart';

class NativeScreen extends StatefulWidget {
  const NativeScreen({super.key});

  // final WebSocketChannel channel;

  @override
  State<NativeScreen> createState() => _NativeScreenState();
}

class _NativeScreenState extends State<NativeScreen> {
  // int _counter = 0;
  // Uint8List? bytes;
  bool check = true;
  Image? img;
  // Uint8List? imageData;
  // var receivePort = ReceivePort();

  @override
  void initState() {
    // receivePort.listen((message) {
    //   print(message);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('1+2 = ${nativeAdd(1, 2)}'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              width: size.width,
              height: size.height,
              // child: StreamBuilder(
              //   stream: widget.channel.stream,
              //   builder: (context, snapshot) {
              //     if (imageData == null && !snapshot.hasData) {
              //       return Center(
              //         child: CircularProgressIndicator(
              //           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              //         ),
              //       );
              //     } else {
              //       imageData = snapshot.data;
              //       return Image.memory(
              //         imageData!,
              //         gaplessPlayback: true,
              //         fit: BoxFit.cover,
              //       );
              //     }
              //   },
              // ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // CreateNewIsolate(receivePort, imageData!);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // void CreateNewIsolate(ReceivePort receivePort, Uint8List image_1) {
  //   RequiredArgs requiredArgs =
  //   RequiredArgs(sendPort: receivePort.sendPort, image: image_1);
  //   Isolate.spawn(taskRunner, requiredArgs);
  // }

  // static void taskRunner(RequiredArgs args) {
  //   var image = args.image;
  //   var sendPort = args.sendPort;
  //   Pointer<Uint32> s = malloc.allocate(1);
  //   s[0] = image.length;
  //   final pointer = malloc<Uint8>(image.length);
  //   for (int i = 0; i < image.length; i++) {
  //     pointer[i] = image[i];
  //   }
  //   Float32List size = sizeImage(pointer, s).asTypedList(2);
  //
  //   malloc.free(pointer);
  //   malloc.free(s);
  //   sendPort.send(size.toList());
  //   // });
  // }
}
