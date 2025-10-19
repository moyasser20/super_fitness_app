import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/routes/route_names.dart';

import '../../features/auth/presentation/register/viewmodel/register_viewmodel/register_cubit.dart';
import '../../features/auth/presentation/register/views/register_screen.dart';
import '../config/di.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
          settings: settings,
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
