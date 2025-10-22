import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../features/auth/domain/responses/register_request_model.dart';
import '../../../features/auth/domain/responses/register_response.dart';
import '../api_constants/api_end_points.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) = _ApiClient;

  @POST(ApiEndPoints.signup)
  Future<RegisterResponse> register(@Body() RegisterRequestModel registerRequest);
}