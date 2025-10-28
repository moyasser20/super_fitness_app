import 'package:injectable/injectable.dart';

import '../../data/models/muscle_group_by_id_response_model.dart';
import '../repos/muscles_repo.dart';

@injectable
class GetMuscleGroupByIdUseCase {
  final MusclesRepo _musclesRepo;

  GetMuscleGroupByIdUseCase(this._musclesRepo);

  Future<MuscleGroupByIdResponse> call(String groupId) {
    return _musclesRepo.getMuscleGroupById(groupId);
  }
}