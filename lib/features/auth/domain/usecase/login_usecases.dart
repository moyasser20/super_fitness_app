import 'package:injectable/injectable.dart';
import '../../data/models/login_models/login_request_model.dart';
import '../../data/models/login_models/login_response_model.dart';
import '../repo/auth_repo.dart';
import '../responses/auth_response.dart';

@injectable
class LoginUseCase {
  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  Future<AuthResponse<LoginResponse>> call(LoginRequest loginRequest) {
    return _authRepo.login(loginRequest);
  }
}
