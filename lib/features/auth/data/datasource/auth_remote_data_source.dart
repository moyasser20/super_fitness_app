import '../../domain/responses/auth_response.dart';
import '../../domain/responses/register_request_model.dart';
import '../../domain/responses/register_response.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResponse<RegisterResponse>> register(RegisterRequestModel registerRequest);
}