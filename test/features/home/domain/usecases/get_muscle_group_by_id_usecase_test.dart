import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/home/domain/usecases/get_muscle_group_by_id_usecase.dart';
import 'package:super_fitness_app/features/home/domain/repos/muscles_repo.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_group_by_id_response_model.dart';
import 'package:super_fitness_app/features/home/data/models/muscle_group_model.dart';

@GenerateMocks([MusclesRepo])
import 'get_muscle_group_by_id_usecase_test.mocks.dart';

void main() {
  late MockMusclesRepo mockRepo;
  late GetMuscleGroupByIdUseCase usecase;

  setUp(() {
    mockRepo = MockMusclesRepo();
    usecase = GetMuscleGroupByIdUseCase(mockRepo);
  });

  group('GetMuscleGroupByIdUseCase', () {
    test('returns MuscleGroupByIdResponse on success', () async {
      final muscleGroup = MuscleGroup(id: 'g1', name: 'Upper Body');
      final response = MuscleGroupByIdResponse(message: 'done', muscleGroup: muscleGroup, muscles: []);
      when(mockRepo.getMuscleGroupById('gid')).thenAnswer((_) async => response);
      final result = await usecase('gid');
      expect(result, isA<MuscleGroupByIdResponse>());
      expect(result.message, 'done');
      verify(mockRepo.getMuscleGroupById('gid')).called(1);
    });

    test('throws on repo error', () async {
      when(mockRepo.getMuscleGroupById('gid')).thenThrow(Exception('fail'));
      expect(() async => await usecase('gid'), throwsException);
      verify(mockRepo.getMuscleGroupById('gid')).called(1);
    });
  });
}
