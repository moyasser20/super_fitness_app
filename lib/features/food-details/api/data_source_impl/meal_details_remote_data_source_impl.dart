
import 'package:injectable/injectable.dart';
import '../../data/data_sources/meal_details_remote_data_source.dart';
import '../../data/models/meals_model.dart';
import '../client/meal_details_api_client.dart';

@LazySingleton(as: MealsDetailsRemoteDataSource)
class MealsDetailsRemoteDataSourceImpl implements MealsDetailsRemoteDataSource {
  final MealsApiClient _apiClient;

  MealsDetailsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<MealsModel> getMealById(String id) async {
    try {
      final response = await _apiClient.getMealById(id);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch meal by id: $e');
    }
  }
}