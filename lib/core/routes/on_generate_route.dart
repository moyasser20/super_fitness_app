import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/dash_board_screen.dart';
import 'package:super_fitness_app/features/auth/presentation/register/views/complete_registration_screen.dart';
import 'package:super_fitness_app/features/auth/presentation/register/views/register_screen.dart';
import 'package:super_fitness_app/features/onboarding/onboaarding_screen.dart';
import 'package:super_fitness_app/features/splash/splash_screen.dart';
import '../../features/food-details/presentation/view/screens/food_details_screen.dart';
import '../../features/food-details/presentation/viewmodel/meals_details_cubit.dart';
import '../../features/exercise/presentation/view/exercises_screen.dart';
import '../../features/exercise/presentation/viewmodel/exercise_viewmodel.dart';
import '../../features/food/presentation/view/screens/food_screen.dart';
import '../../features/home/presentation/views/home_screen.dart';
import '../../features/workouts/presentation/view/workouts_screen.dart';
import '../routes/route_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/login/presentation/view/login_screen.dart';
import '../../features/auth/presentation/login/presentation/viewmodel/login_viewmodel.dart';
import '../config/di.dart';
import '../../features/auth/presentation/forgetpassword/view/screens/email_verification_screen.dart';
import '../../features/auth/presentation/forgetpassword/view/screens/forget_password_screen.dart';
import '../../features/auth/presentation/forgetpassword/view/screens/reset_password_screen.dart';
import '../../features/auth/presentation/forgetpassword/viewmodel/forget_password_viewmodel.dart';
import '../../features/auth/presentation/forgetpassword/viewmodel/reset_password_viewmodel.dart';
import '../../features/auth/presentation/forgetpassword/viewmodel/verify_code_viewmodel.dart';

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
        return MaterialPageRoute(
          builder: (_) => const CompleteRegistrationScreen(),
        );
      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case AppRoutes.login:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => getIt<LoginViewModel>(),
                child: const LoginScreen(),
              ),
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
              ),        );

      case AppRoutes.foodDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = getIt<MealDetailsCubit>();
              cubit.getMealById("52959");
              return cubit;
            },
            child: const FoodDetailsScreen(mealId: '52959',),
          ),
        );
      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

        case AppRoutes.workoutsScreen:
        final bool isFromHome = settings.arguments as bool? ?? false;
        return MaterialPageRoute(
          builder: (_) => WorkoutsScreen(isFromHome: isFromHome),
        );

        case AppRoutes.foodScreen:
        return MaterialPageRoute(builder: (_) => const FoodScreen());

      case AppRoutes.exercisesScreen:
        final args = settings.arguments as ExerciseData;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<ExerciseViewModel>(),
                child: ExerciseScreen(
                  primeMoverMuscleId: args.id,
                  primeMoverMuscleName: args.name,
                ),
              ),
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
