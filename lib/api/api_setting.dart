
class ApiSettings{
  static const String _baseUrl = 'http://demo-api.mr-dev.tech/';
  static const String baseApiUrl = '${_baseUrl}api/';
  static const String readUser = '${baseApiUrl}users';
  static const String searchUser = '$readUser/search';
  static const String imageUser = '$readUser/1/images';
  static const String categories = '${baseApiUrl}categories';
  static const String product = '$categories/1/products';
}