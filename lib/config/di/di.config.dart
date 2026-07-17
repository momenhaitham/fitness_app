// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/material.dart' as _i409;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../app_provider.dart' as _i30;
import '../../features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart'
    as _i1038;
import '../../features/auth/forget_password/api/api_client/forget_password_api_client.dart'
    as _i478;
import '../../features/auth/forget_password/api/data_sources/forget_password_data_source_impl.dart'
    as _i1058;
import '../../features/auth/forget_password/data/data_sources/forget_password_data_source.dart'
    as _i253;
import '../../features/auth/forget_password/data/models/repo/forget_password_repo_impl.dart'
    as _i569;
import '../../features/auth/forget_password/domain/repo/forget_password_repo.dart'
    as _i484;
import '../../features/auth/forget_password/domain/use_cases/forget_password_use_case.dart'
    as _i913;
import '../../features/auth/forget_password/domain/use_cases/reset_password_use_case.dart'
    as _i22;
import '../../features/auth/forget_password/domain/use_cases/verify_code_use_case.dart'
    as _i513;
import '../../features/auth/forget_password/presentation/view_model/forget_password_cubit/forget_password_cubit.dart'
    as _i294;
import '../../features/auth/register/api/api_client/register_api_client.dart'
    as _i517;
import '../../features/auth/register/api/datasources/register_local_data_source_impl.dart'
    as _i279;
import '../../features/auth/register/data/datasources/register_local_data_source_contract.dart'
    as _i34;
import '../../features/auth/register/data/repositories/register_repository_impl.dart'
    as _i200;
import '../../features/auth/register/domain/repositories/register_repository.dart'
    as _i57;
import '../../features/auth/register/domain/use_cases/register_usecase.dart'
    as _i1057;
import '../../features/auth/register/presentation/view_model/cubit/register_cubit.dart'
    as _i444;
import '../../features/home/api/api_client/home_api_client.dart' as _i592;
import '../../features/home/api/datasourse/home_remote_datasourse_impl.dart'
    as _i792;
import '../../features/home/data/datasourse/home_remote_datasourse_impl.dart'
    as _i656;
import '../../features/home/data/repository/home_repository_impl.dart' as _i9;
import '../../features/home/domian/repository/home_repository_contract.dart'
    as _i689;
import '../../features/home/domian/use_case/use_case.dart' as _i497;
import '../../features/home/presentation/view_model/home_cubit.dart' as _i940;
import '../../features/login/api/api_client/login_api_client.dart' as _i395;
import '../../features/login/api/datasources/login_remote_data_source_impl.dart'
    as _i904;
import '../../features/login/data/datasources/login_remote_data_source_contract.dart'
    as _i736;
import '../../features/login/data/repositories/login_repository_impl.dart'
    as _i1066;
import '../../features/login/domain/repositories/login_repository.dart'
    as _i902;
import '../../features/login/domain/use_cases/login_use_case.dart' as _i191;
import '../../features/login/presentation/view_model/cubit/login_cubit.dart'
    as _i753;
import '../../features/popular_training/api/api_client/popular_training_api_client.dart'
    as _i763;
import '../../features/popular_training/api/datasource/popular_training_datasource_impl.dart'
    as _i439;
import '../../features/popular_training/data/datasource/popular_training_datasource_contract.dart'
    as _i903;
import '../../features/popular_training/data/repository/popular_training_repository_impl.dart'
    as _i234;
import '../../features/popular_training/domain/repository/popular_training_repository_contract.dart'
    as _i539;
import '../../features/popular_training/domain/usecase/get_exercises_usecase.dart'
    as _i1048;
import '../../features/popular_training/domain/usecase/get_levels_usecase.dart'
    as _i548;
import '../../features/popular_training/domain/usecase/get_random_muscles_usecase.dart'
    as _i982;
import '../../features/popular_training/presentation/view_model/popular_training_cubit.dart'
    as _i695;
import '../../features/splash/presentation/view_model/splash_view_model.dart'
    as _i646;
import '../../features/workouts/api/api_client/workouts_api_client.dart'
    as _i123;
import '../../features/workouts/api/datasources/workouts_remote_data_source_impl.dart'
    as _i355;
import '../../features/workouts/data/datasources/workouts_remote_data_source_contract.dart'
    as _i668;
import '../../features/workouts/data/repositories/workouts_repository_impl.dart'
    as _i774;
import '../../features/workouts/domain/repositories/workouts_repository.dart'
    as _i243;
import '../../features/workouts/domain/use_cases/get_muscles_group_by_id_use_case.dart'
    as _i350;
import '../../features/workouts/domain/use_cases/get_muscles_group_use_case.dart'
    as _i249;
import '../../features/workouts/presentation/view_model/cubit/workouts_cubit.dart'
    as _i152;
import '../dio_model/di_module.dart' as _i334;
import '../dio_model/token_interceptors.dart' as _i475;
import '../local_storage_processes/data/storage_local_data_source_impl.dart'
    as _i498;
