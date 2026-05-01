import 'package:dio/dio.dart';
import 'package:fitness_app/config/base_error/custom_exceptions.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/login/api/api_client/login_api_client.dart';
import 'package:fitness_app/features/login/api/datasources/login_remote_data_source_impl.dart';
import 'package:fitness_app/features/login/data/models/login_response_model.dart';
import 'package:fitness_app/features/login/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ── Mocks ─────────────────────────────────────────────────────────────────────

class MockLoginApiClient extends Mock implements LoginApiClient {}

// ── Helpers ───────────────────────────────────────────────────────────────────

LoginResponseModel _buildLoginResponse({UserModel? user, String? message}) {
  return LoginResponseModel(
    message: message ?? 'Success',
    user: user ??
        UserModel(
          id: 'u1',
          firstName: 'Ahmed',
          lastName: 'Ali',
          email: 'ahmed@test.com',
        ),
    token: 'tok_123',
  );
}

DioException _makeDioException(DioExceptionType type, {Response? response}) {
  return DioException(
    requestOptions: RequestOptions(path: '/auth/login'),
    type: type,
    response: response,
  );
}

void main() {
  late MockLoginApiClient mockApiClient;
  late LoginRemoteDataSourceImpl dataSource;

  const email = 'test@test.com';
  const password = 'Password123!';

  setUp(() {
    mockApiClient = MockLoginApiClient();
    dataSource = LoginRemoteDataSourceImpl(mockApiClient);
  });

  // ── Group: login ────────────────────────────────────────────────────────────

  group('LoginRemoteDataSourceImpl.login', () {
    // ── Success ──────────────────────────────────────────────────────────────

    test('returns SuccessResponse when API call succeeds', () async {
      final model = _buildLoginResponse();
      when(() => mockApiClient.login(any())).thenAnswer((_) async => model);

      final result = await dataSource.login(email, password);

      expect(result, isA<SuccessResponse<LoginResponseModel>>());
      final success = result as SuccessResponse<LoginResponseModel>;
      expect(success.data.token, equals('tok_123'));
      expect(success.data.user?.email, equals('ahmed@test.com'));
    });

    test('passes correct body map to API client', () async {
      final model = _buildLoginResponse();
      when(() => mockApiClient.login(any())).thenAnswer((_) async => model);

      await dataSource.login(email, password);

      verify(
        () => mockApiClient.login({'email': email, 'password': password}),
      ).called(1);
    });

    test('returns SuccessResponse with null user when API returns null user',
        () async {
      final model = LoginResponseModel(
        message: 'No user',
        user: null,
        token: null,
      );
      when(() => mockApiClient.login(any())).thenAnswer((_) async => model);

      final result = await dataSource.login(email, password);

      expect(result, isA<SuccessResponse<LoginResponseModel>>());
      final success = result as SuccessResponse<LoginResponseModel>;
      expect(success.data.user, isNull);
    });

    // ── Connection errors ─────────────────────────────────────────────────────

    test('returns ErrorResponse(ConnectionError) on connectionTimeout',
        () async {
      when(() => mockApiClient.login(any())).thenThrow(
        _makeDioException(DioExceptionType.connectionTimeout),
      );

      final result = await dataSource.login(email, password);

      expect(result, isA<ErrorResponse<LoginResponseModel>>());
      final error = (result as ErrorResponse<LoginResponseModel>).error;
      expect(error, isA<ConnectionError>());
    });

    test('returns ErrorResponse(ConnectionError) on connectionError', () async {
      when(() => mockApiClient.login(any())).thenThrow(
        _makeDioException(DioExceptionType.connectionError),
      );

      final result = await dataSource.login(email, password);

      expect(result, isA<ErrorResponse<LoginResponseModel>>());
      expect(
        (result as ErrorResponse<LoginResponseModel>).error,
        isA<ConnectionError>(),
      );
    });

    test('returns ErrorResponse(ConnectionError) on sendTimeout', () async {
      when(() => mockApiClient.login(any())).thenThrow(
        _makeDioException(DioExceptionType.sendTimeout),
      );

      final result = await dataSource.login(email, password);

      expect(result, isA<ErrorResponse<LoginResponseModel>>());
      expect(
        (result as ErrorResponse<LoginResponseModel>).error,
        isA<ConnectionError>(),
      );
    });

    test('returns ErrorResponse(ConnectionError) on receiveTimeout', () async {
      when(() => mockApiClient.login(any())).thenThrow(
        _makeDioException(DioExceptionType.receiveTimeout),
      );

      final result = await dataSource.login(email, password);

      expect(result, isA<ErrorResponse<LoginResponseModel>>());
      expect(
        (result as ErrorResponse<LoginResponseModel>).error,
        isA<ConnectionError>(),
      );
    });

    // ── Server error with JSON map body ───────────────────────────────────────

    test('returns ErrorResponse(ServerError) when server returns error JSON map',
        () async {
      final response = Response(
        requestOptions: RequestOptions(path: '/auth/login'),
        statusCode: 401,
        data: {'message': 'Invalid credentials', 'error': null},
      );
      when(() => mockApiClient.login(any())).thenThrow(
        _makeDioException(DioExceptionType.badResponse, response: response),
      );

      final result = await dataSource.login(email, password);

      expect(result, isA<ErrorResponse<LoginResponseModel>>());
      final error = (result as ErrorResponse<LoginResponseModel>).error;
      expect(error, isA<ServerError>());
      expect((error as ServerError).message, equals('Invalid credentials'));
    });

    // ── Server error with JSON string body ────────────────────────────────────

    test(
        'returns ErrorResponse(ServerError) when server error body is raw JSON string',
        () async {
      final response = Response(
        requestOptions: RequestOptions(path: '/auth/login'),
        statusCode: 500,
        data: '{"message":"Server error","error":null}',
      );
      when(() => mockApiClient.login(any())).thenThrow(
        _makeDioException(DioExceptionType.badResponse, response: response),
      );

      final result = await dataSource.login(email, password);

      expect(result, isA<ErrorResponse<LoginResponseModel>>());
      final error = (result as ErrorResponse<LoginResponseModel>).error;
      expect(error, isA<ServerError>());
      expect((error as ServerError).message, equals('Server error'));
    });

    // ── Null / unparseable error body ─────────────────────────────────────────

    test('returns ErrorResponse(UnexpectedError) when error body is null',
        () async {
      final response = Response(
        requestOptions: RequestOptions(path: '/auth/login'),
        statusCode: 500,
        data: null,
      );
      when(() => mockApiClient.login(any())).thenThrow(
        _makeDioException(DioExceptionType.badResponse, response: response),
      );

      final result = await dataSource.login(email, password);

      expect(result, isA<ErrorResponse<LoginResponseModel>>());
      expect(
        (result as ErrorResponse<LoginResponseModel>).error,
        isA<UnexpectedError>(),
      );
    });

    // test(
    //     'returns ErrorResponse(UnexpectedError) when error body is a non-map string',
    //     () async {
    //   final response = Response(
    //     requestOptions: RequestOptions(path: '/auth/login'),
    //     statusCode: 500,
    //     data: 'plain text error',
    //   );
    //   when(() => mockApiClient.login(any())).thenThrow(
    //     _makeDioException(DioExceptionType.badResponse, response: response),
    //   );

    //   final result = await dataSource.login(email, password);

    //   expect(result, isA<ErrorResponse<LoginResponseModel>>());
    //   expect(
    //     (result as ErrorResponse<LoginResponseModel>).error,
    //     isA<UnexpectedError>(),
    //   );
    // });

    // ── Non-Dio exception ─────────────────────────────────────────────────────

    test('returns ErrorResponse(UnexpectedError) on generic exception',
        () async {
      when(() => mockApiClient.login(any()))
          .thenThrow(Exception('Something went terribly wrong'));

      final result = await dataSource.login(email, password);

      expect(result, isA<ErrorResponse<LoginResponseModel>>());
      expect(
        (result as ErrorResponse<LoginResponseModel>).error,
        isA<UnexpectedError>(),
      );
    });
  });
}
