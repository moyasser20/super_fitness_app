import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/dash_board_screen.dart';
import 'package:super_fitness_app/features/auth/presentation/register/views/complete_registration_screen.dart';
import 'package:super_fitness_app/features/auth/presentation/register/views/register_screen.dart';
import 'package:super_fitness_app/features/bot/view/smart_coach_screen.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/view/screens/edit_profile_screen.dart';
import 'package:super_fitness_app/features/onboarding/onboaarding_screen.dart';
import 'package:super_fitness_app/features/profile/presentation/view/widgets/help_screen.dart';
import 'package:super_fitness_app/features/profile/presentation/view/widgets/privacy_policy_screen.dart';
import 'package:super_fitness_app/features/profile/presentation/view/widgets/security_roles_screen.dart';
import 'package:super_fitness_app/features/splash/splash_screen.dart';
import 'package:super_fitness_app/features/food-details/presentation/view/screens/food_details_screen.dart';
import 'package:super_fitness_app/features/food-details/presentation/viewmodel/meals_details_cubit.dart';
import 'package:super_fitness_app/features/exercise/presentation/view/exercises_screen.dart';
import 'package:super_fitness_app/features/exercise/presentation/viewmodel/exercise_viewmodel.dart';
import 'package:super_fitness_app/features/food/presentation/view/screens/food_screen.dart';
import 'package:super_fitness_app/features/food/presentation/viewmodel/food_viewmodel.dart';
import 'package:super_fitness_app/features/home/presentation/views/home_screen.dart';
import 'package:super_fitness_app/features/workouts/presentation/view/workouts_screen.dart';
import 'package:super_fitness_app/features/auth/presentation/login/presentation/view/login_screen.dart';
import 'package:super_fitness_app/features/auth/presentation/login/presentation/viewmodel/login_viewmodel.dart';
import 'package:super_fitness_app/features/auth/presentation/forgetpassword/view/screens/email_verification_screen.dart';
import 'package:super_fitness_app/features/auth/presentation/forgetpassword/view/screens/forget_password_screen.dart';
import 'package:super_fitness_app/features/auth/presentation/forgetpassword/view/screens/reset_password_screen.dart';
import 'package:super_fitness_app/features/auth/presentation/forgetpassword/viewmodel/forget_password_viewmodel.dart';
import 'package:super_fitness_app/features/auth/presentation/forgetpassword/viewmodel/reset_password_viewmodel.dart';
import 'package:super_fitness_app/features/auth/presentation/forgetpassword/viewmodel/verify_code_viewmodel.dart';
import '../../core/config/di.dart';
import '../../features/edit-profile/presentation/view/widgets/activity_step_widget.dart';
import '../../features/edit-profile/presentation/view/widgets/goal_step_widget.dart';
import '../../features/edit-profile/presentation/view/widgets/weight_step_widget.dart';
import '../../features/edit-profile/presentation/viewmodel/edit_profile_cubit.dart';
import '../../features/auth/presentation/change_password/views/change_password_screen.dart';
import '../../features/food-details/presentation/view/screens/food_details_screen.dart';
import '../../features/food-details/presentation/viewmodel/meals_details_cubit.dart';
import '../../features/exercise/presentation/view/exercises_screen.dart';
import '../../features/exercise/presentation/viewmodel/exercise_viewmodel.dart';
import '../../features/food/presentation/view/screens/food_screen.dart';
import '../../features/food/presentation/viewmodel/food_viewmodel.dart';
import '../../features/home/presentation/views/home_screen.dart';
import '../../features/profile/presentation/viewmodel/profile_viewmodel.dart';
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
      case AppRoutes.smartCoachScreen:
        return MaterialPageRoute(builder: (_) => const SmartCoachScreen());

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
              ),
        );

      case AppRoutes.foodDetailsScreen:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) {
                  final cubit = getIt<MealDetailsCubit>();
                  cubit.getMealById(args);
                  return cubit;
                },
                child: FoodDetailsScreen(mealId: args),
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
        final arg = settings.arguments;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<MealsCubit>(),
                child: FoodScreen(initialCategory: arg is String ? arg : null),
              ),
        );

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
        case AppRoutes.changePasswordScreen:
          return MaterialPageRoute(
            builder:
                (_) => const ChangePasswordScreen(),
          );


      case AppRoutes.securityScreen:
        return MaterialPageRoute(builder: (_) => const SecurityRolesScreen());

      case AppRoutes.privacyPolicyScreen:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());

      case AppRoutes.helpScreen:
        return MaterialPageRoute(builder: (_) => const HelpScreen());

      case AppRoutes.editProfileScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<ProfileViewModel>()..getProfile()),
              BlocProvider(create: (_) => getIt<EditProfileViewModel>()),
            ],
            child: const EditProfileScreen(),
          ),
        );


      case AppRoutes.weightStepScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<EditProfileViewModel>(),
            child: WeightStepScreen(
              selectedWeight: args['selectedWeight'],
              onWeightChanged: args['onWeightChanged'],
              onNext: args['onNext'],
            ),
          ),
        );

      case AppRoutes.goalStepScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<EditProfileViewModel>(),
            child: GoalStepScreen(
              goals: args['goals'],
              selectedGoal: args['selectedGoal'],
              onGoalSelected: args['onGoalSelected'],
              onNext: args['onNext'],
            ),
          ),
        );

      case AppRoutes.activityStepScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<EditProfileViewModel>(),
            child: ActivityStepScreen(
              activities: args['activities'],
              selectedActivityDisplay: args['selectedActivityDisplay'],
              onActivitySelected: args['onActivitySelected'],
              onNext: args['onNext'],
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
