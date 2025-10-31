// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/api/data_source_impl/auth_remote_data_source_impl.dart'
    as _i758;
import '../../features/auth/data/datasource/auth_remote_data_source.dart'
    as _i24;
import '../../features/auth/data/repo_impl/auth_repo_impl.dart' as _i279;
import '../../features/auth/domain/repo/auth_repo.dart' as _i170;
import '../../features/auth/domain/usecase/login_usecases.dart' as _i442;
import '../../features/auth/domain/usecases/forgetpasswordusecases/forget_password_usecase.dart'
    as _i957;
import '../../features/auth/domain/usecases/forgetpasswordusecases/reset_password_usecase.dart'
    as _i135;
import '../../features/auth/domain/usecases/forgetpasswordusecases/verify_code_usecase.dart'
    as _i188;
import '../../features/auth/presentation/forgetpassword/viewmodel/forget_password_viewmodel.dart'
    as _i556;
import '../../features/auth/presentation/forgetpassword/viewmodel/reset_password_viewmodel.dart'
    as _i697;
import '../../features/auth/presentation/forgetpassword/viewmodel/verify_code_viewmodel.dart'
    as _i0;
import '../../features/auth/presentation/login/presentation/viewmodel/login_viewmodel.dart'
    as _i462;
import '../../features/auth/presentation/register/viewmodel/register_viewmodel/register_cubit.dart'
    as _i416;
import '../../features/exercise/api/datasource_impl/exercise_remote_datasource_impl.dart'
    as _i1030;
import '../../features/exercise/data/datasource/exercise_remote_datasource.dart'
    as _i153;
import '../../features/exercise/data/repositories_impl/exercise_repo_impl.dart'
    as _i917;
import '../../features/exercise/domain/repositories/exercise_repo.dart'
    as _i204;
import '../../features/exercise/domain/use_cases/get_all_difficulty_levels_usecase.dart'
    as _i196;
import '../../features/exercise/domain/use_cases/get_exercise_by_muscle_and_difficulty_usecase.dart'
    as _i486;
import '../../features/exercise/presentation/viewmodel/exercise_viewmodel.dart'
    as _i1042;
import '../../features/home/api/data_source_impl/muscles_remote_data_source_impl.dart'
    as _i476;
import '../../features/home/data/data_source/muscles_remote_data_source.dart'
    as _i439;
import '../../features/home/data/repo_impl/muscles_repo_impl.dart' as _i635;
import '../../features/home/domain/repos/muscles_repo.dart' as _i732;
import '../../features/home/domain/usecases/get_meal_categories_usecase.dart'
    as _i91;
import '../../features/home/domain/usecases/get_muscle_group_by_id_usecase.dart'
    as _i585;
import '../../features/home/domain/usecases/get_muscle_groups_usecase.dart'
    as _i890;
import '../../features/home/domain/usecases/get_random_muscles_usecase.dart'
    as _i365;
import '../../features/home/presentation/viewmodel/home_cubit.dart' as _i925;
import '../../features/workouts/api/data_source_impl/workouts_remote_data_source_impl.dart'
    as _i61;
import '../../features/workouts/data/datasource/workouts_data_source.dart'
    as _i194;
import '../../features/workouts/data/repo_impl/workout_repo_impl.dart' as _i940;
import '../../features/workouts/domain/repo/workouts_repo.dart' as _i301;
import '../../features/workouts/domain/usecase/workouts_use_case.dart' as _i532;
import '../../features/workouts/presentation/viewmodel/workouts_view_model.dart'
    as _i433;
