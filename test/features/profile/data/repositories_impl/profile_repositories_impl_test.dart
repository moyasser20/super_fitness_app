import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/errors/api_result.dart';
import 'package:super_fitness_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:super_fitness_app/features/profile/data/models/profile_response.dart';
import 'package:super_fitness_app/features/profile/data/models/user_model.dart';
import 'package:super_fitness_app/features/profile/data/repositories_impl/profile_repository_impl.dart';
import 'package:super_fitness_app/features/profile/domain/entity/user_entity.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repository.dart';

import 'profile_repositories_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDatasource])
void main() {
  late MockProfileRemoteDatasource mockRemoteDatasource;
  late ProfileRepository repository;

  setUpAll(() {
    provideDummy<ApiResult<ProfileResponse>>(
      ApiSuccessResult(
        ProfileResponse(
          message: "dummy",
          user: User(
            Id: "0",
            firstName: "Dummy",
            lastName: "User",
            email: "dummy@example.com",
            gender: "unknown",
            photo: "",
            createdAt: "2025-01-01T00:00:00Z",
            age: 0,
            weight: 10,
            height: 100,
            activityLevel: '',
            goal: '',
          ),
        ),
      ),
    );
  });

  setUp(() {
    mockRemoteDatasource = MockProfileRemoteDatasource();
    repository = ProfileRepositoryImpl(mockRemoteDatasource);
  });

  group('ProfileRepositoryImpl - getProfile', () {
    test('should return ApiSuccessResult<UserEntity> when succeeds', () async {
      // arrange
      final fakeUser = User(
        Id: "123",
        firstName: "Mouayed",
        lastName: "Mohamed",
        email: "mouayed@example.com",
        gender: "male",
        photo: "https://example.com/photo.jpg",
        createdAt: "2025-09-01T00:00:00Z",
        age: 20,
        weight: 85,
        height: 185,
        activityLevel: 'Level1',
        goal: 'Lose Weight',
      );

      final fakeResponse = ProfileResponse(
        message: "Profile fetched successfully",
        user: fakeUser,
      );

      when(
        mockRemoteDatasource.getProfile(),
      ).thenAnswer((_) async => ApiSuccessResult(fakeResponse));

      // act
      final result = await repository.getProfile();
      final success = result as ApiSuccessResult<UserEntity>;

      // assert
      expect(result, isA<ApiSuccessResult<UserEntity>>());
      expect(success.data.id, "123");
      expect(success.data.firstName, "Mouayed");
      expect(success.data.lastName, "Mohamed");
      expect(success.data.email, "mouayed@example.com");
      verify(mockRemoteDatasource.getProfile()).called(1);
    });

    test(
      'should return ApiErrorResult when datasource returns error',
      () async {
        when(
          mockRemoteDatasource.getProfile(),
        ).thenAnswer((_) async => ApiErrorResult("Unauthorized"));

        final result = await repository.getProfile();

        expect(result, isA<ApiErrorResult>());
        expect((result as ApiErrorResult).errorMessage, "Unauthorized");
        verify(mockRemoteDatasource.getProfile()).called(1);
      },
    );
  });
}
