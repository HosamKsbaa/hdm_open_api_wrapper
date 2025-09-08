import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:talker_flutter/talker_flutter.dart';

class ApiErrorChecker {
  static final _talker = TalkerFlutter.init();

  static bool checkResponse<T>(retrofit.HttpResponse<T> response) {
    _talker.debug("Checking response with status code: ${response.response.statusCode}");
    if (response.response.statusCode == 200) {
      var responseData = response.response.data;

      if (responseData is Map && responseData.containsKey('msg') && responseData.containsKey('send')) {
        _talker.debug("Response contains 'msg' and 'send' keys.");
        if (responseData['msg'] != 'ok' || responseData['send'] != 'ok') {
          // HDMMsg.showSnackBar(title: 'Notice', message: message, contentType: ContentType.warning);
          _talker.warning("Condition not met: msg='${responseData['msg']}' or send='${responseData['send']}'");
          return false;
        }
      } else if (responseData is Map && responseData.containsKey('msg') && responseData['msg'] != 'ok') {
        // HDMMsg.showSnackBar(title: 'Error', message: "Error in msg: ${responseData['msg']}", contentType: ContentType.failure);
        _talker.error("Error found in 'msg' key: ${responseData['msg']}");
        return false;
      }
    } else {
      String errorMessage = "Error: Status code is ${response.response.statusCode}. Body: ${response.response.data}";
      // HDMMsg.showSnackBar(title: 'API Error', message: errorMessage, contentType: ContentType.failure);
      _talker.error("API Error: Status code not 200. Error message: $errorMessage");
      return false;
    }
    _talker.debug("Response passed all checks.");
    return true;
  }
}
