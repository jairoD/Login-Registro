import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alerts {
  static succesFlushbar(BuildContext context, String title, String message) {
    Flushbar(
      title: title,
      message: message,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
      icon: Icon(
        Icons.done,
        color: Colors.white,
      ),
    )..show(context);
  }

  static errorFlushbar(BuildContext context, String title, String message) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      title: title,
      message: message,
      backgroundColor: Colors.red,
      icon: Icon(
        Icons.error,
        color: Colors.white,
      ),
      duration: Duration(seconds: 3),
    )..show(context);
  }

  static loading(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: new Container(
                  alignment: FractionalOffset.center,
                  height: 80.0,
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator()),
            ));
  }
}
