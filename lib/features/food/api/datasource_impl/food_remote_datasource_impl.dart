import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/api/client/api_client.dart';
import 'package:super_fitness_app/features/food/data/datasource/food_remote_datasource.dart';
import 'package:super_fitness_app/features/food/data/models/meals_by_category_model.dart';

@LazySingleton(as: FoodRemoteDatasource)
class FoodRemoteDatasourceImpl implements FoodRemoteDatasource{
  final ApiClient _apiClient;

  FoodRemoteDatasourceImpl(this._apiClient);

  @override
  Future<MealsByCategoryModel> getFoodByCategory(String category) async {
    try {
      return await _apiClient.getMealsByCategory(category);
    } catch (e){
      throw Exception('failed to load food');
    }
  }

}