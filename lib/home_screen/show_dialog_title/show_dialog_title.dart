import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowDialogTitle {
  static Future MyShowDialogTitle(
      BuildContext context, String title, String title2) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: <Widget>[
                Text(title),
                Text(title2),
              ],
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop("");
                  },
                  child: Text('OK')),
            )
          ],
        );
      },
    );
  }

  static void MyShowTitle(
      BuildContext context, String title, String title2) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: <Widget>[
                Text(title),
                SizedBox(
                  height: 10,
                ),
                Text(title2),
              ],
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('OK')),
            )
          ],
        );
      },
    );
  }

  static Future ShowLoi(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Lỗi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Không nghe rõ, hãy thử lại'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<dynamic> GetUrl(BuildContext context, String data) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        var url_config = data;
        var _controller = TextEditingController();
        _controller.text = url_config;
        return AlertDialog(
            content: Container(
          height: 150,
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _controller,
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      margin: EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Icon(CupertinoIcons.antenna_radiowaves_left_right),
                    ),
                    hintText: 'URL',
                    contentPadding: EdgeInsets.only(top: 5),
                    hintStyle: TextStyle(
                      color: Colors.green.withOpacity(0.9),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    child: Icon(Icons.upload),
                    onPressed: () {
                      print(_controller.text);
                      Navigator.pop(context, _controller.text);
                    })
              ],
            ),
          ),
        ));
      },
    );
  }
}
