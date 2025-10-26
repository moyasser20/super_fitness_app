import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../features/auth/data/models/login_models/login_request_model.dart';
import '../../../features/auth/data/models/login_models/login_response_model.dart';
import '../../../features/auth/domain/responses/register_request_model.dart';
import '../../../features/auth/domain/responses/register_response.dart';
import '../../../features/auth/data/models/forgetpasswordmodels/forget_password_request_model.dart';
import '../../../features/auth/data/models/forgetpasswordmodels/reset_password_request_model.dart';
import '../../../features/auth/data/models/forgetpasswordmodels/verify_code_request_model.dart';
import '../api_constants/api_end_points.dart';
part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) = _ApiClient;

  @POST(ApiEndPoints.signup)
  Future<RegisterResponse> register(@Body() RegisterRequestModel registerRequest);

  @POST(ApiEndPoints.forgetPassword)
  Future<String> forgetPassword(
      @Body() ForgetPasswordRequestModel forgetPasswordRequestModel,
      );

  @POST(ApiEndPoints.verifyReset)
  Future<String> verifyResetCode(
      @Body() VerifyCodeRequestModel verifyResetCode,
      );

  @PUT(ApiEndPoints.resetPassword)
  Future<String> resetPassword(
      @Body() ResetPasswordRequestModel resetPasswordRequestModel,
      );

  @POST(ApiEndPoints.login)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);
}
