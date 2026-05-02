import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/register/data/datasources/register_local_data_source_contract.dart';
import 'package:fitness_app/features/auth/register/data/models/register_dto.dart';
import 'package:fitness_app/features/auth/register/data/repositories/register_repository_impl.dart';
import 'package:fitness_app/features/auth/register/domain/entities/register_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_repository_impl_test.mocks.dart';

@GenerateMocks([RegisterLocalDataSourceContract])
void main() {
  late RegisterRepositoryImpl registerRepositoryImpl;
  late MockRegisterLocalDataSourceContract mockDataSource;

  setUpAll(() {
    mockDataSource = MockRegisterLocalDataSourceContract();
    registerRepositoryImpl = RegisterRepositoryImpl(mockDataSource);

    provideDummy<BaseResponse<RegisterDto>>(
      SuccessResponse<RegisterDto>(data: RegisterDto()),
    );
  });

  group("Testing register function", () {
    
    test("should return SuccessResponse<RegisterModel> when dataSource returns success", () async {

      when(mockDataSource.register(any)).thenAnswer(
        (_) async => SuccessResponse<RegisterDto>(
          data: RegisterDto(),
        ),
      );

      final response = await registerRepositoryImpl.register({
    "firstName":"momen",
    "lastName":"haitham",
    "email":"momenhaithamcod18@gmail.com",
    "password":"Momen@123",
    "rePassword":"Momen@123",
    "gender":"male",
    "height":170,
    "weight":80,
    "age":22,
    "goal":"get married",
    "activityLevel":"level1"
      });

      expect(response, isA<SuccessResponse<RegisterModel>>());
    });

    test("should map RegisterDto to RegisterModel correctly", () async {

      final dto = RegisterDto(message: "success"); // لو عندك fields حطها

      when(mockDataSource.register(any)).thenAnswer(
        (_) async => SuccessResponse<RegisterDto>(data: dto),
      );

      final response = await registerRepositoryImpl.register({});

      expect(response, isA<SuccessResponse<RegisterModel>>());
      expect((response as SuccessResponse).data, isA<RegisterModel>());
    });

    test("should return ErrorResponse when dataSource returns error", () async {

      when(mockDataSource.register(any)).thenAnswer(
        (_) async => ErrorResponse<RegisterDto>(
          error: Exception("Register failed"),
        ),
      );

      final response = await registerRepositoryImpl.register({});

      expect(response, isA<ErrorResponse<RegisterModel>>());
      expect((response as ErrorResponse).error, isA<Exception>());
    });

    

  });
}