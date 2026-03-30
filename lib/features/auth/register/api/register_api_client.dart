import 'package:dio/dio.dart';
import 'package:fitness_app/core/endpoint/app_endpoint.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'register_api_client.g.dart';

@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class RegisterApiClient {
  factory RegisterApiClient(Dio dio, {String baseUrl}) = _RegisterApiClient;

  @POST(AppEndPoint.register)
  Future<void> register();
}
