import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/auth/data/models/forgetpasswordmodels/reset_password_request_model.dart';
import 'package:super_fitness_app/features/auth/data/models/forgetpasswordmodels/verify_code_request_model.dart';
import 'dart:convert';
import '../../../../core/errors/failure.dart';
import '../../../../core/api/client/api_client.dart';
import '../../data/datasource/auth_remote_data_source.dart';
import '../../data/models/forgetpasswordmodels/forget_password_request_model.dart';
import '../../domain/responses/auth_response.dart';
import '../../data/models/login_models/login_request_model.dart';
import '../../data/models/login_models/login_response_model.dart';
import '../../domain/responses/auth_response.dart';
import '../../domain/responses/register_request_model.dart';
import '../../domain/responses/register_response.dart';

@LazySingleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiClient _apiClient;
  AuthRemoteDatasourceImpl(this._apiClient);

  String _extractApiMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      return data['error'] ??
          data['message'] ??
          ServerFailure.fromDio(e).errorMessage;
    }
    if (data is String) {
      try {
        final decoded = json.decode(data);
        if (decoded is Map) {
          return decoded['error'] ??
              decoded['message'] ??
              ServerFailure.fromDio(e).errorMessage;
        }
      } catch (_) {}
    }
    return ServerFailure.fromDio(e).errorMessage;
  }

  @override
  Future<AuthResponse<RegisterResponse>> register(RegisterRequestModel registerRequest) async {
    try {
      final response = await _apiClient.register(registerRequest);
      return AuthResponse.success(response);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }
  @override
  Future<AuthResponse<String>> forgetPassword(
      ForgetPasswordRequestModel forgetPasswordRequestModel,
      ) async {
    try {
      final result = await _apiClient.forgetPassword(
        forgetPasswordRequestModel,
      );
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }
  @override
  Future<AuthResponse<String>> resetPassword(
      ResetPasswordRequestModel resetPasswordRequestModel,
      ) async {
    try {
      final result = await _apiClient.resetPassword(
        resetPasswordRequestModel,
      );
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<AuthResponse<String>> verifyResetPassword(
      VerifyCodeRequestModel verifyCodeRequestModel,
      ) async {
    try {
      final result = await _apiClient.verifyResetCode(
        verifyCodeRequestModel,
      );
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

}

  @override
  Future<AuthResponse<LoginResponse>> login(LoginRequest loginRequest) async {
    try {
      final result = await _apiClient.login(loginRequest);
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

}