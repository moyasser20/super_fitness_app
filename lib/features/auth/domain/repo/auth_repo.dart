import '../../data/models/login_models/login_request_model.dart';
import '../../data/models/login_models/login_response_model.dart';
import '../responses/auth_response.dart';
import '../responses/register_request_model.dart';
import '../responses/register_response.dart';

abstract class AuthRepo {
  Future<AuthResponse<RegisterResponse>> register(RegisterRequestModel registerRequest);
  Future<AuthResponse<LoginResponse>> login(LoginRequest loginRequest);
}
