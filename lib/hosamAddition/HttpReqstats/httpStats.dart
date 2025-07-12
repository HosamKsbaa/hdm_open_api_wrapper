import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

enum HDMHttpRequestsStatesEnum { idle, loading, success, fail, successButEmpty }

class HDMHttpRequestsStates<T> {
  BuildContext? context;
  Function(T result)? onSuccess;
  Function()? onErr;
  Function()? onLoading;
  Function()? onIdleAgain;
  bool deBug = false;
  HDMHttpRequestsStates(
      {this.onSuccess, this.onErr, this.onLoading, this.onIdleAgain});

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
    if (deBug) print("Set to idle");
    _set();
  }

  Future<void> setErr(String message) async {
    if (this.onErr != null) {
      this.onErr!();
    }
    print("Set to fail");
    states = HDMHttpRequestsStatesEnum.fail;
    if (deBug) print("Set to fail");
    _set();
    _showErrorToast(message);
  }

  void _showErrorToast(String message) {
    toast(message, duration: Duration(seconds: 10));
  }

  void setLoading() {
    states = HDMHttpRequestsStatesEnum.loading;
    if (deBug) print("Set to loading");
    _set();
  }

  void setSuccess(T result) {
    if (this.onSuccess != null) {
      this.onSuccess!(result);
    }
    states = HDMHttpRequestsStatesEnum.success;
    if (deBug) print("Set to success");
    _set();
  }
}
