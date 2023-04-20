class ApiRoutes {
  static const String _baseUrl = '$_apiDomain$_apiBasePath';
  static const String _apiDomain = 'https://www.googleapis.com/books/';
  static const String _apiBasePath = 'v1/volumes';

  static const String searchBooks = '$_baseUrl?q=';
  static const String detailsBook = '$_baseUrl/';
}
