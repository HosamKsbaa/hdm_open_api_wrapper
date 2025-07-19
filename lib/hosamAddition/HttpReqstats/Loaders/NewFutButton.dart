import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';

import '../../SnackBars/scaffoldMessengerKey.dart';
import '../ErrorLogic.dart';

/// A StatefulWidget that handles API requests and displays different states (idle, loading, success, error) for a button.
class ApiButton<h> extends StatefulWidget {
  /// Function to make the API request.
  final Future<HttpResponse<h>> Function() requestFunction;

  /// Callback for when the request is successful.
  final void Function(h response) onSuccess;
  late bool Function() isitReady;

  /// Widget to show on success.
  final Widget successWidget;

  /// Widget to show while loading.
  final Widget loadingWidget;

  /// Widget to show when an error occurs.
  final Widget errorWidget;

  /// Widget to show when an error occurs.
  final Widget idleNotReadyWidget;

  /// Initial widget before any action (idle state).
  final Widget Function(ButtonStyle s) idleWidget;

  /// Optional: Style for the button.
  ///           buttonStyle: ElevatedButton.styleFrom(
  ///             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
  ///              shape: RoundedRectangleBorder(
  ///                borderRadius: BorderRadius.circular(16),
  ///              ),
  ///            ),
  final ButtonStyle buttonStyle;

  /// Creates an instance of ApiButton.
  ApiButton({Key? key, required this.requestFunction, required this.onSuccess, Widget? successWidget, Widget? loadingWidget, Widget? errorWidget, this.isitReady = IsReady, Widget? idleNotReadyWidget, required this.idleWidget, required this.buttonStyle})
    : successWidget = successWidget ?? _defaultSuccessButton(buttonStyle),
      loadingWidget = loadingWidget ?? _defaultLoadingButton(buttonStyle),
      errorWidget = errorWidget ?? _defaultErrorButton(buttonStyle),
      idleNotReadyWidget = idleNotReadyWidget ?? _defaultideleNotReady(buttonStyle),

      // isitReady = isitReady ?? IsReady(),
      super(key: key);

  static bool IsReady() {
    return true;
  }

  static Widget _defaultSuccessButton(ButtonStyle buttonStyle) {
    return ElevatedButton(
      style: buttonStyle.copyWith(backgroundColor: MaterialStateProperty.all(Colors.green)),
      onPressed: null,
      child: const Text('تم بنجاح', style: TextStyle(color: Colors.white)),
    );
  }

  static Widget _defaultLoadingButton(ButtonStyle buttonStyle) {
    return ElevatedButton(
      style: buttonStyle.copyWith(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),
      onPressed: null,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2)),
          SizedBox(width: 10),
          Text('جار التحميل...', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  static Widget _defaultErrorButton(ButtonStyle buttonStyle) {
    return ElevatedButton(
      style: buttonStyle.copyWith(backgroundColor: MaterialStateProperty.all(Colors.red)),
      onPressed: null,
      child: const Text('حدث خطأ، حاول مرة أخرى', style: TextStyle(color: Colors.white)),
    );
  }

  static Widget _defaultideleNotReady(ButtonStyle buttonStyle) {
    return ElevatedButton(
      style: buttonStyle.copyWith(backgroundColor: MaterialStateProperty.all(Colors.grey)),
      onPressed: null,
      child: const Text('رجاء وفر جميع البيانات', style: TextStyle(color: Colors.white)),
    );
  }

  @override
  _ApiButtonState<h> createState() => _ApiButtonState<h>();
}

enum ApiButtonState { loading, success, error, idle }

class _ApiButtonState<h> extends State<ApiButton<h>> {
  ApiButtonState states = ApiButtonState.idle;

  late h _responseObj;

  void _makeRequest() async {
    setState(() {
      states = ApiButtonState.loading;
    });

    try {
      HttpResponse<h> response = await widget.requestFunction(); // Ensure the response type aligns with your API response
      if (ApiErrorChecker.checkResponse(response)) {
        // Using the error checker to validate response
        _responseObj = response.data; // Use response.data instead of response.response.data

        setState(() {
          states = ApiButtonState.success;
        });
        widget.onSuccess(_responseObj!); // Call the success callback
      } else {
        print("Response check failed. Data did not pass validation.");
        setState(() {
          states = ApiButtonState.error;
        });
      }
    } on DioException catch (error) {
      print("An exception occurred during API call: $error");
      setState(() {
        states = ApiButtonState.error;
      });
      HDMMsg.showSnackBar(title: 'API Error', message: error.response.toString(), contentType: ContentType.failure);
    } catch (error) {
      print("An exception occurred during API call: $error");
      HDMMsg.showSnackBar(title: 'API Error', message: error.toString(), contentType: ContentType.failure);

      setState(() {
        states = ApiButtonState.error;
      });
    }
  }

  Widget build(BuildContext context) {
    Widget _buildButton() {
      switch (states) {
        case ApiButtonState.loading:
          return widget.loadingWidget;
        case ApiButtonState.error:
          return GestureDetector(onTap: _makeRequest, child: widget.errorWidget);
        case ApiButtonState.success:
          return widget.successWidget;

        case ApiButtonState.idle:
        default:
          if (!widget.isitReady()) {
            return widget.idleNotReadyWidget;
          }
          return GestureDetector(onTap: _makeRequest, child: widget.idleWidget(widget.buttonStyle));
      }
    }

    return SizedBox(child: _buildButton(), width: double.infinity);
  }
}
