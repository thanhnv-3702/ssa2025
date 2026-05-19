class BaseConst {
  BaseConst._();

  static const String defaultLangue = 'en';
  static const String fontBold = 'Bold';
  static const String fontSemiBold = 'SemiBold';
  static const String fontRegular = 'Regular';
  static const String fontMedium = 'Medium';
  static const String fontLight = 'Light';

  //error system
  static const String systemError = 'SystemError';
  static const String unknownError = 'UnknownError';
  static const Map<String, dynamic> systemErrorData = {
    'code': '400',
    'message': 'System error, try again later',
    'message_id': ['app_error_01'],
    'data': '{}',
  };

  static List<String> excludedAPIs = ['/api/login', '/register/profile'];
  static String apiRefreshToken = '/api/refresh-token';
}
