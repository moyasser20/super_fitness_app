import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/api/api_constants/api_end_points.dart';
import '../../data/models/meals_model.dart';

part 'meal_details_api_client.g.dart';


@injectable
@RestApi(baseUrl: "https://www.themealdb.com/api/json/v1/1/")
abstract class MealsApiClient {
  @factoryMethod
  factory MealsApiClient(@Named('mealsDio') Dio dio) = _MealsApiClient;

  @GET(ApiEndPoints.mealById)
  Future<MealsModel> getMealById(@Query('i') String id);
}
