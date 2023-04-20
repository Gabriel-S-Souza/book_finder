import 'package:book_finder/modules/discover_books/data/mocks/books_response_mock.dart';
import 'package:dio/dio.dart';

import '../commom/domain/failure.dart';

class HttpClient {
  final Dio _dio;

  HttpClient(this._dio);

  Future<Response> get(String url) async {
    // try {
    //   final response = await _dio.get(url);
    //   return response;
    // } catch (e) {
    //   throw _handleError(e);
    // }

    //TODO: Remove mock

    // success
    return Response(
      requestOptions: RequestOptions(path: url),
      data: booksResponseMock,
      statusCode: 200,
    );

    // error
    // throw ServerFailure();
  }

  Failure _handleError(Object e) {
    if (e is DioError) {
      if (e.type == DioErrorType.connectionTimeout) {
        return ConnectTimeoutFailure();
      } else if (e.type == DioErrorType.cancel ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.badResponse) {
        return ServerFailure(e.message.toString());
      }
    }
    return NotFoundFailure(e.toString());
  }
}
