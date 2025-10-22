import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:super_fitness_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:super_fitness_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:super_fitness_app/features/auth/data/models/login_models/user_model.dart';
import 'package:super_fitness_app/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:super_fitness_app/features/auth/domain/responses/auth_response.dart';
import 'auth_repo_impl_test.mocks.dart';


@GenerateMocks([AuthRemoteDatasource])
void main() {
  late MockAuthRemoteDatasource mockDatasource;
  late AuthRepoImpl repo;

  setUp(() {
    mockDatasource = MockAuthRemoteDatasource();
    repo = AuthRepoImpl(mockDatasource);
  });

  group('AuthRepoImpl login', () {
    test(
        'Should call remote datasource and return AuthResponse with LoginResponse',
        () async {
      // Arrange
      final loginRequest = LoginRequest(
        email: "test@example.com",
        password: "password123",
      );

      final loginResponse = LoginResponse(
        message: "success",
        token: "fakeToken",
        user: User(
          Id: "68a7033aa8bca307f9df564d",
          firstName: "Test",
          lastName: "User",
          email: "test@example.com",
        ),
      );

      final successResponse =
          AuthResponse<LoginResponse>.success(loginResponse);
      when(mockDatasource.login(loginRequest))
          .thenAnswer((_) async => successResponse);

      // Act
      final result = await repo.login(loginRequest);

      // Assert
      expect(result, isA<AuthResponse<LoginResponse>>());
      expect(result.data?.message, "success");
      expect(result.data?.token, "fakeToken");
      expect(result.data?.user?.firstName, "Test");
      expect(result.isSuccess, true);
      verify(mockDatasource.login(loginRequest)).called(1);
    });

    test(
        'Should return error AuthResponse when remote datasource returns error',
        () async {
      // Arrange
      final loginRequest = LoginRequest(
        email: "wrong@example.com",
        password: "wrongpass",
      );

      final errorResponse = AuthResponse<LoginResponse>.error("Login failed");
      when(mockDatasource.login(loginRequest))
          .thenAnswer((_) async => errorResponse);

      // Act
      final result = await repo.login(loginRequest);

      // Assert
      expect(result, isA<AuthResponse<LoginResponse>>());
      expect(result.error, "Login failed");
      expect(result.isSuccess, false);
      verify(mockDatasource.login(loginRequest)).called(1);
    });
  });
}
