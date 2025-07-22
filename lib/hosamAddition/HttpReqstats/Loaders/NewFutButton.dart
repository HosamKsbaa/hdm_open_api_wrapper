import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';

import '../ErrorLogic.dart';
import 'FutureButton.dart';

/// A specialized button that handles API requests (HttpResponse<h>) and displays different states.
/// This extends the generic FutureButton and adds API-specific functionality.
class ApiButton<h> extends FutureButton<h> {
  /// Creates an instance of ApiButton.
  ApiButton({Key? key, required Future<HttpResponse<h>> Function() requestFunction, required void Function(h response) onSuccess, Widget? successWidget, Widget? loadingWidget, Widget? errorWidget, bool Function() isReady = _defaultIsReady, Widget? idleNotReadyWidget, required Widget Function(ButtonStyle style) idleWidget, required ButtonStyle buttonStyle})
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

  /// Static wrapper function to extract data from HttpResponse and validate
  static Future<T> _wrapApiRequest<T>(Future<HttpResponse<T>> Function() apiRequest) async {
    HttpResponse<T> response = await apiRequest();
    if (ApiErrorChecker.checkResponse(response)) {
      return response.data;
    } else {
      throw Exception('API response validation failed');
    }
  }
}
