import 'package:dio/dio.dart';

Dio dioClient() {
  final dio = Dio();
  dio.options.headers["Accept"] = "application/json";
  return dio;
}
