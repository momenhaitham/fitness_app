import 'package:dio/dio.dart';
import 'package:fitness_app/core/endpoint/app_endpoint.dart';
import 'package:fitness_app/features/login/data/models/login_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'login_api_client.g.dart';

@injectable
@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class LoginApiClient {
  @factoryMethod
  factory LoginApiClient(Dio dio) = _LoginApiClient;

  @POST(AppEndPoint.login)
  Future<LoginResponseModel> login(@Body() Map<String, dynamic> body);
}
