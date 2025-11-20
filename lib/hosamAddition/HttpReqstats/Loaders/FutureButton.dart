import 'package:flutter/material.dart';

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
  final ApiButtonItem? successWidget;

  /// Widget to show while loading.
  final ApiButtonItem? loadingWidget;

  /// Widget to show when an error occurs.
  final ApiButtonItem? errorWidget;

  /// Widget to show when not ready.
  final ApiButtonItem? idleNotReadyWidget;

  /// Initial widget before any action (idle state).
  final ApiButtonItem Function(ButtonStyle style) idleWidget;

  /// Style for the button.
  final ButtonStyle buttonStyle;

  /// Creates an instance of FutureButton.
  const ApiButton({Key? key, required this.requestFunction, required this.onSuccess, this.isReady = _defaultIsReady, this.responseValidator, this.successWidget, this.loadingWidget, this.errorWidget, this.idleNotReadyWidget, required this.idleWidget, required this.buttonStyle}) : super(key: key);

  static bool _defaultIsReady() {
    return true;
  }

  @override
  State<ApiButton<T>> createState() => _ApiButtonState<T>();
}

enum FutureButtonState { idle, loading, success, error }

class _ApiButtonState<T> extends State<ApiButton<T>> {
  FutureButtonState states = FutureButtonState.idle;

  @override
  Widget build(BuildContext context) {
    if (!widget.isReady()) {
      return widget.idleNotReadyWidget ?? ElevatedButton(onPressed: null, style: widget.buttonStyle, child: const Text("Not Ready"));
    }

    switch (states) {
      case FutureButtonState.idle:
        return widget.idleWidget(widget.buttonStyle);
      case FutureButtonState.loading:
        return widget.loadingWidget ??
            ApiButtonItem(
              style: widget.buttonStyle,
              child: const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
            );
      case FutureButtonState.success:
        return widget.successWidget ??
            ElevatedButton(
              onPressed: () => _handlePress(),
              style: widget.buttonStyle.copyWith(backgroundColor: MaterialStateProperty.all(Colors.green)),
              child: const Icon(Icons.check, color: Colors.white),
            );
      case FutureButtonState.error:
        return widget.errorWidget ??
            ElevatedButton(
              onPressed: () => _handlePress(),
              style: widget.buttonStyle.copyWith(backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: const Icon(Icons.error, color: Colors.white),
            );
    }
  }

  Future<void> _handlePress() async {
    setState(() {
      states = FutureButtonState.loading;
    });

    try {
      T response = await widget.requestFunction();

      bool isValid = true;
      if (widget.responseValidator != null) {
        isValid = widget.responseValidator!(response);
      }

      if (isValid) {
        setState(() {
          states = FutureButtonState.success;
        });
        widget.onSuccess(response);

        // Reset to idle after a delay
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              states = FutureButtonState.idle;
            });
          }
        });
      } else {
        print("Response validation failed.");
        setState(() {
          states = FutureButtonState.error;
        });
      }
    } catch (error, stackTrace) {
      print("An exception occurred during Future call: $error");
      print("Trace: $stackTrace");

      setState(() {
        states = FutureButtonState.error;
      });
    }
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
