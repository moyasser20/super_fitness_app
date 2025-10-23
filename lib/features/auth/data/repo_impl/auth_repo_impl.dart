import 'package:injectable/injectable.dart';
import '../../domain/repo/auth_repo.dart';
import '../../domain/responses/auth_response.dart';
import '../datasource/auth_remote_data_source.dart';
import '../models/forgetpasswordmodels/forget_password_request_model.dart';
import '../models/forgetpasswordmodels/reset_password_request_model.dart';
import '../models/forgetpasswordmodels/verify_code_request_model.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDatasource _authRemoteDatasource;
  AuthRepoImpl(this._authRemoteDatasource);
  @override
  Future<AuthResponse<String>> forgetPassword(String email) async {
    final model = ForgetPasswordRequestModel(email: email);
    return await _authRemoteDatasource.forgetPassword(model);
  }

  @override
  Future<AuthResponse<String>> verifyCode(String code) async {
    final model = VerifyCodeRequestModel(resetCode: code);
    return await _authRemoteDatasource.verifyResetPassword(model);
  }

  @override
  Future<AuthResponse<String>> resetPassword(
      String email,
      String newPassword,
      ) async {
    final model = ResetPasswordRequestModel(
      email: email,
      newPassword: newPassword,
    );
    return await _authRemoteDatasource.resetPassword(model);
  }

}
