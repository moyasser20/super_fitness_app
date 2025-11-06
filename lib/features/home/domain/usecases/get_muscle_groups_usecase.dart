import 'package:injectable/injectable.dart';

import '../../data/models/muscle_groups_response_model.dart';
import '../repos/muscles_repo.dart';

@injectable
class GetMuscleGroupsUseCase {
  final MusclesRepo _musclesRepo;

  GetMuscleGroupsUseCase(this._musclesRepo);

  Future<MuscleGroupsResponse> call() {
    return _musclesRepo.getMuscleGroups();
  }
}
