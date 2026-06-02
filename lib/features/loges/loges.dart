import 'package:flutter/foundation.dart';

abstract final class Loges {
  static void log(String message, [String? header]) {
    if (kDebugMode) {
      debugPrint(
        '\n'
        '\u001B[32m ╔════════════════════ $header ═════════════════ \n \u001B[0m'
        '\u001B[22m $message \u001B[0m'
        '\u001B[32m ╚═════════════════════════════════════════════ \n  \u001B[0m'
        '\n',
      );
    }
  }

  static void flutterError(FlutterErrorDetails details) {
    if (kDebugMode) {
      debugPrint(
        '\u001B[31m Stack trace : ${details.stack} \u001B[0m'
        '\u001B[31m exception : ${details.exception} \u001B[0m'
        '\u001B[31m informationCollector : ${details.informationCollector} \u001B[0m',
      );
    }
  }

  static void platformError(Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      debugPrint(
        '\u001B[31m Stack trace : $stackTrace \u001B[0m'
        '\u001B[31m exception : $error \u001B[0m',
      );
    }
  }
}
