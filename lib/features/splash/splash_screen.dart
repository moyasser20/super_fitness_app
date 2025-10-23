import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/contants/secure_storage.dart';
import 'package:super_fitness_app/core/routes/route_names.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/dash_board_screen.dart';
import 'package:super_fitness_app/features/onboarding/onboaarding_screen.dart';
import '../../core/contants/prefs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    final String? token = await SecureStorage.getToken();
    final bool hasSeenOnboarding = Prefs.isOnboardingSeen();

    log('=== DEBUG SPLASH SCREEN ===');
    log('Token: $token');
    log('Has seen onboarding: $hasSeenOnboarding');
    log('===========================');

    if (token != null && token.isNotEmpty) {
      log('Navigating to DASHBOARD');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      if (hasSeenOnboarding) {
        log('Navigating to REGISTER (onboarding seen)');
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (Route<dynamic> route) => false,
        );
      } else {
        log('Navigating to ONBOARDING (first time)');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          (Route<dynamic> route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Image.asset(
          "assets/images/main_fitness_app_image.png",
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
