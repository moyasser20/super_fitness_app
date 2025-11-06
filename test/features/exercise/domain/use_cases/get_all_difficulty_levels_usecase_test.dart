import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/exercise/domain/repositories/exercise_repo.dart';
import 'package:super_fitness_app/features/exercise/domain/use_cases/get_all_difficulty_levels_usecase.dart';
import 'package:super_fitness_app/features/exercise/data/models/difficulty_levels_response.dart';

@GenerateMocks([ExerciseRepo])
import 'get_all_difficulty_levels_usecase_test.mocks.dart';

void main() {
  late GetAllDifficultyLevelsUseCase useCase;
  late MockExerciseRepo mockExerciseRepo;

  const tPrimeMoverMuscleId = 'muscle_123';
  final tResponse = DifficultyLevelResponse(
    difficultyLevels: [],
    totalLevels: 0,
  );

  setUp(() {
    mockExerciseRepo = MockExerciseRepo();
    useCase = GetAllDifficultyLevelsUseCase(mockExerciseRepo);
  });

  group('GetAllDifficultyLevelsUseCase', () {
    test(
      'should return DifficultyLevelResponse when repo call is successful',
      () async {
        // arrange
        when(
          mockExerciseRepo.getAllDifficultyLevels(any),
        ).thenAnswer((_) async => tResponse);

        // act
        final result = await useCase(tPrimeMoverMuscleId);

        // assert
        expect(result, equals(tResponse));
        verify(
          mockExerciseRepo.getAllDifficultyLevels(tPrimeMoverMuscleId),
        ).called(1);
        verifyNoMoreInteractions(mockExerciseRepo);
      },
    );

    test('should throw Exception when repo call fails', () async {
      // arrange
      when(
        mockExerciseRepo.getAllDifficultyLevels(any),
      ).thenThrow(Exception('Server Error'));

      // act
      final call = useCase;

      // assert
      expect(() => call(tPrimeMoverMuscleId), throwsA(isA<Exception>()));
    });
  });
}
