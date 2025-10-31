
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/home/domain/usecases/get_muscle_groups_usecase.dart';
import 'package:super_fitness_app/features/home/domain/repos/muscles_repo.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_groups_response_model.dart';

@GenerateMocks([MusclesRepo])
import 'get_muscle_groups_usecase_test.mocks.dart';

void main() {
  late MockMusclesRepo mockRepo;
  late GetMuscleGroupsUseCase usecase;

  setUp(() {
    mockRepo = MockMusclesRepo();
    usecase = GetMuscleGroupsUseCase(mockRepo);
  });

  group('GetMuscleGroupsUseCase', () {
    test('returns MuscleGroupsResponse on success', () async {
      final response = MuscleGroupsResponse(message: 'ok', musclesGroup: []);
      when(mockRepo.getMuscleGroups()).thenAnswer((_) async => response);
      final result = await usecase();
      expect(result, isA<MuscleGroupsResponse>());
      expect(result.message, 'ok');
      verify(mockRepo.getMuscleGroups()).called(1);
    });

    test('throws on repo error', () async {
      when(mockRepo.getMuscleGroups()).thenThrow(Exception('fail'));
      expect(() async => await usecase(), throwsException);
      verify(mockRepo.getMuscleGroups()).called(1);
    });
  });
}
