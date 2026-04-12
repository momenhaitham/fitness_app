import 'package:dio/dio.dart';
import 'package:fitness_app/core/endpoint/app_endpoint.dart';
import 'package:fitness_app/features/auth/register/data/models/register_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'register_api_client.g.dart';

@injectable
@RestApi()
abstract class RegisterApiClient {
  @factoryMethod
  factory RegisterApiClient(Dio dio) = _RegisterApiClient;

  @POST(AppEndPoint.register)
  Future<RegisterDto> register(@Body() Map<String, dynamic> body);
}