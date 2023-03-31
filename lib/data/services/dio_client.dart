import 'package:dio/dio.dart';

import 'package:lottie_animations/config/constants/api_endpoints.dart';


Dio dioClient() {
  final dio = Dio();
  dio.options.connectTimeout = const Duration(
    milliseconds: Endpoints.connectionTimeout,
  );
  dio.options.headers["Accept"] = "application/json";
  return dio;
}
