import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/food/data/models/meals_by_category_model.dart';
import 'package:super_fitness_app/features/food/domain/usecases/get_food_by_category_usecase.dart';
import 'package:super_fitness_app/features/food/presentation/viewmodel/food_states.dart';
import 'package:super_fitness_app/features/food/presentation/viewmodel/food_viewmodel.dart';
import 'package:super_fitness_app/features/home/data/models/meal_categories_response_model.dart';
import 'package:super_fitness_app/features/home/data/models/meal_category_model.dart';
import 'package:super_fitness_app/features/home/domain/usecases/get_meal_categories_usecase.dart';

import 'meals_cubit_test.mocks.dart';

@GenerateMocks([GetMealCategoriesUseCase, GetFoodByCategoryUseCase])
void main() {
  late MealsCubit cubit;
  late MockGetMealCategoriesUseCase mockGetMealCategoriesUseCase;
  late MockGetFoodByCategoryUseCase mockGetFoodByCategoryUseCase;

  setUp(() {
    mockGetMealCategoriesUseCase = MockGetMealCategoriesUseCase();
    mockGetFoodByCategoryUseCase = MockGetFoodByCategoryUseCase();
    cubit = MealsCubit(
      mockGetFoodByCategoryUseCase,
      mockGetMealCategoriesUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('MealsCubit', () {
    const category = 'Beef';

    final mockCategoryResponse = MealCategoriesResponse(
      categories: [
        MealCategory(name: category, id: '1', thumbnail: '', description: ''),
      ],
    );

    final mockMealsResponse = MealsByCategoryModel(
      meals: [
        Meals(idMeal: '123', strMeal: 'Steak', strMealThumb: 'thumb_url'),
      ],
    );

    test(
      'should emit [FoodLoading, FoodCategoriesLoaded, FoodLoading, FoodLoaded] when loadCategories succeeds',
      () async {
        // Arrange
        when(
          mockGetMealCategoriesUseCase(),
        ).thenAnswer((_) async => mockCategoryResponse);
        when(
          mockGetFoodByCategoryUseCase(category),
        ).thenAnswer((_) async => mockMealsResponse);

        // Assert later
        final expected = [
          isA<FoodLoading>(),
          isA<FoodCategoriesLoaded>(),
          isA<FoodLoading>(),
          isA<FoodLoaded>(),
        ];

        expectLater(cubit.stream, emitsInOrder(expected));

        // Act
        await cubit.loadCategories();
      },
    );

    test(
      'should emit [FoodLoading, FoodError] when loadCategories fails',
      () async {
        // Arrange
        when(
          mockGetMealCategoriesUseCase(),
        ).thenThrow(Exception('Failed to load categories'));

        final expected = [isA<FoodLoading>(), isA<FoodError>()];

        expectLater(cubit.stream, emitsInOrder(expected));

        // Act
        await cubit.loadCategories();
      },
    );

    test(
      'should emit [FoodLoading, FoodLoaded] when getMealsByCategory succeeds',
      () async {
        // Arrange
        when(
          mockGetFoodByCategoryUseCase(category),
        ).thenAnswer((_) async => mockMealsResponse);

        final expected = [isA<FoodLoading>(), isA<FoodLoaded>()];

        expectLater(cubit.stream, emitsInOrder(expected));

        // Act
        await cubit.getMealsByCategory(category);
      },
    );

    test(
      'should emit [FoodLoading, FoodError] when getMealsByCategory fails',
      () async {
        // Arrange
        when(
          mockGetFoodByCategoryUseCase(category),
        ).thenThrow(Exception('Network error'));

        final expected = [isA<FoodLoading>(), isA<FoodError>()];

        expectLater(cubit.stream, emitsInOrder(expected));

        // Act
        await cubit.getMealsByCategory(category);
      },
    );
  });
}
