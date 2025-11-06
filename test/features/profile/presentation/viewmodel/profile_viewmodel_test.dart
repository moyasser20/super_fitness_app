import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/errors/api_result.dart';
import 'package:super_fitness_app/features/profile/domain/entity/user_entity.dart';
import 'package:super_fitness_app/features/profile/domain/usecases/get_profile_data_usecase.dart';
import 'package:super_fitness_app/features/profile/presentation/viewmodel/profile_viewmodel.dart';
import 'package:super_fitness_app/features/profile/presentation/viewmodel/states/profile_states.dart';
import 'package:super_fitness_app/features/auth/domain/usecase/sign_out_usecase.dart';

import 'profile_viewmodel_test.mocks.dart';

@GenerateMocks([GetProfileDataUseCase, SignOutUseCase])
void main() {
  late MockGetProfileDataUseCase mockGetProfileDataUseCase;
  late MockSignOutUseCase mockSignOutUseCase;
  late ProfileViewModel viewModel;

  setUp(() {
    mockGetProfileDataUseCase = MockGetProfileDataUseCase();
    mockSignOutUseCase = MockSignOutUseCase();
    viewModel = ProfileViewModel(mockGetProfileDataUseCase, mockSignOutUseCase);
  });

  setUpAll(() {
    provideDummy<ApiResult<UserEntity>>(
      ApiSuccessResult(
        UserEntity(
          id: "0",
          firstName: "Dummy",
          lastName: "User",
          email: "dummy@example.com",
          gender: "unknown",
          photo: "",
          age: 0,
          weight: 0,
          height: 0,
          activityLevel: '',
          goal: '',
        ),
      ),
    );
  });

  group('ProfileViewModel Tests', () {
    test('should emit [Loading, Success] when getProfile succeeds', () async {
      // Arrange
      final user = UserEntity(
        id: '1',
        firstName: 'Jane',
        lastName: 'Smith',
        email: 'jane@example.com',
        photo: '',
        gender: '',
        age: 20,
        weight: 80,
        height: 185,
        activityLevel: 'Level1',
        goal: 'Lose Weight',
      );

      when(
        mockGetProfileDataUseCase(),
      ).thenAnswer((_) async => ApiSuccessResult(user));

      // Assert later
      expectLater(
        viewModel.stream,
        emitsInOrder([
          isA<ProfileLoadingState>(),
          isA<ProfileSuccessState>().having(
            (s) => s.user,
            'user',
            equals(user),
          ),
        ]),
      );

      // Act
      await viewModel.getProfile();

      verify(mockGetProfileDataUseCase()).called(1);
    });

    test('should emit [Loading, Error] when getProfile fails', () async {
      // Arrange
      const errorMessage = 'Network Error';
      when(
        mockGetProfileDataUseCase(),
      ).thenAnswer((_) async => ApiErrorResult(errorMessage));

      // Assert later
      expectLater(
        viewModel.stream,
        emitsInOrder([
          isA<ProfileLoadingState>(),
          isA<ProfileErrorState>().having(
            (s) => s.message,
            'message',
            equals(errorMessage),
          ),
        ]),
      );

      // Act
      await viewModel.getProfile();

      verify(mockGetProfileDataUseCase()).called(1);
    });

    test('should clear user cache', () {
      // Arrange
      viewModel.user = UserEntity(
        id: '1',
        firstName: 'Jane',
        lastName: 'Smith',
        email: 'jane@example.com',
        photo: '',
        gender: '',
        age: 20,
        weight: 80,
        height: 185,
        activityLevel: 'Level1',
        goal: 'Lose Weight',
      );

      // Act
      viewModel.clearProfileCache();

      // Assert
      expect(viewModel.user, isNull);
    });
  });
}
