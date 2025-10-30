import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/all_muscles_response.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/muscle_group_details_response.dart';
import '../../../features/auth/data/models/login_models/login_request_model.dart';
import '../../../features/auth/data/models/login_models/login_response_model.dart';
import '../../../features/auth/domain/responses/register_request_model.dart';
import '../../../features/auth/domain/responses/register_response.dart';
import '../../../features/auth/data/models/forgetpasswordmodels/forget_password_request_model.dart';
import '../../../features/auth/data/models/forgetpasswordmodels/reset_password_request_model.dart';
import '../../../features/auth/data/models/forgetpasswordmodels/verify_code_request_model.dart';
import '../../../features/home/data/models/meal_categories_response_model.dart';
import '../../../features/home/data/models/muscle_group_by_id_response_model.dart';
import '../../../features/home/data/models/muscles_response_model.dart';
import '../../../features/home/data/models/muscle_groups_response_model.dart'; // Add this import
import '../api_constants/api_end_points.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) = _ApiClient;

  @POST(ApiEndPoints.signup)
  Future<RegisterResponse> register(
    @Body() RegisterRequestModel registerRequest,
  );

  @POST(ApiEndPoints.forgetPassword)
  Future<String> forgetPassword(
    @Body() ForgetPasswordRequestModel forgetPasswordRequestModel,
  );

  @POST(ApiEndPoints.verifyReset)
  Future<String> verifyResetCode(
    @Body() VerifyCodeRequestModel verifyResetCode,
  );

  @PUT(ApiEndPoints.resetPassword)
  Future<String> resetPassword(
    @Body() ResetPasswordRequestModel resetPasswordRequestModel,
  );

  @POST(ApiEndPoints.login)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @GET(ApiEndPoints.musclesEndPoint)
  Future<AllMusclesResponse> getAllMuscles();

  @GET('${ApiEndPoints.musclesGroupEndPoint}/{id}')
  Future<MuscleGroupDetailsResponse> getMusclesGroup(@Path('id') String id);

  @GET(ApiEndPoints.recommendationMuscles)
  Future<MusclesResponse> getRandomMuscles();

  @GET(ApiEndPoints.muscleGroups)
  Future<MuscleGroupsResponse> getMuscleGroups();

  @GET(ApiEndPoints.muscleGroupsById)
  Future<MuscleGroupByIdResponse> getMuscleGroupById(
    @Path('groupId') String groupId,
  );

  @GET(ApiEndPoints.mealCategoriesUri)
  Future<MealCategoriesResponse> getMealCategories();
}
