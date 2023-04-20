import 'package:dio/dio.dart';

import '../commom/domain/failure.dart';

class HttpClient {
  final Dio _dio;

  HttpClient(this._dio) {
    _addInterceptor();
  }

  Future<Response> get(String url) async {
    try {
      final response = await _dio.get(url);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Failure _handleError(Object e) {
    if (e is DioError) {
      if (e.type == DioErrorType.connectionTimeout) {
        return OfflineFailure();
      } else if (e.type == DioErrorType.cancel ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.badResponse) {
        return ServerFailure(e.message.toString());
      }
    }
    return NotFoundFailure(e.toString());
  }

  void _addInterceptor() {
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }
}
