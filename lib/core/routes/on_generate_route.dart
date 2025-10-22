import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/routes/route_names.dart';
import '../../features/app_sections/presentation/view/dash_board_screen.dart';
import '../../features/auth/presentation/login/presentation/view/login_screen.dart';
import '../../features/auth/presentation/login/presentation/viewmodel/login_viewmodel.dart';
import '../../features/auth/presentation/register/views/register_screen.dart';
import '../../features/auth/presentation/register/views/complete_registration_screen.dart';
import '../config/di.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
          settings: settings,
        );
      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (context) => const DashboardScreenApp(),
        );
      case AppRoutes.completeRegistration:
        return MaterialPageRoute(
          builder: (context) => const CompleteRegistrationScreen(),
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginViewModel>(),
            child: const LoginScreen(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
