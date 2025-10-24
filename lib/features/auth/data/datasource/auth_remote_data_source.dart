import '../../domain/responses/auth_response.dart';
import '../../domain/responses/register_request_model.dart';
import '../../domain/responses/register_response.dart';
import '../models/login_models/login_request_model.dart';
import '../models/login_models/login_response_model.dart';

import '../../domain/responses/auth_response.dart';
import '../models/forgetpasswordmodels/forget_password_request_model.dart';
import '../models/forgetpasswordmodels/reset_password_request_model.dart';
import '../models/forgetpasswordmodels/verify_code_request_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResponse<String>> forgetPassword(
      ForgetPasswordRequestModel forgetPasswordRequestModel,
      );
  Future<AuthResponse<String>> verifyResetPassword(
      VerifyCodeRequestModel verifyCodeRequestModel,
      );
  Future<AuthResponse<String>> resetPassword(
      ResetPasswordRequestModel resetPasswordRequestModel,
      );
  Future<AuthResponse<RegisterResponse>> register(RegisterRequestModel registerRequest);
  Future<AuthResponse<LoginResponse>> login(LoginRequest loginRequest);
}
