class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = 'https://reqres.in/api';

  // receiveTimeout
  static const int receiveTimeout = 10000;

  // connectTimeout
  static const int connectionTimeout = 10000;

  static const String users = '/users';

  ///queries
  static const pageQuery = 'page';
  static const perPageQuery = 'per_page';
  static const userIdPath = '/userID';
}
