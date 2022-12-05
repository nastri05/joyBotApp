import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingApp {
  static Future Loading_Login(BuildContext context, Future future) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          future.whenComplete(() {
            Navigator.of(ctx).pop();
          });
          return Builder(builder: (context) {
            return Container(
              child: Center(
                child: SpinKitRing(
                  color: Colors.pink,
                  size: 50.0,
                ),
              ),
            );
          });
        });
    return future;
  }

  static Future Loading_Mic(BuildContext context, Future future) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          future.whenComplete(() async {
            //await Future.delayed(Duration(milliseconds: 1000));
            Navigator.of(ctx).pop();
          });
          return Builder(builder: (context) {
            return Container(
              child: Center(
                child: Stack(children: <Widget>[
                  Center(
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Icon(
                        Icons.mic,
                        size: 30,
                      ),
                    ),
                  ),
                  SpinKitRing(
                    color: Colors.pink,
                    size: 80.0,
                  ),
                ]),
              ),
            );
          });
        });
    return future;
  }
}
