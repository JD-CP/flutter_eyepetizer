import 'package:logger/logger.dart';

class LoggerUtil {
  static LoggerUtil _loggerUtil;

  var _logger;
  var _loggerNoStack;

  LoggerUtil() {
    _logger = Logger(
      printer: PrettyPrinter(),
    );

    _loggerNoStack = Logger(
      printer: PrettyPrinter(methodCount: 0),
    );
  }

  static LoggerUtil instance() {
    if (null == _loggerUtil) {
      _loggerUtil = LoggerUtil();
    }
    return _loggerUtil;
  }

  d(debugLog) {
    _logger.d(debugLog);
  }

  i(infoLog) {
    _logger.i(infoLog);
  }

  w(warnLog) {
    _loggerNoStack.w(warnLog);
  }

  e(errorLog) {
    _logger.e(errorLog);
  }

  v(verboseLog) {
    _loggerNoStack.v(verboseLog);
  }
}
