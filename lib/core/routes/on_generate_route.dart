import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/dash_board_screen.dart';
import 'package:super_fitness_app/features/auth/presentation/register/views/complete_registration_screen.dart';
import 'package:super_fitness_app/features/auth/presentation/register/views/register_screen.dart';
import 'package:super_fitness_app/features/onboarding/onboaarding_screen.dart';
import 'package:super_fitness_app/features/splash/splash_screen.dart';
import '../routes/route_names.dart';
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
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.completeRegistration:
        return MaterialPageRoute(builder: (_) => const CompleteRegistrationScreen());
      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
    case AppRoutes.login:
    return MaterialPageRoute(
    builder: (context) => BlocProvider(
    create: (context) => getIt<LoginViewModel>(),
    child: const LoginScreen(),
    ),
    );
        default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
      }
  }
}