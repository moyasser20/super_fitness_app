import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/routes/route_names.dart';

import 'core/config/di.dart';
import 'core/config/di.dart' as di;
import 'core/contants/secure_storage.dart';
import 'core/l10n/translation/app_localizations.dart';
import 'core/routes/on_generate_route.dart';
import 'features/auth/presentation/register/viewmodel/register_viewmodel/register_cubit.dart';
import 'features/localization/data/localization_preference.dart';
import 'features/localization/localization_controller/localization_cubit.dart';
import 'features/localization/localization_controller/localization_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  String languageValue = await LocalizationPreference.getLanguage();
  await SecureStorage.initialize();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationCubit>(
          create: (BuildContext context) =>
              LocalizationCubit(language: languageValue),
        ),
        BlocProvider<RegisterCubit>(
          create: (BuildContext context) => getIt<RegisterCubit>(),
        ),
      ],
      child: MyApp(
        initialRoute: AppRoutes.initial,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        final cubit = context.read<LocalizationCubit>();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          onGenerateRoute: Routes.onGenerateRoute,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale:
          cubit.language == "en" ? const Locale("en") : const Locale("ar"),
        );
      },
    );
  }
}
