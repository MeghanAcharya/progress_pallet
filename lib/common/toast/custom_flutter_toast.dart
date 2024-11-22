import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:progresspallet/extension/app_extensions.dart';

class CustomFlutterToast {
  static Future<bool?> showToast(
    String message, {
    bool isError = false,
    ToastGravity? gravity,
  }) {
    return Fluttertoast.showToast(
      msg: message.toPascalCase().replaceAll("_", " "),
      toastLength: Toast.LENGTH_LONG, // Will be long on Android 3.5 second
      gravity: gravity ?? ToastGravity.CENTER,
      timeInSecForIosWeb:
          5, // Increase this value to make it last longer on iOS and Web
      // backgroundColor: isError ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
