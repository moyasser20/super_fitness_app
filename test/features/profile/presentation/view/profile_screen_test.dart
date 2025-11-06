import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/common/widgets/custome_loading_indicator.dart';
import 'package:super_fitness_app/core/l10n/translation/app_localizations.dart';
import 'package:super_fitness_app/features/profile/domain/entity/user_entity.dart';
import 'package:super_fitness_app/features/profile/domain/usecases/get_profile_data_usecase.dart';
import 'package:super_fitness_app/features/profile/presentation/view/profile_screen.dart';
import 'package:super_fitness_app/features/profile/presentation/viewmodel/profile_viewmodel.dart';
import 'package:super_fitness_app/features/profile/presentation/viewmodel/states/profile_states.dart';
import 'package:super_fitness_app/core/errors/api_result.dart';
import 'package:super_fitness_app/features/auth/domain/usecase/sign_out_usecase.dart';
import '../viewmodel/profile_viewmodel_test.mocks.dart';

@GenerateMocks([GetProfileDataUseCase, SignOutUseCase])
void main() {
  late MockGetProfileDataUseCase mockUseCase;
  late MockSignOutUseCase mockSignOutUseCase;
  late ProfileViewModel viewModel;

  setUp(() {
    mockUseCase = MockGetProfileDataUseCase();
    mockSignOutUseCase = MockSignOutUseCase();
    viewModel = ProfileViewModel(mockUseCase, mockSignOutUseCase);
  });

  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider.value(value: viewModel, child: child),
    );
  }

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

  testWidgets('should show loading indicator when state is loading', (
    tester,
  ) async {
    // Arrange
    viewModel.emit(ProfileLoadingState());

    // Act
    await tester.pumpWidget(buildTestableWidget(const ProfileScreen()));

    // Assert
    expect(find.byType(AppLoadingIndicator), findsOneWidget);
  });

  testWidgets('should show error message when error state emitted', (
    tester,
  ) async {
    // Arrange
    viewModel.emit(ProfileErrorState("Something went wrong"));

    // Act
    await tester.pumpWidget(buildTestableWidget(const ProfileScreen()));

    // Assert
    expect(find.textContaining('Something went wrong'), findsOneWidget);
  });
}
