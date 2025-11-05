sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {
  final String? message;

  ChangePasswordSuccess({this.message});
}

final class ChangePasswordError extends ChangePasswordState {
  final String message;

  ChangePasswordError(this.message);
}
