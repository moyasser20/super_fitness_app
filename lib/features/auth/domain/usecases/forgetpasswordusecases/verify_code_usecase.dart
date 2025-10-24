import 'package:injectable/injectable.dart';
import '../../repo/auth_repo.dart';
import '../../responses/auth_response.dart';

@injectable
class VerifyCodeUseCase {
  final AuthRepo _authRepo;

  VerifyCodeUseCase(this._authRepo);

  Future<AuthResponse<String>> call(String code) {
    return _authRepo.verifyCode(code);
  }
}
