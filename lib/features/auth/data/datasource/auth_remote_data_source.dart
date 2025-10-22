import '../../domain/responses/auth_response.dart';
import '../../domain/responses/register_request_model.dart';
import '../../domain/responses/register_response.dart';
import '../models/login_models/login_request_model.dart';
import '../models/login_models/login_response_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResponse<RegisterResponse>> register(RegisterRequestModel registerRequest);
  Future<AuthResponse<LoginResponse>> login(LoginRequest loginRequest);
}