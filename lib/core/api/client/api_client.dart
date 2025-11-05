import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/features/edit-profile/data/models/edit_profile_response.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/all_muscles_response.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/muscle_group_details_response.dart';
import '../../../features/auth/data/models/change_password_request_model.dart';
import '../../../features/auth/data/models/login_models/login_request_model.dart';
import '../../../features/auth/data/models/login_models/login_response_model.dart';
import '../../../features/auth/domain/responses/register_request_model.dart';
import '../../../features/auth/domain/responses/register_response.dart';
import '../../../features/auth/data/models/forgetpasswordmodels/forget_password_request_model.dart';
import '../../../features/auth/data/models/forgetpasswordmodels/reset_password_request_model.dart';
import '../../../features/auth/data/models/forgetpasswordmodels/verify_code_request_model.dart';
import '../../../features/edit-profile/data/models/edit_profile_request.dart';
import '../../../features/exercise/data/models/difficulty_levels_response.dart';
import '../../../features/exercise/data/models/get_exercise_by_muscle_and_difficulty.dart';
import '../../../features/food/data/models/meals_by_category_model.dart';
import '../../../features/home/data/models/meal_categories_response_model.dart';
import '../../../features/home/data/models/muscle_group_by_id_response_model.dart';
import '../../../features/home/data/models/muscles_response_model.dart';
import '../../../features/home/data/models/muscle_groups_response_model.dart'; // Add this import
import '../../../features/profile/data/models/profile_response.dart';
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

  @PATCH(ApiEndPoints.changePassword)
  @Extra({'auth': true})
  Future<String> changePassword(
    @Body() ChangePasswordRequestModel changePasswordRequestModel,
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

  @GET(ApiEndPoints.getAllDifficultyLevels)
  Future<DifficultyLevelResponse> getAllDifficultyLevels(
    @Query('primeMoverMuscleId') String primeMoverMuscleId,
  );

  @GET(ApiEndPoints.getExerciseByMuscleAndDifficulty)
  Future<GetExerciseByMuscleAndDifficulty> getExerciseByMuscleAndDifficulty(
    @Query('primeMoverMuscleId') String primeMoverMuscleId,
    @Query('difficultyLevelId') String difficultyLevelId,
  );

  @GET(ApiEndPoints.foodByCategory)
  Future<MealsByCategoryModel> getMealsByCategory(@Query("c") String category);

  @GET(ApiEndPoints.profileData)
  @Extra({'auth': true})
  Future<ProfileResponse> getProfile();

  @PUT(ApiEndPoints.editProfile)
  @Extra({'auth': true})
  Future<EditProfileResponse> editProfile(
      @Body() EditProfileRequest model);
}
