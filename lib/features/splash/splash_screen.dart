import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/contants/secure_storage.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/dash_board_screen.dart';
import 'package:super_fitness_app/features/auth/presentation/register/views/register_screen.dart';
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

// splash_screen.dart
  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    // Debug: Check what values we're getting
    final String? token = await SecureStorage.getToken();
    final bool hasSeenOnboarding = Prefs.isOnboardingSeen();

    print('=== DEBUG SPLASH SCREEN ===');
    print('Token: $token');
    print('Has seen onboarding: $hasSeenOnboarding');
    print('===========================');

    if (token != null && token.isNotEmpty) {
      print('Navigating to DASHBOARD');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
            (Route<dynamic> route) => false,
      );
    } else {
      if (hasSeenOnboarding) {
        print('Navigating to REGISTER (onboarding seen)');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
              (Route<dynamic> route) => false,
        );
      } else {
        print('Navigating to ONBOARDING (first time)');
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