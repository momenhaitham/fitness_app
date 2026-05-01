import 'package:fitness_app/config/base_error/custom_exceptions.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/login/data/datasources/login_remote_data_source_contract.dart';
import 'package:fitness_app/features/login/data/models/login_response_model.dart';
import 'package:fitness_app/features/login/data/models/user_model.dart';
import 'package:fitness_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:fitness_app/features/login/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ── Mocks ─────────────────────────────────────────────────────────────────────

class MockLoginRemoteDataSource extends Mock
    implements LoginRemoteDataSourceContract {}

// ── Helpers ───────────────────────────────────────────────────────────────────

UserModel _buildUserModel({
  String id = 'u1',
  String firstName = 'Ahmed',
  String lastName = 'Ali',
  String email = 'ahmed@test.com',
}) {
  return UserModel(
    id: id,
    firstName: firstName,
    lastName: lastName,
    email: email,
  );
}

LoginResponseModel _successModel({UserModel? user, String? message}) {
  return LoginResponseModel(
    message: message ?? 'logged in successfully',
    user: user ?? _buildUserModel(),
    token: 'tok_abc',
  );
}

void main() {
  late MockLoginRemoteDataSource mockDataSource;
  late LoginRepositoryImpl repository;

  const email = 'ahmed@test.com';
  const password = 'Pass@1234';

  setUp(() {
    mockDataSource = MockLoginRemoteDataSource();
    repository = LoginRepositoryImpl(mockDataSource);
  });

  // ── Group: login ────────────────────────────────────────────────────────────

  group('LoginRepositoryImpl.login', () {
    // ── Happy path ────────────────────────────────────────────────────────────

    test('returns SuccessResponse<UserEntity> when data source succeeds with a user',
        () async {
      when(() => mockDataSource.login(email, password)).thenAnswer(
        (_) async => SuccessResponse(data: _successModel()),
      );

      final result = await repository.login(email, password);

      expect(result, isA<SuccessResponse<UserEntity>>());
      final success = result as SuccessResponse<UserEntity>;
      expect(success.data.id, equals('u1'));
      expect(success.data.firstName, equals('Ahmed'));
      expect(success.data.lastName, equals('Ali'));
      expect(success.data.email, equals('ahmed@test.com'));
    });

    test('maps all UserModel fields to UserEntity correctly', () async {
      final userModel = _buildUserModel(
        id: 'xyz',
        firstName: 'Sara',
        lastName: 'Mohamed',
        email: 'sara@test.com',
      );
      when(() => mockDataSource.login(email, password)).thenAnswer(
        (_) async => SuccessResponse(data: _successModel(user: userModel)),
      );

      final result = await repository.login(email, password);

      final entity = (result as SuccessResponse<UserEntity>).data;
      expect(entity.id, equals('xyz'));
      expect(entity.firstName, equals('Sara'));
      expect(entity.lastName, equals('Mohamed'));
      expect(entity.email, equals('sara@test.com'));
    });

    // ── Null user ─────────────────────────────────────────────────────────────

    test(
        'returns ErrorResponse when data source succeeds but user is null',
        () async {
      final modelWithNoUser = LoginResponseModel(
        message: 'Something went wrong',
        user: null,
        token: null,
      );
      when(() => mockDataSource.login(email, password)).thenAnswer(
        (_) async => SuccessResponse(data: modelWithNoUser),
      );

      final result = await repository.login(email, password);

      expect(result, isA<ErrorResponse<UserEntity>>());
    });

    test('ErrorResponse contains exception with message when user is null',
        () async {
      final modelWithNoUser = LoginResponseModel(
        message: 'User not found',
        user: null,
        token: null,
      );
      when(() => mockDataSource.login(email, password)).thenAnswer(
        (_) async => SuccessResponse(data: modelWithNoUser),
      );

      final result = await repository.login(email, password);

      final error = (result as ErrorResponse<UserEntity>).error;
      expect(error.toString(), contains('User not found'));
    });

    test('uses "Unknown error" message when model message is null and user is null',
        () async {
      final modelWithNoUser = LoginResponseModel(
        message: null,
        user: null,
        token: null,
      );
      when(() => mockDataSource.login(email, password)).thenAnswer(
        (_) async => SuccessResponse(data: modelWithNoUser),
      );

      final result = await repository.login(email, password);

      final error = (result as ErrorResponse<UserEntity>).error;
      expect(error.toString(), contains('Unknown error'));
    });

    // ── Error propagation ─────────────────────────────────────────────────────

    test('propagates ErrorResponse from data source when a ConnectionError occurs',
        () async {
      final connectionError = ConnectionError();
      when(() => mockDataSource.login(email, password)).thenAnswer(
        (_) async =>
            ErrorResponse<LoginResponseModel>(error: connectionError),
      );

      final result = await repository.login(email, password);

      expect(result, isA<ErrorResponse<UserEntity>>());
      final error = (result as ErrorResponse<UserEntity>).error;
      expect(error, isA<ConnectionError>());
    });

    test('propagates ErrorResponse from data source when a ServerError occurs',
        () async {
      final serverError = ServerError(message: 'Unauthorized');
      when(() => mockDataSource.login(email, password)).thenAnswer(
        (_) async =>
            ErrorResponse<LoginResponseModel>(error: serverError),
      );

      final result = await repository.login(email, password);

      expect(result, isA<ErrorResponse<UserEntity>>());
      final error = (result as ErrorResponse<UserEntity>).error;
      expect(error, isA<ServerError>());
      expect((error as ServerError).message, equals('Unauthorized'));
    });

    test('propagates ErrorResponse from data source when an UnexpectedError occurs',
        () async {
      final unexpectedError = UnexpectedError('weird stuff');
      when(() => mockDataSource.login(email, password)).thenAnswer(
        (_) async =>
            ErrorResponse<LoginResponseModel>(error: unexpectedError),
      );

      final result = await repository.login(email, password);

      expect(result, isA<ErrorResponse<UserEntity>>());
      expect(
        (result as ErrorResponse<UserEntity>).error,
        isA<UnexpectedError>(),
      );
    });

    // ── Delegation ────────────────────────────────────────────────────────────

    test('calls data source login exactly once with correct credentials',
        () async {
      when(() => mockDataSource.login(email, password)).thenAnswer(
        (_) async => SuccessResponse(data: _successModel()),
      );

      await repository.login(email, password);

      verify(() => mockDataSource.login(email, password)).called(1);
    });
  });
}
