import 'package:injectable/injectable.dart';
import '../../data/data_sources/meal_details_remote_data_source.dart';
import '../../data/models/meal_details_model.dart';
import '../../data/models/meals_model.dart';
import '../client/meal_details_api_client.dart';

@LazySingleton(as: MealsDetailsRemoteDataSource)
class MealsDetailsRemoteDataSourceImpl implements MealsDetailsRemoteDataSource {
  final MealsApiClient _apiClient;

  MealsDetailsRemoteDataSourceImpl(this._apiClient);

  @override
  @override
  Future<MealsModel> getMealById(String id) async {
    try {
      // ✅ Retrofit هيعمل parse JSON تلقائي إلى MealDetailsModel
      final MealDetailsModel details = await _apiClient.getMealById(id);

      if (details.meals != null && details.meals!.isNotEmpty) {
        print("✅ Meal fetched successfully: ${details.meals!.first.strMeal}");
        return details.meals!.first;
      } else {
        print("⚠️ No meals found in API response.");
        throw Exception("No meals found in API response");
      }
    } catch (e, s) {
      print("🔥 Error in getMealById: $e\n$s");
      throw Exception('Failed to fetch meal by id: $e');
    }
  }
}
