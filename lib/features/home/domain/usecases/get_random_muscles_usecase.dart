import 'package:injectable/injectable.dart';

import '../../data/models/muscles_response_model.dart';
import '../repos/muscles_repo.dart';

@injectable
class GetRandomMusclesUseCase {
  final MusclesRepo _musclesRepo;

  GetRandomMusclesUseCase(this._musclesRepo);

  Future<MusclesResponse> call() {
    return _musclesRepo.getRandomMuscles();
  }
}