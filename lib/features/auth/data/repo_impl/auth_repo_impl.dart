import 'package:injectable/injectable.dart';
import '../../domain/repo/auth_repo.dart';
import '../../domain/responses/auth_response.dart';
import '../datasource/auth_remote_data_source.dart';
import '../models/forgetpasswordmodels/forget_password_request_model.dart';
import '../models/forgetpasswordmodels/reset_password_request_model.dart';
import '../models/forgetpasswordmodels/verify_code_request_model.dart';
import '../../domain/responses/register_request_model.dart';
import '../../domain/responses/register_response.dart';
import '../models/login_models/login_request_model.dart';
import '../models/login_models/login_response_model.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDatasource _remoteDatasource;

  AuthRepoImpl(this._remoteDatasource);

  @override
  Future<AuthResponse<RegisterResponse>> register(
    RegisterRequestModel registerRequest,
  ) async {
    return await _remoteDatasource.register(registerRequest);
  }

  @override
  Future<AuthResponse<LoginResponse>> login(LoginRequest loginRequest) async {
    return await _remoteDatasource.login(loginRequest);
  }

  @override
  Future<AuthResponse<String>> forgetPassword(String email) async {
    final model = ForgetPasswordRequestModel(email: email);
    return await _remoteDatasource.forgetPassword(model);
  }

  @override
  Future<AuthResponse<String>> verifyCode(String code) async {
    final model = VerifyCodeRequestModel(resetCode: code);
    return await _remoteDatasource.verifyResetPassword(model);
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
    return await _remoteDatasource.resetPassword(model);
  }

  @override
  Future<AuthResponse<String>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    return await _remoteDatasource.changePassword(oldPassword, newPassword);
  }

  @override
  Future<String> logout() {
    return _remoteDatasource.logout();
  }
}
