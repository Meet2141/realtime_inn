import 'package:flutter/material.dart';

class AppUtils {
  static Future futureDelay({int? seconds, required VoidCallback afterDelay}) async {
    await Future.delayed(Duration(seconds: seconds ?? 2)).then((value) {
      afterDelay();
    });
  }
}
