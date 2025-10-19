import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/routes/route_names.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
