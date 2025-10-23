import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/routes/route_names.dart';

import '../../features/auth/presentation/forgetpassword/view/screens/email_verification_screen.dart';
import '../../features/auth/presentation/forgetpassword/view/screens/forget_password_screen.dart';
import '../../features/auth/presentation/forgetpassword/view/screens/reset_password_screen.dart';
import '../../features/auth/presentation/forgetpassword/viewmodel/forget_password_viewmodel.dart';
import '../../features/auth/presentation/forgetpassword/viewmodel/reset_password_viewmodel.dart';
import '../../features/auth/presentation/forgetpassword/viewmodel/verify_code_viewmodel.dart';
import '../../features/auth/presentation/register/views/register_screen.dart';
import '../config/di.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
          settings: settings,
        );
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<ForgetPasswordCubit>(
            create: (context) => getIt<ForgetPasswordCubit>(),
            child: const ForgetPasswordScreen(),
          ),
        );
      case AppRoutes.emailVerification:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<VerifyCodeCubit>(
            create: (context) => getIt<VerifyCodeCubit>(),
            child: EmailVerificationScreen(email: email),
          ),
        );

      case AppRoutes.resetPassword:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<ResetPasswordCubit>(
            create: (context) => getIt<ResetPasswordCubit>(),
            child: ResetPasswordScreen(email: email),
          ),
        );


      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
