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
}
