import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/auth/domain/responses/auth_response.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/all_muscles_response.dart';
import 'package:super_fitness_app/features/workouts/data/models/workouts/muscle_group_details_response.dart';
import 'package:super_fitness_app/features/workouts/domain/repo/workouts_repo.dart';

@injectable
class WorkoutsUseCase {
  final WorkoutsRepo _workoutsRepo;
  WorkoutsUseCase(this._workoutsRepo);
  Future<AuthResponse<AllMusclesResponse>> invoke() async {
    return await _workoutsRepo.getAllMuscles();
  }

  Future<AuthResponse<MuscleGroupDetailsResponse>> getMusclesGroup(
    String id,
  ) async {
    return await _workoutsRepo.getMusclesGroup(id);
  }
}
