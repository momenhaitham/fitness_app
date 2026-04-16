// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../app_provider.dart' as _i30;
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
import '../../features/splash/presentation/view_model/splash_view_model.dart'
    as _i646;
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
    gh.factory<_i478.ForgetPasswordApiClient>(
      () => _i478.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i646.SplashViewModel>(
      () => _i646.SplashViewModel(
        gh<_i226.GetRememberMeUseCase>(),
        gh<_i554.GetFirstTimeLaunchedUseCase>(),
      ),
    );
    gh.factory<_i253.ForgetPasswordDataSource>(
      () => _i1058.ForgetPasswordDataSourceImpl(
        gh<_i478.ForgetPasswordApiClient>(),
      ),
    );
    gh.factory<_i484.ForgetPasswordRepo>(
      () => _i569.ForgetPasswordRepoImpl(gh<_i253.ForgetPasswordDataSource>()),
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
