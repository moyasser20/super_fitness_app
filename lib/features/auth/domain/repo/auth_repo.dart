import '../responses/auth_response.dart';
import '../responses/register_request_model.dart';
import '../responses/register_response.dart';

abstract class AuthRepo {
  Future<AuthResponse<RegisterResponse>> register(
    RegisterRequestModel registerRequest,
  );
}
