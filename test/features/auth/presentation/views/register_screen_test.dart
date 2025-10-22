import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/l10n/translation/app_localizations.dart';
import 'package:super_fitness_app/features/auth/presentation/register/views/register_screen.dart';
import 'package:super_fitness_app/features/auth/domain/repo/auth_repo.dart';
import 'package:super_fitness_app/features/auth/presentation/register/viewmodel/register_viewmodel/register_cubit.dart';
import 'package:super_fitness_app/features/auth/domain/responses/auth_response.dart';
import 'package:super_fitness_app/features/auth/domain/responses/register_response.dart';
import 'register_screen_test.mocks.dart';

@GenerateMocks([AuthRepo, RegisterCubit])
void main() {
  setUpAll(() {
    provideDummy<RegisterState>(RegisterInitial());
  });
  //-------------------- RegisterCubit UNIT TESTS ----------------------
  group('RegisterCubit', () {
    late MockAuthRepo mockAuthRepo;
    late RegisterCubit cubit;
    setUp(() {
      mockAuthRepo = MockAuthRepo();
      cubit = RegisterCubit(mockAuthRepo);
    });
    test('initial state is RegisterInitial', () {
      expect(cubit.state, isA<RegisterInitial>());
    });
    test('setPersonalInfo sets the data', () {
      cubit.setPersonalInfo(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        password: 'Abc@1234',
        rePassword: 'Abc@1234',
      );
      expect(cubit.isDataComplete, isFalse);
    });
    test('emits error if submitRegistration called with incomplete data', () async {
      final states = <RegisterState>[];
      final sub = cubit.stream.listen(states.add);
      await cubit.submitRegistration();
      await Future.delayed(Duration.zero);
      expect(states, isNotEmpty);
      expect(states.first, isA<RegisterError>());
      await sub.cancel();
    });
    test('emits loading+loaded on successful registration', () async {
      when(mockAuthRepo.register(any)).thenAnswer((_) async => AuthResponse.success(RegisterResponse(message: 'Success', user: {} as dynamic, token: 'abc')));
      cubit.setPersonalInfo(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        password: 'Abc@1234',
        rePassword: 'Abc@1234',
      );
      cubit.setGender('male');
      cubit.setAge(28);
      cubit.setWeight(72);
      cubit.setHeight(180);
      cubit.setGoal(goal: 'health');
      cubit.setActivityLevel(activityLevel: 'moderate');
      final states = <RegisterState>[];
      final sub = cubit.stream.listen(states.add);
      await cubit.submitRegistration();
      await Future.delayed(Duration.zero);
      expect(states, contains(isA<RegisterLoading>()));
      await sub.cancel();
    });
    test('emits loading+error on registration failure', () async {
      when(mockAuthRepo.register(any)).thenAnswer((_) async => AuthResponse.error('Server error'));
      cubit.setPersonalInfo(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        password: 'Abc@1234',
        rePassword: 'Abc@1234',
      );
      cubit.setGender('male');
      cubit.setAge(28);
      cubit.setWeight(72);
      cubit.setHeight(180);
      cubit.setGoal(goal: 'health');
      cubit.setActivityLevel(activityLevel: 'moderate');
      final states = <RegisterState>[];
      final sub = cubit.stream.listen(states.add);
      await cubit.submitRegistration();
      await Future.delayed(Duration.zero);
      expect(states, contains(isA<RegisterLoading>()));
      expect(states.last, isA<RegisterError>());
      await sub.cancel();
    });
  });

  //-------------------- RegisterScreen WIDGET TESTS ----------------------
  group('RegisterScreen widget', () {
    late MockRegisterCubit mockRegisterCubit;
    setUp(() {
      mockRegisterCubit = MockRegisterCubit();
      when(mockRegisterCubit.state).thenReturn(RegisterInitial());
      when(mockRegisterCubit.setPersonalInfo(
              firstName: anyNamed('firstName'),
              lastName: anyNamed('lastName'),
              email: anyNamed('email'),
              password: anyNamed('password'),
              rePassword: anyNamed('rePassword')))
          .thenReturn(null);
    });
    Widget makeTestableWidget() {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<RegisterCubit>.value(
          value: mockRegisterCubit,
          child: const RegisterScreen(),
        ),
      );
    }
    testWidgets('renders form fields and submit button', (tester) async {
      await tester.pumpWidget(makeTestableWidget());
      expect(find.byType(TextFormField), findsNWidgets(5));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
    testWidgets('shows error if fields are empty on submit', (tester) async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
    });
    testWidgets('calls setPersonalInfo on valid form', (tester) async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.enterText(find.byType(TextFormField).at(0), 'John');
      await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
      await tester.enterText(find.byType(TextFormField).at(2), 'john@example.com');
      await tester.enterText(find.byType(TextFormField).at(3), 'Abc@1234');
      await tester.enterText(find.byType(TextFormField).at(4), 'Abc@1234');
      await tester.pump();
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      verify(() => mockRegisterCubit.setPersonalInfo(
            firstName: 'John',
            lastName: 'Doe',
            email: 'john@example.com',
            password: 'Abc@1234',
            rePassword: 'Abc@1234',
          )).called(1);
    });
  });
}
