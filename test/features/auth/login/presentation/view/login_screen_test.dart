import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/l10n/translation/app_localizations.dart';
import 'package:super_fitness_app/features/auth/presentation/login/presentation/view/login_screen.dart';
import 'package:super_fitness_app/features/auth/presentation/login/presentation/viewmodel/login_viewmodel.dart';
import 'package:super_fitness_app/features/auth/presentation/login/presentation/viewmodel/login_states.dart';

import 'login_screen_test.mocks.dart';

@GenerateMocks([LoginViewModel])
void main() {
  setUpAll(() {
    provideDummy<LoginStates>(LoginInitialStates());
  });
  late MockLoginViewModel mockLoginViewModel;

  setUp(() {
    mockLoginViewModel = MockLoginViewModel();
    when(mockLoginViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(mockLoginViewModel.state).thenReturn(LoginInitialStates());
    when(mockLoginViewModel.emailController).thenReturn(TextEditingController());
    when(mockLoginViewModel.passwordController).thenReturn(TextEditingController());
  });

  Widget makeTestableWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<LoginViewModel>.value(
        value: mockLoginViewModel,
        child: const LoginScreen(),
      ),
    );
  }

  group('LoginScreen Widget Tests', () {
    testWidgets('renders email and password fields and login button', (tester) async {
      await tester.pumpWidget(makeTestableWidget());
      expect(find.byType(TextFormField), findsNWidgets(2)); // email + password
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows validation errors when fields are empty', (tester) async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.textContaining('required'), findsWidgets);
    });

    testWidgets('calls login method when form is valid', (tester) async {
      when(mockLoginViewModel.login(any, any)).thenAnswer((_) async {});

      await tester.pumpWidget(makeTestableWidget());

      await tester.enterText(find.byType(TextFormField).at(0), 'test@test.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'Abc@1234');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(mockLoginViewModel.login('test@test.com', 'Abc@1234')).called(1);
    });
  });
}
