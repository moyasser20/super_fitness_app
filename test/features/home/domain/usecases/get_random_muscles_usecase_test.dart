import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/home/domain/usecases/get_random_muscles_usecase.dart';
import 'package:super_fitness_app/features/home/domain/repos/muscles_repo.dart';
import 'package:super_fitness_app/features/home/data/models/muscles_response_model.dart';

@GenerateMocks([MusclesRepo])
import 'get_random_muscles_usecase_test.mocks.dart';

void main() {
  late MockMusclesRepo mockRepo;
  late GetRandomMusclesUseCase usecase;

  setUp(() {
    mockRepo = MockMusclesRepo();
    usecase = GetRandomMusclesUseCase(mockRepo);
  });

  group('GetRandomMusclesUseCase', () {
    test('returns MusclesResponse on success', () async {
      final response = MusclesResponse(message: 'msg', totalMuscles: 0, muscles: []);
      when(mockRepo.getRandomMuscles()).thenAnswer((_) async => response);
      final result = await usecase();
      expect(result, isA<MusclesResponse>());
      expect(result.message, 'msg');
      verify(mockRepo.getRandomMuscles()).called(1);
    });

    test('throws on repo error', () async {
      when(mockRepo.getRandomMuscles()).thenThrow(Exception('fail'));
      expect(() async => await usecase(), throwsException);
      verify(mockRepo.getRandomMuscles()).called(1);
    });
  });
}
