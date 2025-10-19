import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/auth/domain/repo/auth_repo.dart';
import '../../../../domain/responses/auth_response.dart';
import '../../../../domain/responses/register_request_model.dart';
import '../../../../domain/responses/register_response.dart';
import 'package:injectable/injectable.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo _authRepo;

  RegisterCubit(this._authRepo) : super(RegisterInitial());

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
  }) async {
    emit(RegisterLoading());

    final registerRequest = RegisterRequestModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      gender: 'male',
      height: 170,
      weight: 70,
      age: 25,
      goal: 'Maintain weight',
      activityLevel: 'level1',
    );

    final AuthResponse<RegisterResponse> response = await _authRepo.register(registerRequest);

    if (response.isSuccess) {
      emit(RegisterLoaded(response.data!));
    } else {
      emit(RegisterError(response.error!));
    }
  }
}