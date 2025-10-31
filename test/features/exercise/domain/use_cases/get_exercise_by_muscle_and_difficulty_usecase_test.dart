import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/exercise/domain/repositories/exercise_repo.dart';
import 'package:super_fitness_app/features/exercise/domain/use_cases/get_exercise_by_muscle_and_difficulty_usecase.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_exercise_by_muscle_and_difficulty.dart';

@GenerateMocks([ExerciseRepo])
import 'get_exercise_by_muscle_and_difficulty_usecase_test.mocks.dart';

void main() {
  late GetExerciseByMuscleAndDifficultyUseCase useCase;
  late MockExerciseRepo mockExerciseRepo;

  const tPrimeMoverMuscleId = 'muscle_123';
  const tDifficultyLevelId = 'difficulty_1';
  final tResponse = GetExerciseByMuscleAndDifficulty(exercises: []);

  setUp(() {
    mockExerciseRepo = MockExerciseRepo();
    useCase = GetExerciseByMuscleAndDifficultyUseCase(mockExerciseRepo);
  });

  group('GetExerciseByMuscleAndDifficultyUseCase', () {
    test('should return GetExerciseByMuscleAndDifficulty when repo call is successful', () async {
      // arrange
      when(mockExerciseRepo.getExerciseByMuscleAndDifficulty(any, any))
          .thenAnswer((_) async => tResponse);

      // act
      final result = await useCase(tPrimeMoverMuscleId, tDifficultyLevelId);

      // assert
      expect(result, equals(tResponse));
      verify(mockExerciseRepo.getExerciseByMuscleAndDifficulty(
        tPrimeMoverMuscleId,
        tDifficultyLevelId,
      )).called(1);
      verifyNoMoreInteractions(mockExerciseRepo);
    });

    test('should throw Exception when repo call fails', () async {
      // arrange
      when(mockExerciseRepo.getExerciseByMuscleAndDifficulty(any, any))
          .thenThrow(Exception('Server Error'));

      // act
      final call = useCase;

      // assert
      expect(
            () => call(tPrimeMoverMuscleId, tDifficultyLevelId),
        throwsA(isA<Exception>()),
      );
    });
  });
}
