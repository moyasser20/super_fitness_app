import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/food/data/datasource/food_remote_datasource.dart';
import 'package:super_fitness_app/features/food/data/models/meals_by_category_model.dart';
import 'package:super_fitness_app/features/food/data/repo_impl/food_repo_impl.dart';

import 'food_repository_impl_test.mocks.dart';

@GenerateMocks([FoodRemoteDatasource])
void main() {
  late FoodRepositoryImpl repository;
  late MockFoodRemoteDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockFoodRemoteDatasource();
    repository = FoodRepositoryImpl(mockDatasource);
  });

  const category = 'Seafood';

  final mockResponse = MealsByCategoryModel(
    meals: [
      Meals(
        idMeal: '1',
        strMeal: 'Grilled Salmon',
        strMealThumb: 'https://test.com/salmon.jpg',
      ),
    ],
  );

  group('FoodRepositoryImpl', () {
    test('should return MealsByCategoryModel when data source returns data', () async {
      // Arrange
      when(mockDatasource.getFoodByCategory(category))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.getMealsByCategory(category);

      // Assert
      expect(result, isA<MealsByCategoryModel>());
      expect(result.meals?.first.strMeal, 'Grilled Salmon');
      verify(mockDatasource.getFoodByCategory(category)).called(1);
    });

    test('should throw Exception when datasource throws', () async {
      // Arrange
      when(mockDatasource.getFoodByCategory(category))
          .thenThrow(Exception('Network Error'));

      // Act
      final call = repository.getMealsByCategory;

      // Assert
      expect(() => call(category), throwsA(isA<Exception>()));
      verify(mockDatasource.getFoodByCategory(category)).called(1);
    });
  });
}
