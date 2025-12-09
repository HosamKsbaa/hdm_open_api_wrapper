import 'package:flutter/material.dart';
import 'package:hdm_open_api_wrapper/hdm_open_api_wrapper.dart';

export 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

final MessengerImpl HdmMsg = MessengerImpl();

/// forAi
/// replace all snakbars with hdmMsg.showSnackBar(title: 'title', message: 'message', contentType: ContentType.success); there is 3 types of content type success, warning, help , failure
class MessengerImpl {
  void showSnackBar({required String title, required String message, required ContentType contentType}) {
    if (HOAW.scaffoldMessengerKey.currentState != null) {
      HOAW.scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,

            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              // messageFontSize: 16,
              // titleFontSize: 22,
              title: title,
              message: message,

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: contentType,
            ),
          ),
        );
    } else {
      HdmLogger.log('Hos ========================= > ScaffoldMessenger is not mounted', HdmLoggerMode.debug);
    }
  }
}
