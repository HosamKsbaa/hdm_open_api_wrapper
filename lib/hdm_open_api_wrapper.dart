import 'package:flutter/material.dart';
import 'hosamAddition/HttpReqstats/ErrorLogic.dart';
export 'package:dio/dio.dart' hide Headers;
export 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
export 'package:overlay_support/overlay_support.dart';
export 'hosamAddition/HttpReqstats/httpStats.dart';
export 'hosamAddition/HttpReqstats/ErrorLogic.dart';
export 'hosamAddition/SnackBars/scaffoldMessengerKey.dart';
export 'hosamAddition/Sounds/sounds_controller.dart';
export 'hosamAddition/Converters/Converters.dart';
export 'hosamAddition/HttpReqstats/Loaders/pageWIthMore.dart';
export 'hosamAddition/HttpReqstats/Loaders/SinglePage.dart';
export 'hosamAddition/HttpReqstats/Loaders/FutureButton.dart';

/// A Calculator.
class HOAW {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  /// Sets a custom logger function to be used throughout the app.
  static void setLogger(void Function(String message, HdmLoggerMode mode, StackTrace? trace) logger) {
    HdmLogger.setLogger(logger);
  }
}
