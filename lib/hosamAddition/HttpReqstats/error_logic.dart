enum HdmLoggerMode { debug, warning, error }

class HdmLogger {
  static void Function(String message, HdmLoggerMode mode, StackTrace? trace)? _logger;

  static void setLogger(void Function(String message, HdmLoggerMode mode, StackTrace? trace) function) {
    _logger = function;
  }

  static void log(String message, HdmLoggerMode mode, [StackTrace? trace]) {
    if (_logger != null) {
      _logger!(message, mode, trace);
    } else {
      throw Exception("HdmLogger not initialized! Call HOAW.setLogger before usage.");
    }
  }
}
