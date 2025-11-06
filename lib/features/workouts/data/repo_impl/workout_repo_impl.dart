import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/auth/domain/responses/auth_response.dart';
import 'package:super_fitness_app/features/workouts/data/datasource/workouts_data_source.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/all_muscles_response.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/muscle_group_details_response.dart';
import 'package:super_fitness_app/features/workouts/domain/repo/workouts_repo.dart';

@LazySingleton(as: WorkoutsRepo)
class WorkoutRepoImpl implements WorkoutsRepo {
  final WorkoutsRemoteDataSource _workoutsDataSource;
  WorkoutRepoImpl(this._workoutsDataSource);

  @override
  Future<AuthResponse<AllMusclesResponse>> getAllMuscles() async {
    return await _workoutsDataSource.getAllMuscles();
  }

  @override
  Future<AuthResponse<MuscleGroupDetailsResponse>> getMusclesGroup(
    String id,
  ) async {
    return await _workoutsDataSource.getMusclesGroup(id);
  }
}
