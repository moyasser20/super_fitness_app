import '../responses/auth_response.dart';

import '../../data/models/login_models/login_request_model.dart';
import '../../data/models/login_models/login_response_model.dart';
import '../responses/auth_response.dart';
import '../responses/register_request_model.dart';
import '../responses/register_response.dart';

abstract class AuthRepo {
  Future<AuthResponse<String>> forgetPassword(String email);
  Future<AuthResponse<String>> verifyCode(String code);
  Future<AuthResponse<String>> resetPassword(String email, String newPassword);
  Future<AuthResponse<RegisterResponse>> register(RegisterRequestModel registerRequest);
  Future<AuthResponse<LoginResponse>> login(LoginRequest loginRequest);
}
