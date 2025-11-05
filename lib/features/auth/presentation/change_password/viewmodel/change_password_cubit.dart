import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/contants/secure_storage.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../domain/repo/auth_repo.dart';
import 'change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AuthRepo _authRepo;

  ChangePasswordCubit(this._authRepo) : super(ChangePasswordInitial());

  Future<void> changePassword({
    required BuildContext context,
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    var locale = AppLocalizations.of(context);

    emit(ChangePasswordLoading());

    if (newPassword != confirmPassword) {
      emit(ChangePasswordError(locale!.passwordMismatchError));
      return;
    }

    final response = await _authRepo.changePassword(oldPassword, newPassword);

    if (response.isSuccess) {
      emit(
        ChangePasswordSuccess(
          message: locale!.changed_password_success,
        ),
      );
    } else {
      emit(ChangePasswordError(response.error ?? 'Failed to change password'));
    }
  }

  Future<void> logoutUser() async {
    await SecureStorage.deleteToken();
    await SecureStorage.clearUserData();
  }

  void resetState() {
    emit(ChangePasswordInitial());
  }
}
