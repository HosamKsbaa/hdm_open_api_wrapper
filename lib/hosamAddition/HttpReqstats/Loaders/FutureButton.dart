import 'package:flutter/material.dart';
import 'package:hdm_open_api_wrapper/hdm_open_api_wrapper.dart';

/// A StatefulWidget that handles any Future requests and displays different states (idle, loading, success, error) for a button.
/// This is the parent/generic class that can handle any type of Future operation.
class ApiButton<T> extends StatefulWidget {
  /// Function to make the Future request.
  final Future<T> Function() requestFunction;

  /// Callback for when the request is successful.
  final void Function(T response) onSuccess;

  /// Function to check if the button is ready to be pressed.
  final bool Function() isReady;

  /// Function to validate the response (optional).
  final bool Function(T response)? responseValidator;

  /// Widget to show on success.
  final Widget successWidget;

  /// Widget to show while loading.
  final Widget loadingWidget;

  /// Widget to show when an error occurs.
  final Widget errorWidget;

  /// Widget to show when not ready.
  final Widget idleNotReadyWidget;

  /// Initial widget before any action (idle state).
  final Widget Function(ButtonStyle style) idleWidget;

  /// Optional: Style for the button.
  final ButtonStyle buttonStyle;

  /// Reset functionality - if true, button will reset to idle after 5 seconds on success
  final bool? resetAfterSuccess;

  /// Creates an instance of FutureButton.
  ApiButton({Key? key, required this.requestFunction, required this.onSuccess, Widget? successWidget, Widget? loadingWidget, Widget? errorWidget, this.isReady = _defaultIsReady, Widget? idleNotReadyWidget, required this.idleWidget, required this.buttonStyle, this.responseValidator, this.resetAfterSuccess})
    : successWidget = successWidget ?? _defaultSuccessButton(buttonStyle, resetAfterSuccess),
      loadingWidget = loadingWidget ?? _defaultLoadingButton(buttonStyle),
      errorWidget = errorWidget ?? _defaultErrorButton(buttonStyle),
      idleNotReadyWidget = idleNotReadyWidget ?? _defaultIdleNotReady(buttonStyle),
      super(key: key);

  static bool _defaultIsReady() {
    return true;
  }

  static Widget _defaultSuccessButton(ButtonStyle buttonStyle, [bool? resetAfterSuccess]) {
    final message = resetAfterSuccess == true ? 'تم الإرسال' : 'تم بنجاح';
    return ElevatedButton(
      style: buttonStyle.copyWith(backgroundColor: MaterialStateProperty.all(Colors.green)),
      onPressed: null,
      child: Text(message, style: const TextStyle(color: Colors.white)),
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

  static Widget _defaultIdleNotReady(ButtonStyle buttonStyle) {
    return ElevatedButton(
      style: buttonStyle.copyWith(backgroundColor: MaterialStateProperty.all(Colors.grey)),
      onPressed: null,
      child: const Text('رجاء وفر جميع البيانات', style: TextStyle(color: Colors.white)),
    );
  }

  @override
  _ApiButtonState<T> createState() => _ApiButtonState<T>();
}

enum FutureButtonState { loading, success, error, idle }

class _ApiButtonState<T> extends State<ApiButton<T>> {
  FutureButtonState states = FutureButtonState.idle;
  late T _responseObj;

  void _makeRequest() async {
    setState(() {
      states = FutureButtonState.loading;
    });

    try {
      T response = await widget.requestFunction();

      // Check if response is valid (if validator is provided)
      bool isValid = widget.responseValidator?.call(response) ?? true;

      if (isValid) {
        _responseObj = response;
        setState(() {
          states = FutureButtonState.success;
        });
        widget.onSuccess(_responseObj);
      } else {
        setState(() {
          states = FutureButtonState.error;
        });
      }
    } on DioException catch (error) {

      setState(() {
        states = FutureButtonState.error;
      });
    } catch (error, stackTrace) {


      setState(() {
        states = FutureButtonState.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildButton() {
      switch (states) {
        case FutureButtonState.loading:
          return widget.loadingWidget;
        case FutureButtonState.error:
          return GestureDetector(onTap: _makeRequest, child: widget.errorWidget);
        case FutureButtonState.success:
          // If reset is enabled, make success state clickable to retry
          if (widget.resetAfterSuccess == true) {
            return GestureDetector(onTap: _makeRequest, child: widget.successWidget);
          }
          return widget.successWidget;
        case FutureButtonState.idle:
          if (!widget.isReady()) {
            return widget.idleNotReadyWidget;
          }
          return GestureDetector(onTap: _makeRequest, child: widget.idleWidget(widget.buttonStyle));
      }
    }

    return SizedBox(child: _buildButton(), width: double.infinity);
  }
}

class ApiButtonItem extends StatelessWidget {
  final VoidCallback? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final MaterialStatesController? statesController;
  final Widget? child;

  const ApiButtonItem({Key? key, this.onHover, this.onFocusChange, this.style, this.focusNode, this.autofocus = false, this.clipBehavior = Clip.none, this.statesController, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: null, onLongPress: null, onHover: null, onFocusChange: onFocusChange, style: style, focusNode: focusNode, autofocus: autofocus, clipBehavior: clipBehavior, statesController: statesController, child: child);
  }
}
