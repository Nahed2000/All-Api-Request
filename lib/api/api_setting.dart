class ApiSettings {
  static const String _baseUrl = 'http://demo-api.mr-dev.tech/';
  static const String baseApiUrl = '${_baseUrl}api/';
  static const String readUser = '${baseApiUrl}users';
  static const String login = '${baseApiUrl}students/auth/login';
  static const String logout = '${baseApiUrl}students/auth/logout';
  static const String register = '${baseApiUrl}students/auth/register';
  static const String forget = '${baseApiUrl}students/auth/forget-password';
  static const String resetPassword = '${baseApiUrl}students/auth/reset-password';
  static const String searchUser = '$readUser/search';
  static const String imageUser = '$readUser/1/images';
  static const String categories = '${baseApiUrl}categories';
  static const String product = '$categories/1/products';
  static const String imageStudent = '${baseApiUrl}student/images/{id}';
  static const String task = '${baseApiUrl}tasks/{id}';
}
