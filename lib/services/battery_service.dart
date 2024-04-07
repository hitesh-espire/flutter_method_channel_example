import 'dart:developer';

import 'package:flutter/services.dart';

class BatterService {
  static const platform = MethodChannel('com.example.battery');

  static Future<int> getBatteryLevel() async {
    try {
      final int batteryLevel = await platform.invokeMethod(
        'getBatteryLevel',
      );
      return batteryLevel;
    } on PlatformException catch (e) {
      log("Failed to get battery level: ${e.message}.");
      return -1;
    }
  }
}