import '../local_storage_processes/data/token_repo_impl.dart' as _i943;
import '../local_storage_processes/domain/storage_data_source_contract.dart'
    as _i94;
import '../local_storage_processes/domain/token_repo_contract.dart' as _i352;
import '../local_storage_processes/domain/use_case/get_first_time_launched_use_case.dart'
    as _i554;
import '../local_storage_processes/domain/use_case/get_remember_me_use_case.dart'
    as _i226;
import '../local_storage_processes/domain/use_case/get_token_use_case.dart'
    as _i609;
import '../local_storage_processes/domain/use_case/logout_user_use_case.dart'
    as _i694;
import '../local_storage_processes/domain/use_case/read_and_write_locale_usecase.dart'
    as _i553;
import '../local_storage_processes/domain/use_case/read_and_write_tokin_usecase.dart'
    as _i830;
import '../local_storage_processes/domain/use_case/set_first_time_launched_use_case.dart'
    as _i402;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final diModule = _$DiModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => diModule.provideSharedPreferences(),
      preResolve: true,
    );
    gh.lazySingleton<_i361.BaseOptions>(() => diModule.provideBaseOptions());
    gh.lazySingleton<_i528.PrettyDioLogger>(
      () => diModule.providePrettyDioLogger(),
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => diModule.provideFlutterSecureStorage(),
    );
    gh.factory<_i94.StorageDataSourceContract>(
      () => _i498.StorageLocalDataSourceImpl(
        gh<_i558.FlutterSecureStorage>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i554.GetFirstTimeLaunchedUseCase>(
      () => _i554.GetFirstTimeLaunchedUseCase(
        gh<_i94.StorageDataSourceContract>(),
      ),
    );
    gh.factory<_i402.SetFirstTimeLaunchedUseCase>(
      () => _i402.SetFirstTimeLaunchedUseCase(
        gh<_i94.StorageDataSourceContract>(),
      ),
    );
    gh.factoryParam<_i1038.AppSectionsCubit, _i409.PageController?, dynamic>(
      (pageController, _) =>
          _i1038.AppSectionsCubit(pageController: pageController),
    );
    gh.factory<_i553.ReadAndWriteLocaleUsecase>(
      () =>
          _i553.ReadAndWriteLocaleUsecase(gh<_i94.StorageDataSourceContract>()),
    );
    gh.lazySingleton<_i475.TokenInterceptor>(
      () => diModule.provideTokenInterceptor(
        gh<_i94.StorageDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i830.ReadAndWriteTokinUsecase>(
      () =>
          _i830.ReadAndWriteTokinUsecase(gh<_i94.StorageDataSourceContract>()),
    );
    gh.factory<_i352.TokenRepoContract>(
      () => _i943.TokenRepoImpl(gh<_i94.StorageDataSourceContract>()),
    );
    gh.factory<_i226.GetRememberMeUseCase>(
      () => _i226.GetRememberMeUseCase(gh<_i352.TokenRepoContract>()),
    );
    gh.factory<_i609.GetTokenUseCase>(
      () => _i609.GetTokenUseCase(gh<_i352.TokenRepoContract>()),
    );
    gh.factory<_i694.LogoutUserUseCase>(
      () => _i694.LogoutUserUseCase(gh<_i352.TokenRepoContract>()),
    );
    gh.factory<_i30.AppProvider>(
      () => _i30.AppProvider(gh<_i553.ReadAndWriteLocaleUsecase>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => diModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i528.PrettyDioLogger>(),
        gh<_i475.TokenInterceptor>(),
      ),
    );
    gh.lazySingleton<_i123.WorkoutsApiClient>(
      () => _i123.WorkoutsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i478.ForgetPasswordApiClient>(
      () => _i478.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i517.RegisterApiClient>(
      () => _i517.RegisterApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i592.HomeApiClient>(() => _i592.HomeApiClient(gh<_i361.Dio>()));
    gh.factory<_i395.LoginApiClient>(
      () => _i395.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i763.PopularTrainingApiClient>(
      () => _i763.PopularTrainingApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i34.RegisterLocalDataSourceContract>(
      () => _i279.RegisterLocalDataSourceImpl(gh<_i517.RegisterApiClient>()),
    );
    gh.factory<_i646.SplashViewModel>(
      () => _i646.SplashViewModel(
        gh<_i226.GetRememberMeUseCase>(),
        gh<_i554.GetFirstTimeLaunchedUseCase>(),
      ),
    );
    gh.factory<_i903.PopularTrainingRemoteDataSource>(
      () => _i439.PopularTrainingRemoteDataSourceImpl(
        gh<_i763.PopularTrainingApiClient>(),
      ),
    );
    gh.factory<_i736.LoginRemoteDataSourceContract>(
      () => _i904.LoginRemoteDataSourceImpl(gh<_i395.LoginApiClient>()),
    );
    gh.factory<_i57.RegisterRepository>(
      () => _i200.RegisterRepositoryImpl(
        gh<_i34.RegisterLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i1057.RegisterUsecase>(
      () => _i1057.RegisterUsecase(gh<_i57.RegisterRepository>()),
    );
    gh.factory<_i539.PopularTrainingRepository>(
      () => _i234.PopularTrainingRepositoryImpl(
        gh<_i903.PopularTrainingRemoteDataSource>(),
      ),
    );
    gh.factory<_i253.ForgetPasswordDataSource>(
      () => _i1058.ForgetPasswordDataSourceImpl(
        gh<_i478.ForgetPasswordApiClient>(),
      ),
    );
    gh.factory<_i902.LoginRepository>(
      () =>
          _i1066.LoginRepositoryImpl(gh<_i736.LoginRemoteDataSourceContract>()),
    );
    gh.factory<_i668.WorkoutRemoteDataSourceContract>(
      () => _i355.WorkoutsRemoteDataSourceImpl(gh<_i123.WorkoutsApiClient>()),
    );
    gh.factory<_i243.WorkoutRepository>(
      () => _i774.WorkoutsRepositoryImpl(
        gh<_i668.WorkoutRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i656.HomeRemoteDataSourceContract>(
      () => _i792.HomeRemoteDataSourceImpl(gh<_i592.HomeApiClient>()),
    );
    gh.factory<_i444.RegisterCubit>(
      () => _i444.RegisterCubit(gh<_i1057.RegisterUsecase>()),
    );
    gh.factory<_i689.HomeRepositoryContract>(
      () => _i9.HomeRepositoryImpl(gh<_i656.HomeRemoteDataSourceContract>()),
    );
    gh.factory<_i484.ForgetPasswordRepo>(
      () => _i569.ForgetPasswordRepoImpl(gh<_i253.ForgetPasswordDataSource>()),
    );
    gh.factory<_i1048.GetExercisesUseCase>(
      () => _i1048.GetExercisesUseCase(gh<_i539.PopularTrainingRepository>()),
    );
    gh.factory<_i548.GetLevelsUseCase>(
      () => _i548.GetLevelsUseCase(gh<_i539.PopularTrainingRepository>()),
    );
    gh.factory<_i982.GetRandomMusclesUseCase>(
      () =>
          _i982.GetRandomMusclesUseCase(gh<_i539.PopularTrainingRepository>()),
    );
    gh.factory<_i191.LoginUseCase>(
      () => _i191.LoginUseCase(gh<_i902.LoginRepository>()),
    );
    gh.factory<_i695.PopularTrainingCubit>(
      () => _i695.PopularTrainingCubit(
        gh<_i548.GetLevelsUseCase>(),
        gh<_i982.GetRandomMusclesUseCase>(),
        gh<_i1048.GetExercisesUseCase>(),
      ),
    );
    gh.factory<_i753.LoginCubit>(
      () => _i753.LoginCubit(gh<_i191.LoginUseCase>()),
    );
    gh.factory<_i350.GetMusclesGroupByIdUseCase>(
      () => _i350.GetMusclesGroupByIdUseCase(gh<_i243.WorkoutRepository>()),
    );
    gh.factory<_i249.GetMusclesGroupUseCase>(
      () => _i249.GetMusclesGroupUseCase(gh<_i243.WorkoutRepository>()),
    );
    gh.factory<_i497.HomeUseCase>(
      () => _i497.HomeUseCase(gh<_i689.HomeRepositoryContract>()),
    );
    gh.factory<_i913.ForgetPasswordUseCase>(
      () => _i913.ForgetPasswordUseCase(gh<_i484.ForgetPasswordRepo>()),
    );
    gh.factory<_i22.ResetPasswordUseCase>(
      () => _i22.ResetPasswordUseCase(gh<_i484.ForgetPasswordRepo>()),
    );
    gh.factory<_i513.VerifyCodeUseCase>(
      () => _i513.VerifyCodeUseCase(gh<_i484.ForgetPasswordRepo>()),
    );
    gh.factory<_i152.WorkoutsCubit>(
      () => _i152.WorkoutsCubit(
        gh<_i249.GetMusclesGroupUseCase>(),
        gh<_i350.GetMusclesGroupByIdUseCase>(),
      ),
    );
    gh.factory<_i940.HomeCubit>(() => _i940.HomeCubit(gh<_i497.HomeUseCase>()));
    gh.factory<_i294.ForgetPasswordCubit>(
      () => _i294.ForgetPasswordCubit(
        forgetPasswordUseCase: gh<_i913.ForgetPasswordUseCase>(),
        verifyCodeUseCase: gh<_i513.VerifyCodeUseCase>(),
        resetPasswordUseCase: gh<_i22.ResetPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$DiModule extends _i334.DiModule {}
