import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/models/login_models/login_request_model.dart';
import '../../../../domain/usecase/login_usecases.dart';
import 'login_states.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(LoginInitialStates());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  Future<void> login(String email, String password) async {
    emit(LoginLoadingState());
    final request = LoginRequest(email: email, password: password);
    final response = await _loginUseCase(request);
    if (response.isSuccess) {
      emit(LoginSuccessState(response.data!));
    } else {
      emit(LoginErrorState(response.error ?? "unknown error"));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
