import 'package:injectable/injectable.dart';
import '../../domain/repo/auth_repo.dart';
import '../../domain/responses/auth_response.dart';
import '../../domain/responses/register_request_model.dart';
import '../../domain/responses/register_response.dart';
import '../datasource/auth_remote_data_source.dart';
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

}
