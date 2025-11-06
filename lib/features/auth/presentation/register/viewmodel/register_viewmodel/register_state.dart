part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterLoaded extends RegisterState {
  final RegisterResponse registerResponse;

  RegisterLoaded(this.registerResponse);
}

final class RegisterError extends RegisterState {
  final String message;

  RegisterError(this.message);
}
