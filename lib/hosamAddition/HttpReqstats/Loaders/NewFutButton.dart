import 'package:flutter/material.dart';

import '../ErrorLogic.dart';
import 'FutureButton.dart';

/// A specialized button that handles API requests and displays different states.
/// This extends the generic FutureButton and adds API-specific functionality.
class ApiButton<h> extends FutureButton<h> {
  /// Creates an instance of ApiButton.
  ApiButton({Key? key, required Future<h> Function() requestFunction, required void Function(h response) onSuccess, ApiElevatedButton? successWidget, ApiElevatedButton? loadingWidget, ApiElevatedButton? errorWidget, bool Function() isReady = _defaultIsReady, ApiElevatedButton? idleNotReadyWidget, required ApiElevatedButton Function(ButtonStyle style) idleWidget, required ButtonStyle buttonStyle})
    : super(
        key: key,
        requestFunction: () => _wrapApiRequest(requestFunction),
        onSuccess: onSuccess,
        successWidget: successWidget,
        loadingWidget: loadingWidget,
        errorWidget: errorWidget,
        isReady: isReady,
        idleNotReadyWidget: idleNotReadyWidget,
        idleWidget: idleWidget,
        buttonStyle: buttonStyle,
        responseValidator: null, // We handle validation in the wrapper
      );

  static bool _defaultIsReady() {
    return true;
  }

  /// Static wrapper function to extract data from Response and validate
  static Future<T> _wrapApiRequest<T>(Future<T> Function() apiRequest) async {
    T response = await apiRequest();
    if (ApiErrorChecker.checkData(response)) {
      if (response == null) {
        throw Exception('Response data is null');
      }
      return response;
    } else {
      throw Exception('API response validation failed');
    }
  }
}
