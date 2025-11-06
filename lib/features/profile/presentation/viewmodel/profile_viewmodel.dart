import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/profile/presentation/viewmodel/states/profile_states.dart';
import '../../../../core/errors/api_result.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/usecases/get_profile_data_usecase.dart';
import '../../../auth/domain/usecase/sign_out_usecase.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileStates> {
  final GetProfileDataUseCase _getProfileDataUseCase;
  final SignOutUseCase _signOutUseCase;

  ProfileViewModel(this._getProfileDataUseCase, this._signOutUseCase)
    : super(ProfileInitialState());

  UserEntity? user;

  Future<void> getProfile() async {
    emit(ProfileLoadingState());
    final result = await _getProfileDataUseCase();

    switch (result) {
      case ApiSuccessResult(:final data):
        user = data;
        emit(ProfileSuccessState(data));
      case ApiErrorResult(:final errorMessage):
        emit(ProfileErrorState(errorMessage));
    }
  }

  void clearProfileCache() {
    user = null;
  }

  Future<void> signOut(BuildContext context) async {
    return await _signOutUseCase.call(context);
  }
}
