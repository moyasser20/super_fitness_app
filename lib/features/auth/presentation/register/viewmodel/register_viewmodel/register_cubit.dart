import 'dart:developer';
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

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  String? _rePassword;
  String? _gender;
  int? _age;
  int? _weight;
  int? _height;
  String? _goal;
  String? _activityLevel;

  RegisterCubit(this._authRepo) : super(RegisterInitial()) {
    log('=== REGISTER CUBIT CREATED ===');
    log('Cubit instance: ${this.hashCode}');
    log('First: $_firstName, Last: $_lastName, Email: $_email');
  }

  void setPersonalInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _password = password;
    _rePassword = rePassword;
  }

  void setGender(String gender) {
    _gender = gender;
  }

  void setAge(int age) {
    _age = age;
  }

  void setWeight(int weight) {
    _weight = weight;
  }

  void setHeight(int height) {
    _height = height;
  }

  void setGoal({required String goal}) {
    _goal = goal;
  }

  void setActivityLevel({required String activityLevel}) {
    _activityLevel = activityLevel;
  }

  bool get isDataComplete =>
      _firstName != null &&
      _lastName != null &&
      _email != null &&
      _password != null &&
      _rePassword != null &&
      _gender != null &&
      _age != null &&
      _weight != null &&
      _height != null &&
      _goal != null &&
      _activityLevel != null;

  Future<void> submitRegistration() async {
    if (!isDataComplete) {
      final error =
          'Please complete all registration steps. Some information is missing.';
      log('Registration failed: $error');
      emit(RegisterError(error));
      return;
    }
    emit(RegisterLoading());

    final registerRequest = RegisterRequestModel(
      firstName: _firstName!,
      lastName: _lastName!,
      email: _email!,
      password: _password!,
      rePassword: _rePassword!,
      gender: _gender!,
      height: _height!,
      weight: _weight!,
      age: _age!,
      goal: _goal!,
      activityLevel: _activityLevel!,
    );
    try {
      final AuthResponse<RegisterResponse> response = await _authRepo.register(
        registerRequest,
      );

      if (response.isSuccess) {
        emit(RegisterLoaded(response.data!));
      } else {
        emit(RegisterError(response.error!));
      }
    } catch (e) {
      emit(RegisterError('An unexpected error occurred: $e'));
    }
  }

  void reset() {
    log('Resetting all registration data');
    _firstName = null;
    _lastName = null;
    _email = null;
    _password = null;
    _rePassword = null;
    _gender = null;
    _age = null;
    _weight = null;
    _height = null;
    _goal = null;
    _activityLevel = null;
    emit(RegisterInitial());
  }
}
