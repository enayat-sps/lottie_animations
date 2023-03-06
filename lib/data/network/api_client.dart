import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../config/constants/api_endpoints.dart';
import '../models/users_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Endpoints.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(Endpoints.users)
  Future<UsersModel> getUsers();
}
