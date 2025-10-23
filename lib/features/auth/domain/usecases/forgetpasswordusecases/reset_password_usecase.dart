import 'package:injectable/injectable.dart';
import '../../repo/auth_repo.dart';
import '../../responses/auth_response.dart';


@injectable
class ResetPasswordUseCase {
  final AuthRepo _authRepo;

  ResetPasswordUseCase(this._authRepo);

  Future<AuthResponse<String>> call(String email, String newPassword) {
    return _authRepo.resetPassword(email, newPassword);
  }
}
