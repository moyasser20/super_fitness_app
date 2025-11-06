import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../repo/auth_repo.dart';

@injectable
class SignOutUseCase {
  final AuthRepo _authRepo;

  SignOutUseCase(this._authRepo);

  Future<void> call(BuildContext context) {
    return _authRepo.signOut(context);
  }
}
