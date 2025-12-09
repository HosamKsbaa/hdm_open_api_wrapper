import 'package:flutter/material.dart';
import 'hosamAddition/HttpReqstats/error_logic.dart';
export 'package:dio/dio.dart' hide Headers;
export 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
export 'package:overlay_support/overlay_support.dart';
export 'hosamAddition/HttpReqstats/http_stats.dart';
export 'hosamAddition/HttpReqstats/error_logic.dart';
export 'hosamAddition/SnackBars/scaffold_messenger_key.dart';
export 'hosamAddition/Sounds/sounds_controller.dart';
export 'hosamAddition/Converters/converters.dart';
export 'hosamAddition/HttpReqstats/Loaders/page_with_more.dart';
export 'hosamAddition/HttpReqstats/Loaders/single_page.dart';
export 'hosamAddition/HttpReqstats/Loaders/future_button.dart';

/// A Calculator.
class HOAW {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  /// Sets a custom logger function to be used throughout the app.
  static void setLogger(
    void Function(String message, HdmLoggerMode mode, StackTrace? trace) logger,
  ) {
    HdmLogger.setLogger(logger);
  }
}
