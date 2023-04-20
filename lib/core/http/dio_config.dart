import 'package:dio/dio.dart';

final dioApp = Dio(
  BaseOptions(
    baseUrl: 'https://www.googleapis.com/books/v1/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
);
