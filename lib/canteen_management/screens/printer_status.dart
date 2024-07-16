import 'package:flutter/services.dart';

import '../../main.dart';

class PrinterStatus {
  static const MethodChannel _channel = MethodChannel('printer_status');

  static Future<bool> checkPrinterRollerStatus() async {
    try {
      final bool status = await _channel.invokeMethod('checkPrinterStatus');
      return status;
    } on PlatformException catch (e) {
      logger.i("Failed to check printer status: '${e.message}'.");
      return false;
    }
  }
}
