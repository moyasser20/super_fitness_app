import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/repo/auth_repo.dart';
import 'change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AuthRepo _authRepo;

  ChangePasswordCubit(this._authRepo) : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoading());

    if (newPassword != confirmPassword) {
      emit(ChangePasswordError('Passwords do not match'));
      return;
    }

    final response = await _authRepo.changePassword(oldPassword, newPassword);

    if (response.isSuccess) {
      emit(ChangePasswordSuccess());
    } else {
      emit(ChangePasswordError(response.error ?? 'Failed to change password'));
    }
  }

  void resetState() {
    emit(ChangePasswordInitial());
  }
}