import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/home/data/models/meal_categories_response_model.dart';
import 'package:super_fitness_app/features/home/data/models/meal_category_model.dart';
import 'package:super_fitness_app/features/home/data/models/muscles_response_model.dart';
import 'package:super_fitness_app/features/home/domain/usecases/get_meal_categories_usecase.dart';
import 'package:super_fitness_app/features/home/presentation/viewmodel/home_cubit.dart';
import 'package:super_fitness_app/features/home/domain/usecases/get_muscle_group_by_id_usecase.dart';
import 'package:super_fitness_app/features/home/domain/usecases/get_muscle_groups_usecase.dart';
import 'package:super_fitness_app/features/home/domain/usecases/get_random_muscles_usecase.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_model.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_groups_response_model.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_group_by_id_response_model.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_group_model.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([
  GetRandomMusclesUseCase,
  GetMuscleGroupsUseCase,
  GetMuscleGroupByIdUseCase,
  GetMealCategoriesUseCase,
])
void main() {
  late MockGetRandomMusclesUseCase mockGetRandomMusclesUseCase;
  late MockGetMuscleGroupsUseCase mockGetMuscleGroupsUseCase;
  late MockGetMuscleGroupByIdUseCase mockGetMuscleGroupByIdUseCase;
  late MockGetMealCategoriesUseCase mockGetMealCategoriesUseCase;
  late HomeCubit cubit;

  setUp(() {
    mockGetRandomMusclesUseCase = MockGetRandomMusclesUseCase();
    mockGetMuscleGroupsUseCase = MockGetMuscleGroupsUseCase();
    mockGetMuscleGroupByIdUseCase = MockGetMuscleGroupByIdUseCase();
    mockGetMealCategoriesUseCase = MockGetMealCategoriesUseCase();

    cubit = HomeCubit(
      mockGetRandomMusclesUseCase,
      mockGetMuscleGroupsUseCase,
      mockGetMuscleGroupByIdUseCase,
      mockGetMealCategoriesUseCase,
    );
  });

  final musclesResponse = MusclesResponse(
    message: 'success',
    totalMuscles: 1,
    muscles: [
      Muscle(
        id: '1',
        name: 'Biceps',
        image: 'https://example.com/biceps.png',
      )
    ],
  );

  final muscleGroup = MuscleGroup(id: 'g1', name: 'Upper Body');
  final muscleGroupsResponse = MuscleGroupsResponse(
    message: 'success',
    musclesGroup: [muscleGroup],
  );

  final muscleGroupByIdResponse = MuscleGroupByIdResponse(
    message: 'success',
    muscleGroup: muscleGroup,
    muscles: [
      Muscle(
        id: '1',
        name: 'Biceps',
        image: 'https://example.com/biceps.png',
      )
    ],
  );

  final mealCategoriesResponse = MealCategoriesResponse(
    categories: [
      MealCategory(
        id: '1',
        name: 'Breakfast',
        thumbnail: 'https://example.com/breakfast.png',
        description: 'Morning meals full of energy',
      ),
      MealCategory(
        id: '2',
        name: 'Lunch',
        thumbnail: 'https://example.com/lunch.png',
        description: 'Midday balanced dishes',
      ),
    ],
  );

  group('HomeCubit Tests', () {
    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeLoaded] when loadHomeData succeeds',
      build: () {
        when(mockGetRandomMusclesUseCase.call())
            .thenAnswer((_) async => musclesResponse);
        when(mockGetMuscleGroupsUseCase.call())
            .thenAnswer((_) async => muscleGroupsResponse);
        when(mockGetMuscleGroupByIdUseCase.call(any))
            .thenAnswer((_) async => muscleGroupByIdResponse);
        when(mockGetMealCategoriesUseCase.call())
            .thenAnswer((_) async => mealCategoriesResponse);
        return cubit;
      },
      act: (cubit) => cubit.loadHomeData(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeLoaded>(),
      ],
      verify: (_) {
        verify(mockGetRandomMusclesUseCase.call()).called(1);
        verify(mockGetMuscleGroupsUseCase.call()).called(1);
        verify(mockGetMuscleGroupByIdUseCase.call(any)).called(1);
        verify(mockGetMealCategoriesUseCase.call()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeError] when an exception occurs',
      build: () {
        when(mockGetRandomMusclesUseCase.call())
            .thenThrow(Exception('Failed to load muscles'));
        return cubit;
      },
      act: (cubit) => cubit.loadHomeData(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeError>(),
      ],
    );
  });
}
