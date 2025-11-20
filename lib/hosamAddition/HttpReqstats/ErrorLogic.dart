import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ApiErrorChecker {
  static final _talker = TalkerFlutter.init();

  static bool checkResponse<T>(Response<T> response) {
    // Accept any status code from 200 to 300 (successful responses)
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      var responseData = response.data;

      if (responseData is Map && responseData.containsKey('msg') && responseData.containsKey('send')) {
        _talker.debug("Response contains 'msg' and 'send' keys.");
        if (responseData['msg'] != 'ok' || responseData['send'] != 'ok') {
          // hdmMsg.showSnackBar(title: 'Notice', message: message, contentType: ContentType.warning);
          // hdmMsg.showSnackBar(title: 'Notice', message: message, contentType: ContentType.warning);
          _talker.warning("Condition not met: msg='${responseData['msg']}' or send='${responseData['send']}'");
          return false;
        }
      } else if (responseData is Map && responseData.containsKey('msg') && responseData['msg'] != 'ok') {
        // hdmMsg.showSnackBar(title: 'Error', message: "Error in msg: ${responseData['msg']}", contentType: ContentType.failure);
        // hdmMsg.showSnackBar(title: 'Error', message: "Error in msg: ${responseData['msg']}", contentType: ContentType.failure);
        _talker.error("Error found in 'msg' key: ${responseData['msg']}");
        return false;
      }
    } else {
      String errorMessage = "Error: Status code is ${response.statusCode}. Body: ${response.data}";
      // hdmMsg.showSnackBar(title: 'API Error', message: errorMessage, contentType: ContentType.failure);
      _talker.error("API Error: Status code not in 200-299 range. Error message: $errorMessage");
      return false;
    }
    return true;
  }
}
