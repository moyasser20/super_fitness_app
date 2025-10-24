import 'package:injectable/injectable.dart';
import '../../repo/auth_repo.dart';
import '../../responses/auth_response.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepo _authRepo;

  ForgetPasswordUseCase(this._authRepo);

  Future<AuthResponse<String>> call(String email) {
    return _authRepo.forgetPassword(email);
  }
}
