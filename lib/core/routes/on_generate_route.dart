import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/routes/route_names.dart';
import 'package:super_fitness_app/features/splash/splash_screen.dart';

import '../../features/auth/presentation/register/views/register_screen.dart';
import '../../features/auth/presentation/register/views/complete_registration_screen.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
       
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
