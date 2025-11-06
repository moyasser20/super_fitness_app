import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:super_fitness_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:super_fitness_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:super_fitness_app/features/auth/data/models/login_models/user_model.dart';
import 'package:super_fitness_app/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:super_fitness_app/features/auth/domain/responses/auth_response.dart';
import 'package:super_fitness_app/features/auth/domain/responses/register_request_model.dart';
import 'package:super_fitness_app/features/auth/domain/responses/register_response.dart';
import 'package:super_fitness_app/features/auth/domain/responses/user_response.dart';
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

        final successResponse = AuthResponse<LoginResponse>.success(
          loginResponse,
        );
        when(
          mockDatasource.login(loginRequest),
        ).thenAnswer((_) async => successResponse);

        // Act
        final result = await repo.login(loginRequest);

        // Assert
        expect(result, isA<AuthResponse<LoginResponse>>());
        expect(result.data?.message, "success");
        expect(result.data?.token, "fakeToken");
        expect(result.data?.user?.firstName, "Test");
        expect(result.isSuccess, true);
        verify(mockDatasource.login(loginRequest)).called(1);
      },
    );

    test(
      'Should return error AuthResponse when remote datasource returns error',
      () async {
        // Arrange
        final loginRequest = LoginRequest(
          email: "wrong@example.com",
          password: "wrongpass",
        );

        final errorResponse = AuthResponse<LoginResponse>.error("Login failed");
        when(
          mockDatasource.login(loginRequest),
        ).thenAnswer((_) async => errorResponse);

        // Act
        final result = await repo.login(loginRequest);

        // Assert
        expect(result, isA<AuthResponse<LoginResponse>>());
        expect(result.error, "Login failed");
        expect(result.isSuccess, false);
        verify(mockDatasource.login(loginRequest)).called(1);
      },
    );
  });

  // ---------------- Register tests ----------------
  group('AuthRepoImpl register', () {
    test(
      'Should call remote datasource and return AuthResponse<RegisterResponse>',
      () async {
        // Arrange
        final registerRequest = RegisterRequestModel(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          password: 'Abc@1234',
          rePassword: 'Abc@1234',
          gender: 'male',
          height: 180,
          weight: 75,
          age: 28,
          goal: 'health',
          activityLevel: 'moderate',
        );

        final registerResponse = RegisterResponse(
          message: 'success',
          token: 'fakeToken',
          user: UserResponse(
            id: 'id123',
            firstName: 'John',
            lastName: 'Doe',
            email: 'john@example.com',
            gender: 'male',
            age: 28,
            weight: 75,
            height: 180,
            activityLevel: 'moderate',
            goal: 'health',
            photo: 'https://example.com/photo.jpg',
            createdAt: '2024-01-01T00:00:00Z',
          ),
        );

        final successResponse = AuthResponse<RegisterResponse>.success(
          registerResponse,
        );
        when(
          mockDatasource.register(registerRequest),
        ).thenAnswer((_) async => successResponse);

        // Act
        final result = await repo.register(registerRequest);

        // Assert
        expect(result.isSuccess, true);
        expect(result.data?.token, 'fakeToken');
        expect(result.data?.user.firstName, 'John');
        verify(mockDatasource.register(registerRequest)).called(1);
      },
    );

    test(
      'Should return error AuthResponse when datasource returns error',
      () async {
        // Arrange
        final registerRequest = RegisterRequestModel(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          password: 'Abc@1234',
          rePassword: 'Abc@1234',
          gender: 'male',
          height: 180,
          weight: 75,
          age: 28,
          goal: 'health',
          activityLevel: 'moderate',
        );

        final errorResponse = AuthResponse<RegisterResponse>.error(
          'Email already exists',
        );
        when(
          mockDatasource.register(registerRequest),
        ).thenAnswer((_) async => errorResponse);

        // Act
        final result = await repo.register(registerRequest);

        // Assert
        expect(result.isSuccess, false);
        expect(result.error, contains('Email'));
        verify(mockDatasource.register(registerRequest)).called(1);
      },
    );
  });
}
