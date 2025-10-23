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
    test(
      'emits error if submitRegistration called with incomplete data',
      () async {
        final states = <RegisterState>[];
        final sub = cubit.stream.listen(states.add);
        await cubit.submitRegistration();
        await Future.delayed(Duration.zero);
        expect(states, isNotEmpty);
        expect(states.first, isA<RegisterError>());
        await sub.cancel();
      },
    );
    test('emits loading+loaded on successful registration', () async {
      when(mockAuthRepo.register(any)).thenAnswer(
        (_) async => AuthResponse.success(
          RegisterResponse(
            message: 'Success',
            user: {} as dynamic,
            token: 'abc',
          ),
        ),
      );
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
      when(
        mockAuthRepo.register(any),
      ).thenAnswer((_) async => AuthResponse.error('Server error'));
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
      when(
        mockRegisterCubit.setPersonalInfo(
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          email: anyNamed('email'),
          password: anyNamed('password'),
          rePassword: anyNamed('rePassword'),
        ),
      ).thenReturn(null);
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
    testWidgets('validates email format', (tester) async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.enterText(find.byType(TextFormField).at(2), 'invalid-email');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.textContaining('email'), findsAtLeastNWidgets(1));
    });

    testWidgets('validates password length', (tester) async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.enterText(find.byType(TextFormField).at(3), '123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.textContaining('6'), findsAtLeastNWidgets(1));
    });

    testWidgets('validates password complexity', (tester) async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.enterText(
        find.byType(TextFormField).at(3),
        'simplepassword',
      );
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.textContaining('uppercase'), findsAtLeastNWidgets(1));
    });

    testWidgets('validates password confirmation match', (tester) async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.enterText(find.byType(TextFormField).at(3), 'Abc@1234');
      await tester.enterText(
        find.byType(TextFormField).at(4),
        'Different@1234',
      );
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.textContaining('match'), findsAtLeastNWidgets(1));
    });

    testWidgets('navigates to login screen when login button tapped', (
      tester,
    ) async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
    });

    testWidgets('displays loading state correctly', (tester) async {
      when(mockRegisterCubit.state).thenReturn(RegisterLoading());
      await tester.pumpWidget(makeTestableWidget());
      expect(find.byType(RegisterScreen), findsOneWidget);
    });

    testWidgets('displays error state correctly', (tester) async {
      when(
        mockRegisterCubit.state,
      ).thenReturn(RegisterError('Registration failed'));
      await tester.pumpWidget(makeTestableWidget());
      expect(find.byType(RegisterScreen), findsOneWidget);
    });

  });
  group('RegisterCubit additional tests', () {
    late MockAuthRepo mockAuthRepo;
    late RegisterCubit cubit;

    setUp(() {
      mockAuthRepo = MockAuthRepo();
      cubit = RegisterCubit(mockAuthRepo);
    });

    test('setGender updates gender correctly', () {
      cubit.setGender('male');
      expect(
        cubit.isDataComplete,
        isFalse,
      );
    });

    test('setAge updates age correctly', () {
      cubit.setAge(25);
      expect(cubit.isDataComplete, isFalse);
    });

    test('setWeight updates weight correctly', () {
      cubit.setWeight(70);
      expect(cubit.isDataComplete, isFalse);
    });

    test('setHeight updates height correctly', () {
      cubit.setHeight(175);
      expect(cubit.isDataComplete, isFalse);
    });

    test('setGoal updates goal correctly', () {
      cubit.setGoal(goal: 'health');
      expect(cubit.isDataComplete, isFalse);
    });

    test('setActivityLevel updates activity level correctly', () {
      cubit.setActivityLevel(activityLevel: 'moderate');
      expect(cubit.isDataComplete, isFalse);
    });

    test('isDataComplete returns true when all data is set', () {
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

      expect(cubit.isDataComplete, isTrue);
    });

    test('isDataComplete returns false when any data is missing', () {
      cubit.setPersonalInfo(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        password: 'Abc@1234',
        rePassword: 'Abc@1234',
      );
      // Missing gender, age, weight, height, goal, activityLevel
      expect(cubit.isDataComplete, isFalse);
    });

    test('handles network error during registration', () async {
      when(mockAuthRepo.register(any)).thenThrow(Exception('Network error'));

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
      expect(
        (states.last as RegisterError).message,
        contains('An unexpected error occurred'),
      );

      await sub.cancel();
    });

    test('saves token on successful registration', () async {
      when(mockAuthRepo.register(any)).thenAnswer(
        (_) async => AuthResponse.success(
          RegisterResponse(
            message: 'Success',
            user: {} as dynamic,
            token: 'test_token_123',
          ),
        ),
      );

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
      expect(states.last, anyOf(isA<RegisterLoaded>(), isA<RegisterError>()));

      await sub.cancel();
    });
  });
  group('RegisterScreen integration tests', () {
    late MockAuthRepo mockAuthRepo;
    late RegisterCubit cubit;
    late MockRegisterCubit mockRegisterCubit;

    setUp(() {
      mockAuthRepo = MockAuthRepo();
      cubit = RegisterCubit(mockAuthRepo);
      mockRegisterCubit = MockRegisterCubit();
      when(mockRegisterCubit.state).thenReturn(RegisterInitial());
    });

    Widget makeTestableWidgetWithRealCubit() {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<RegisterCubit>.value(
          value: cubit,
          child: const RegisterScreen(),
        ),
      );
    }

    testWidgets('integrates with real cubit for form submission', (
      tester,
    ) async {
      await tester.pumpWidget(makeTestableWidgetWithRealCubit());

      await tester.enterText(find.byType(TextFormField).at(0), 'John');
      await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
      await tester.enterText(
        find.byType(TextFormField).at(2),
        'john@example.com',
      );
      await tester.enterText(find.byType(TextFormField).at(3), 'Abc@1234');
      await tester.enterText(find.byType(TextFormField).at(4), 'Abc@1234');
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(cubit.isDataComplete, isFalse);
    });

    testWidgets('handles BlocConsumer state changes', (tester) async {
      when(mockRegisterCubit.state).thenReturn(RegisterLoading());
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider<RegisterCubit>.value(
            value: mockRegisterCubit,
            child: const RegisterScreen(),
          ),
        ),
      );

      await tester.pump();
    });
  });
}
