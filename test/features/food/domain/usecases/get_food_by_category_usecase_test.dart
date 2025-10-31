import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/food/data/models/meals_by_category_model.dart';
import 'package:super_fitness_app/features/food/domain/repo/food_repo.dart';
import 'package:super_fitness_app/features/food/domain/usecases/get_food_by_category_usecase.dart';

import 'get_food_by_category_usecase_test.mocks.dart';

@GenerateMocks([FoodRepository])
void main() {
  late GetFoodByCategoryUseCase useCase;
  late MockFoodRepository mockFoodRepository;

  setUp(() {
    mockFoodRepository = MockFoodRepository();
    useCase = GetFoodByCategoryUseCase(mockFoodRepository);
  });

  const category = 'Seafood';

  final mockResponse = MealsByCategoryModel(
    meals: [
      Meals(
        idMeal: '52772',
        strMeal: 'Grilled Salmon',
        strMealThumb: 'https://www.themealdb.com/images/media/meals/1548772327.jpg',
      ),
    ],
  );

  group('GetFoodByCategoryUseCase', () {
    test('should return MealsByCategoryModel when repository returns data', () async {
      // Arrange
      when(mockFoodRepository.getMealsByCategory(category))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await useCase(category);

      // Assert
      expect(result, isA<MealsByCategoryModel>());
      expect(result.meals?.first.strMeal, equals('Grilled Salmon'));
      verify(mockFoodRepository.getMealsByCategory(category)).called(1);
    });

    test('should throw Exception when repository throws', () async {
      // Arrange
      when(mockFoodRepository.getMealsByCategory(category))
          .thenThrow(Exception('Network error'));

      // Act
      final call = useCase.call;

      // Assert
      expect(() => call(category), throwsA(isA<Exception>()));
      verify(mockFoodRepository.getMealsByCategory(category)).called(1);
    });
  });
}
