import 'package:dio/dio.dart';
import 'package:fitness_app/config/dio_model/token_interceptors.dart';
import 'package:fitness_app/core/endpoint/app_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../local_storage_processes/domain/storage_data_source_contract.dart';

@module
abstract class DiModule {
  
   @lazySingleton
  Dio provideDio(
      BaseOptions baseOptions,
      PrettyDioLogger logger,
      TokenInterceptor tokenInterceptor,
      ) {
    final Dio dio = Dio(BaseOptions(baseUrl: AppEndPoint.baseUrl));
    dio.interceptors.add(tokenInterceptor);
    dio.interceptors.add(logger);
    return dio;
  }

  @lazySingleton
  BaseOptions provideBaseOptions() => BaseOptions(
    baseUrl: AppEndPoint.baseUrl,
    sendTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    connectTimeout: const Duration(seconds: 60),
  );

  @lazySingleton
  PrettyDioLogger providePrettyDioLogger() => PrettyDioLogger(
    requestHeader: kDebugMode,
    requestBody: kDebugMode,
    responseBody: kDebugMode,
    responseHeader: kDebugMode,
  );

  @lazySingleton
  FlutterSecureStorage provideFlutterSecureStorage() =>
      const FlutterSecureStorage();

  @lazySingleton
  TokenInterceptor provideTokenInterceptor(
      StorageDataSourceContract storageDataSourceContract,
      ) => TokenInterceptor(storageDataSourceContract);

  @preResolve
  Future<SharedPreferences> provideSharedPreferences() =>
      SharedPreferences.getInstance();
}
