import 'package:talker_flutter/talker_flutter.dart';

class ApiErrorChecker {
  static final _talker = TalkerFlutter.init();

  static bool checkData(dynamic responseData) {
    // Check if data is valid based on 'msg' and 'send' keys
    if (responseData is Map && responseData.containsKey('msg') && responseData.containsKey('send')) {
      _talker.debug("Response contains 'msg' and 'send' keys.");
      if (responseData['msg'] != 'ok' || responseData['send'] != 'ok') {
        _talker.warning("Condition not met: msg='${responseData['msg']}' or send='${responseData['send']}'");
        return false;
      }
    } else if (responseData is Map && responseData.containsKey('msg') && responseData['msg'] != 'ok') {
      _talker.error("Error found in 'msg' key: ${responseData['msg']}");
      return false;
    }
    return true;
  }
}
