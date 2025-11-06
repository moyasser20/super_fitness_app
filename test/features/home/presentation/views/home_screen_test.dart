import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/home/presentation/viewmodel/home_cubit.dart';
import 'package:super_fitness_app/features/home/presentation/views/home_screen.dart';
import 'package:super_fitness_app/core/contants/app_images.dart';

@GenerateMocks([HomeCubit])
import 'home_screen_test.mocks.dart';

void main() {
  late MockHomeCubit mockHomeCubit;

  setUpAll(() {
    provideDummy<HomeState>(HomeLoading());
    provideDummy<HomeLoaded>(
      HomeLoaded(
        recommendedMuscles: const [],
        muscleGroups: const [],
        userName: 'dummy',
        userImage: AppImages.mainImage,
        selectedWorkout: null,
        selectedMuscleIds: const {},
      ),
    );
    provideDummy<HomeError>(HomeError('error'));
  });

  setUp(() {
    mockHomeCubit = MockHomeCubit();
  });

  Widget buildTestable({required HomeState state}) {
    when(mockHomeCubit.state).thenReturn(state);
    when(mockHomeCubit.stream).thenAnswer((_) => Stream.value(state));
    return MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(size: Size(1200, 2000)),
        child: BlocProvider<HomeCubit>.value(
          value: mockHomeCubit,
          child: const HomeScreen(),
        ),
      ),
    );
  }

  testWidgets('renders HomeScreen with loading state', (tester) async {
    await tester.pumpWidget(buildTestable(state: HomeLoading()));
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.textContaining('Hi'), findsOneWidget);
  });

  testWidgets('renders HomeScreen with loaded state and username', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestable(
        state: HomeLoaded(
          recommendedMuscles: const [],
          muscleGroups: const [],
          userName: 'Test User',
          userImage: AppImages.mainImage,
          selectedWorkout: null,
          selectedMuscleIds: const {},
        ),
      ),
    );
    expect(find.text('Hi Test User,'), findsOneWidget);
    expect(find.text('Category'), findsOneWidget);
    expect(find.text('Upcoming Workouts'), findsOneWidget);
    expect(find.text('Recommendation for you'), findsOneWidget);
  });

  testWidgets('renders error UI when HomeError state is provided', (
    tester,
  ) async {
    await tester.pumpWidget(buildTestable(state: HomeError('error!')));
    expect(find.textContaining('Failed to load workouts'), findsOneWidget);
  });
}
