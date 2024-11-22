import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

void printMessage(String message, {bool display = true, error}) {
  if (display) {
    log(message);
  }
  if (error != null) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(
      FlutterErrorDetails(
        exception: error.toString(),
        stack: error.stackTrace,
        library: error.requestOptions.path,
      ),
    );
  }
}
