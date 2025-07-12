import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import '../SnackBars/scaffoldMessengerKey.dart';
import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';

class ApiErrorChecker {
  static bool checkResponse<T>(retrofit.HttpResponse<T> response) {
    print("Checking response with status code: ${response.response.statusCode}");
    if (response.response.statusCode == 200) {
      var responseData = response.response.data;
      print("Response data received: $responseData");

      if (responseData is Map && responseData.containsKey('msg') && responseData.containsKey('send')) {
        print("Response contains 'msg' and 'send' keys.");
        if (responseData['msg'] != 'ok' || responseData['send'] != 'ok') {
          String message = "Message: ${responseData['msg']}, Send: ${responseData['send']}";
          HDMMsg.showSnackBar(title: 'Notice', message: message, contentType: ContentType.warning);
          print("Condition not met: msg='${responseData['msg']}' or send='${responseData['send']}'");
          return false;
        }
      } else if (responseData is Map && responseData.containsKey('msg') && responseData['msg'] != 'ok') {
        HDMMsg.showSnackBar(title: 'Error', message: "Error in msg: ${responseData['msg']}", contentType: ContentType.failure);
        print("Error found in 'msg' key: ${responseData['msg']}");
        return false;
      }
    } 
    else {
      String errorMessage = "Error: Status code is ${response.response.statusCode}. Body: ${response.response.data}";
      HDMMsg.showSnackBar(title: 'API Error', message: errorMessage, contentType: ContentType.failure);
      print("API Error: Status code not 200. Error message: $errorMessage");
      return false;
    }
    print("Response passed all checks.");
    return true;
  }
}
