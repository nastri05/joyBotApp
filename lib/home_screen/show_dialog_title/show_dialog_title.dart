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
}
