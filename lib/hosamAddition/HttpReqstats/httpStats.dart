import 'dart:ui';
import 'package:flutter/material.dart';
import 'ErrorLogic.dart';

enum HDMHttpRequestsStatesEnum { idle, loading, success, fail, successButEmpty }

class HDMHttpRequestsStates<T> {
  BuildContext? context;
  Function(T result)? onSuccess;
  Function()? onErr;
  Function()? onLoading;
  Function()? onIdleAgain;
  bool deBug = false;
  HDMHttpRequestsStates({this.onSuccess, this.onErr, this.onLoading, this.onIdleAgain});

  late HDMHttpRequestsStatesEnum states = HDMHttpRequestsStatesEnum.idle;
  VoidCallback? set;

  void _set() {
    if (set != null) {
      set!();
    }
  }

  bool checkIfSetToIdle() => states == HDMHttpRequestsStatesEnum.idle;
  bool checkIfSetToErr() => states == HDMHttpRequestsStatesEnum.fail;
  bool checkIfSetToLoading() => states == HDMHttpRequestsStatesEnum.loading;
  bool checkIfSetTOSuccess() => states == HDMHttpRequestsStatesEnum.success;

  void setIdle() {
    if (this.onIdleAgain != null) {
      this.onIdleAgain!();
    }
    states = HDMHttpRequestsStatesEnum.idle;
    if (deBug) HdmLogger.log("Set to idle", HdmLoggerMode.debug);
    _set();
  }

  Future<void> setErr(String message, StackTrace stackTrace) async {
    if (this.onErr != null) {
      this.onErr!();
    }
    HdmLogger.log("Set to fail", HdmLoggerMode.error);
    states = HDMHttpRequestsStatesEnum.fail;
    if (deBug) HdmLogger.log("Set to fail", HdmLoggerMode.error);
    _set();
    HdmLogger.log(message, HdmLoggerMode.error, stackTrace);
    // _showErrorToast(message);
  }

  // void _showErrorToast(String message) {
  //   toast(message, duration: Duration(seconds: 10));
  // }

  void setLoading() {
    states = HDMHttpRequestsStatesEnum.loading;
    if (deBug) HdmLogger.log("Set to loading", HdmLoggerMode.debug);
    _set();
  }

  void setSuccess(T result) {
   
    if (result.runtimeType != T) {
      HdmLogger.log("Warning: HDMHttpRequestsStates mismatch. Expected $T, got ${result.runtimeType}", HdmLoggerMode.warning);
    }
    if (this.onSuccess != null) {
      this.onSuccess!(result);
    }
    states = HDMHttpRequestsStatesEnum.success;
    if (deBug) HdmLogger.log("Set to success", HdmLoggerMode.debug);
    _set();
  }
}