import '../api/client/api_client.dart' as _i364;
import 'dio_module/dio_module.dart' as _i484;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.factory<String>(
      () => dioModule.baseUrl,
      instanceName: 'baseurl',
    );
    gh.lazySingleton<_i361.Dio>(
        () => dioModule.dio(gh<String>(instanceName: 'baseurl')));
    gh.factory<_i364.ApiClient>(() => _i364.ApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseurl'),
        ));
    gh.lazySingleton<_i194.WorkoutsRemoteDataSource>(
        () => _i61.WorkoutsRemoteDataSourceImpl(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i301.WorkoutsRepo>(
        () => _i940.WorkoutRepoImpl(gh<_i194.WorkoutsRemoteDataSource>()));
    gh.factory<_i697.ResetPasswordCubit>(
        () => _i697.ResetPasswordCubit(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i153.ExerciseRemoteDatasource>(
        () => _i1030.ExerciseRemoteDatasourceImpl(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i24.AuthRemoteDatasource>(
        () => _i758.AuthRemoteDatasourceImpl(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i170.AuthRepo>(
        () => _i279.AuthRepoImpl(gh<_i24.AuthRemoteDatasource>()));
    gh.lazySingleton<_i439.MusclesRemoteDatasource>(
        () => _i476.MusclesRemoteDatasourceImpl(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i732.MusclesRepo>(
        () => _i635.MusclesRepoImpl(gh<_i439.MusclesRemoteDatasource>()));
    gh.factory<_i532.WorkoutsUseCase>(
        () => _i532.WorkoutsUseCase(gh<_i301.WorkoutsRepo>()));
    gh.factory<_i442.LoginUseCase>(
        () => _i442.LoginUseCase(gh<_i170.AuthRepo>()));
    gh.factory<_i957.ForgetPasswordUseCase>(
        () => _i957.ForgetPasswordUseCase(gh<_i170.AuthRepo>()));
    gh.factory<_i135.ResetPasswordUseCase>(
        () => _i135.ResetPasswordUseCase(gh<_i170.AuthRepo>()));
    gh.factory<_i188.VerifyCodeUseCase>(
        () => _i188.VerifyCodeUseCase(gh<_i170.AuthRepo>()));
    gh.factory<_i416.RegisterCubit>(
        () => _i416.RegisterCubit(gh<_i170.AuthRepo>()));
    gh.factory<_i91.GetMealCategoriesUseCase>(
        () => _i91.GetMealCategoriesUseCase(gh<_i732.MusclesRepo>()));
    gh.factory<_i890.GetMuscleGroupsUseCase>(
        () => _i890.GetMuscleGroupsUseCase(gh<_i732.MusclesRepo>()));
    gh.factory<_i585.GetMuscleGroupByIdUseCase>(
        () => _i585.GetMuscleGroupByIdUseCase(gh<_i732.MusclesRepo>()));
    gh.factory<_i365.GetRandomMusclesUseCase>(
        () => _i365.GetRandomMusclesUseCase(gh<_i732.MusclesRepo>()));
    gh.factory<_i204.ExerciseRepo>(
        () => _i917.ExerciseRepoImpl(gh<_i153.ExerciseRemoteDatasource>()));
    gh.factory<_i462.LoginViewModel>(
        () => _i462.LoginViewModel(gh<_i442.LoginUseCase>()));
    gh.factory<_i925.HomeCubit>(() => _i925.HomeCubit(
          gh<_i365.GetRandomMusclesUseCase>(),
          gh<_i890.GetMuscleGroupsUseCase>(),
          gh<_i585.GetMuscleGroupByIdUseCase>(),
          gh<_i91.GetMealCategoriesUseCase>(),
        ));
    gh.factory<_i0.VerifyCodeCubit>(() => _i0.VerifyCodeCubit(
          gh<_i188.VerifyCodeUseCase>(),
          gh<_i957.ForgetPasswordUseCase>(),
        ));
    gh.factory<_i433.WorkoutsViewModel>(
        () => _i433.WorkoutsViewModel(gh<_i532.WorkoutsUseCase>()));
    gh.factory<_i556.ForgetPasswordCubit>(
        () => _i556.ForgetPasswordCubit(gh<_i957.ForgetPasswordUseCase>()));
    gh.lazySingleton<_i196.GetAllDifficultyLevelsUseCase>(
        () => _i196.GetAllDifficultyLevelsUseCase(gh<_i204.ExerciseRepo>()));
    gh.lazySingleton<_i486.GetExerciseByMuscleAndDifficultyUseCase>(() =>
        _i486.GetExerciseByMuscleAndDifficultyUseCase(
            gh<_i204.ExerciseRepo>()));
    gh.factory<_i1042.ExerciseViewModel>(() => _i1042.ExerciseViewModel(
          getAllDifficultyLevelsUseCase:
              gh<_i196.GetAllDifficultyLevelsUseCase>(),
          getExerciseByMuscleAndDifficultyUseCase:
              gh<_i486.GetExerciseByMuscleAndDifficultyUseCase>(),
        ));
    return this;
  }
}

class _$DioModule extends _i484.DioModule {}
