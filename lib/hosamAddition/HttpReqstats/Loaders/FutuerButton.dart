// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:progress_state_button/iconed_button.dart';
// import 'package:progress_state_button/progress_button.dart';
// import '../httpStats.dart';

// /// A StatefulWidget that displays a button with various states (idle, loading, success, fail)
// /// and handles the associated HTTP request.
// class ApiFutureButton<T> extends StatefulWidget {
//   /// Function to handle the button press and initiate the HTTP request.
//   ///
//   final Future<void> Function(HDMHttpRequestsStates<T> states) onPress;

//   /// Iconed button for the loading state.
//   final IconedButton loading;

//   /// Iconed button for the idle state.
//   final IconedButton idle;

//   /// Iconed button for the success state.
//   final IconedButton success;

//   /// Iconed button for the fail state.
//   final IconedButton fail;

//   /// Text style for the button.
//   final TextStyle textStyle;

//   /// Optional callback for success state.
//   final Function(T result)? onSuccess;

//   /// Optional callback for error state.
//   final Function()? onError;

//   /// Optional callback for loading state.
//   final Function()? onLoading;

//   /// Optional callback for idle state.
//   final Function()? onIdle;

//   /// Optional form key to validate the form before making the request.
//   final GlobalKey<FormState>? formKey;

//   /// Button radius.
//   final double radius;

//   /// Button maximum width.
//   final double maxWidth;

//   /// Button height.
//   final double height;

//   ApiFutureButton({
//     Key? key,
//     required this.onPress,
//     this.loading = const IconedButton(text: "جار التحميل", color: Colors.deepPurple),
//     this.idle = const IconedButton(text: "اضف", icon: const Icon(Icons.add, color: Colors.cyan), color: Colors.white70),
//     this.success = const IconedButton(text: "نجاح", icon: const Icon(Icons.check_circle, color: Colors.white), color: Colors.green),
//     this.fail = const IconedButton(text: "فشل، أعد المحاولة", icon: const Icon(Icons.cancel, color: Colors.white), color: Colors.orange),
//     this.textStyle = const TextStyle(color: Colors.blue, fontSize: 20),
//     this.onSuccess,
//     this.onError,
//     this.onLoading,
//     this.onIdle,
//     this.formKey,
//     this.radius = 10.0,
//     this.maxWidth = 0,
//     this.height = 0,
//   }) : super(key: key);

//   /// Returns the corresponding button state based on the HTTP request state.
//   static ButtonState state(HDMHttpRequestsStatesEnum v) {
//     switch (v) {
//       case HDMHttpRequestsStatesEnum.success:
//       case HDMHttpRequestsStatesEnum.successButEmpty:
//         return ButtonState.success;
//       case HDMHttpRequestsStatesEnum.idle:
//         return ButtonState.idle;
//       case HDMHttpRequestsStatesEnum.loading:
//         return ButtonState.loading;
//       case HDMHttpRequestsStatesEnum.fail:
//         return ButtonState.fail;
//       default:
//         throw {"Unknown HDMHttpRequestsStatesEnum state"};
//     }
//   }

//   @override
//   _ApiFutureButtonState<T> createState() => _ApiFutureButtonState<T>();
// }

// class _ApiFutureButtonState<T> extends State<ApiFutureButton<T>> {
//   final HDMHttpRequestsStates<T> hdmHttpRequestsStates = HDMHttpRequestsStates<T>();

//   @override
//   void initState() {
//     super.initState();
//     hdmHttpRequestsStates.set = () => setState(() {});
//     hdmHttpRequestsStates.context = context;
//     hdmHttpRequestsStates.onSuccess = widget.onSuccess;
//     hdmHttpRequestsStates.onErr = widget.onError;
//     hdmHttpRequestsStates.onLoading = widget.onLoading;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ProgressButton.icon(
//       iconedButtons: {
//         ButtonState.idle: widget.idle,
//         ButtonState.loading: widget.loading,
//         ButtonState.fail: widget.fail,
//         ButtonState.success: widget.success,
//       },
//       textStyle: widget.textStyle,
//       radius: widget.height == 0 ? 10.0 : widget.radius,
//       maxWidth: widget.maxWidth == 0 ? MediaQuery.of(context).size.width * .7 : widget.maxWidth,
//       height: widget.height == 0 ? MediaQuery.of(context).size.width * .15 : widget.height,
//       onPressed: () async {
//         if (widget.formKey != null) {
//           if (widget.formKey!.currentState!.validate()) {
//             widget.formKey!.currentState!.save();
//             await widget.onPress(hdmHttpRequestsStates);
//           }
//         } else {
//           await widget.onPress(hdmHttpRequestsStates);
//         }
//       },
//       state: ApiFutureButton.state(hdmHttpRequestsStates.states),
//     );
//   }
// }
