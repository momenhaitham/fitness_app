import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/register/api/datasources/register_local_data_source_impl.dart';
import 'package:fitness_app/features/auth/register/data/models/register_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_local_data_source_impl_test.mocks.dart';

@GenerateMocks([RegisterLocalDataSourceImpl])
void main() {
  late RegisterLocalDataSourceImpl registerLocalDataSourceImpl;

  setUpAll(() {
    registerLocalDataSourceImpl = MockRegisterLocalDataSourceImpl();
    provideDummy<BaseResponse<RegisterDto>>(SuccessResponse<RegisterDto>(data: RegisterDto()));
  });

  group("Testing register function", () {
    test("Testing register function with success response", () async {
      final body = {
        "name": "John Doe",
        "email": "john@example.com",
        "password": "password123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return SuccessResponse<RegisterDto>(
            data: RegisterDto(
              message: "Registration successful",
              token: "sample_token_12345"
            )
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<SuccessResponse<RegisterDto>>());
      expect((response as SuccessResponse<RegisterDto>).data.message, equals("Registration successful"));
      expect(response.data.token, equals("sample_token_12345"));
    });

    test("Testing register function with error response", () async {
      final body = {
        "name": "John Doe",
        "email": "john@example.com",
        "password": "password123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Registration failed")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
      expect((response as ErrorResponse<RegisterDto>).error, isA<Exception>());
    });

    test("Testing register function with email already exists error", () async {
      final body = {
        "name": "John Doe",
        "email": "existing@example.com",
        "password": "password123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Email already exists")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
      expect((response as ErrorResponse<RegisterDto>).error.toString(), contains("Email already exists"));
    });

    test("Testing register function with invalid email format error", () async {
      final body = {
        "name": "John Doe",
        "email": "invalid-email",
        "password": "password123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Invalid email format")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
    });

    test("Testing register function with weak password error", () async {
      final body = {
        "name": "John Doe",
        "email": "john@example.com",
        "password": "123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Password is too weak")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
    });

    test("Testing register function with missing required fields error", () async {
      final body = {
        "name": "John Doe",
        "email": "john@example.com"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Missing required fields")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
    });

    test("Testing register function with empty body", () async {
      final body = <String, dynamic>{};

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Body cannot be empty")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
    });

    test("Testing register function with network error", () async {
      final body = {
        "name": "John Doe",
        "email": "john@example.com",
        "password": "password123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Network error")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
    });

    test("Testing register function with timeout error", () async {
      final body = {
        "name": "John Doe",
        "email": "john@example.com",
        "password": "password123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Request timeout")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
    });

    test("Testing register function with server error", () async {
      final body = {
        "name": "John Doe",
        "email": "john@example.com",
        "password": "password123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Internal server error")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
    });

    test("Testing register function with invalid phone number error", () async {
      final body = {
        "name": "John Doe",
        "email": "john@example.com",
        "password": "password123",
        "phone": "invalid_phone"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Invalid phone number")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
    });

    test("Testing register function with correct physical activity level", () async {
      final body = {
        "name": "John Doe",
        "email": "john@example.com",
        "password": "StrongPassword123!",
        "phone": "01234567890",
        "age": 25,
        "gender": "male",
        "activityLevel":"level1"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return SuccessResponse<RegisterDto>(
            data: RegisterDto(
              message: "Registration successful",
              token: "sample_token_12345",
              
            )
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<SuccessResponse<RegisterDto>>());
    });

    test("Testing register function returns non-null token", () async {
      final body = {
        "name": "John Doe",
        "email": "john@example.com",
        "password": "password123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return SuccessResponse<RegisterDto>(
            data: RegisterDto(
              message: "Registration successful",
              token: "sample_token_12345"
            )
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect((response as SuccessResponse<RegisterDto>).data.token, isNotNull);
    });

    test("Testing register function with special characters in name", () async {
      final body = {
        "name": "John O'Connor",
        "email": "john@example.com",
        "password": "password123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return SuccessResponse<RegisterDto>(
            data: RegisterDto(
              message: "Registration successful",
              token: "sample_token_12345"
            )
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<SuccessResponse<RegisterDto>>());
    });

    test("Testing register function with empty name error", () async {
      final body = {
        "name": "",
        "email": "john@example.com",
        "password": "password123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Name cannot be empty")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
    });

    test("Testing register function with empty email error", () async {
      final body = {
        "name": "John Doe",
        "email": "",
        "password": "password123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Email cannot be empty")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
    });

    test("Testing register function with empty password error", () async {
      final body = {
        "name": "John Doe",
        "email": "john@example.com",
        "password": "",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Password cannot be empty")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
    });

    test("Testing register function with unauthorized error", () async {
      final body = {
        "name": "John Doe",
        "email": "john@example.com",
        "password": "password123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Unauthorized")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
    });

    test("Testing register function with rate limit error", () async {
      final body = {
        "name": "John Doe",
        "email": "john@example.com",
        "password": "password123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("Too many requests. Please try again later")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
    });

    test("Testing register function with no internet connection error", () async {
      final body = {
        "name": "John Doe",
        "email": "john@example.com",
        "password": "password123",
        "phone": "01234567890"
      };

      when(registerLocalDataSourceImpl.register(body)).thenAnswer(
        (_) async {
          return ErrorResponse<RegisterDto>(
            error: Exception("No internet connection")
          );
        }
      );

      var response = await registerLocalDataSourceImpl.register(body);
      
      expect(response, isA<ErrorResponse<RegisterDto>>());
    });
  });
}