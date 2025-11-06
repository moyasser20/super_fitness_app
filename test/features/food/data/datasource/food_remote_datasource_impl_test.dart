import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/api/client/api_client.dart';
import 'package:super_fitness_app/features/food/api/datasource_impl/food_remote_datasource_impl.dart';
import 'package:super_fitness_app/features/food/data/models/meals_by_category_model.dart';

import 'food_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late FoodRemoteDatasourceImpl datasource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    datasource = FoodRemoteDatasourceImpl(mockApiClient);
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

  group('FoodRemoteDatasourceImpl Tests', () {
    test(
      'should return MealsByCategoryModel when ApiClient returns data',
      () async {
        // Arrange
        when(
          mockApiClient.getMealsByCategory(category),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await datasource.getFoodByCategory(category);

        // Assert
        expect(result, isA<MealsByCategoryModel>());
        expect(result.meals?.first.strMeal, 'Grilled Salmon');
        verify(mockApiClient.getMealsByCategory(category)).called(1);
      },
    );

    test('should throw an Exception when ApiClient throws an error', () async {
      // Arrange
      when(
        mockApiClient.getMealsByCategory(category),
      ).thenThrow(Exception('Network Error'));

      // Act
      final call = datasource.getFoodByCategory;

      // Assert
      expect(() => call(category), throwsA(isA<Exception>()));
      verify(mockApiClient.getMealsByCategory(category)).called(1);
    });
  });
}
