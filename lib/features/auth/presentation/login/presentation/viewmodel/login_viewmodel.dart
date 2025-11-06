import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/contants/secure_storage.dart';
import '../../../../data/models/login_models/login_request_model.dart';
import '../../../../domain/services/auth_services.dart';
import '../../../../domain/usecase/login_usecases.dart';
import 'login_states.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(LoginInitialStates());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  Future<void> login(String email, String password) async {
    emit(LoginLoadingState());
    final request = LoginRequest(email: email, password: password);
    final response = await _loginUseCase(request);
    if (response.isSuccess) {
      await SecureStorage.saveToken(response.data!.token!);
      await AuthService.saveAuthToken(response.data?.token ?? "");

      if (rememberMe) {
        await SecureStorage.saveRememberMe(true);
        await SecureStorage.saveUserCredentials(email, password);
      } else {
        await SecureStorage.saveRememberMe(false);
        await SecureStorage.deleteRememberedCredentials();
      }

      emit(LoginSuccessState(response.data!));
    } else {
      emit(LoginErrorState(response.error ?? "unknown error"));
    }
  }

  Future<void> loadRememberedCredentials() async {
    final shouldRememberMe = await SecureStorage.getRememberMe();
    if (shouldRememberMe) {
      final credentials = await SecureStorage.getRememberedCredentials();
      final email = credentials['email'];
      final password = credentials['password'];

      if (email != null && password != null) {
        emailController.text = email;
        passwordController.text = password;
        rememberMe = true;
      }
    }
    emit(LoginInitialStates());
  }

  void toggleRememberMe(bool value) {
    rememberMe = value;
  }

  void clearFormFields() {
    emailController.clear();
    passwordController.clear();
    rememberMe = false;
    emit(LoginInitialStates());
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
