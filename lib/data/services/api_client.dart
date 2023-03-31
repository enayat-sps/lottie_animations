import 'package:dio/dio.dart';
import 'package:lottie_animations/config/constants/api_endpoints.dart';
import 'package:lottie_animations/data/models/user.dart';
import 'package:lottie_animations/data/models/users_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Endpoints.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(Endpoints.users)
  Future<UsersModel> getUsers(
    @Query(Endpoints.pageQuery) int page,
    @Query(Endpoints.perPageQuery) int perPage,
  );

  @GET('${Endpoints.users}/${Endpoints.userIdPath}')
  Future<User> getSingleUser(
    @Path(Endpoints.userIdPath) int userid,
  );
}
