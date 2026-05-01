import 'package:dio/dio.dart';
import 'package:fitness_app/core/endpoint/app_endpoint.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/verify_code_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'forget_password_api_client.g.dart';

@injectable
@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class ForgetPasswordApiClient {
  @factoryMethod
  factory ForgetPasswordApiClient(Dio dio) = _ForgetPasswordApiClient;

  @POST(AppEndPoint.forgetPassword)
  Future<ForgetPasswordResponseModel> forgetPassword(
    @Body() ForgetPasswordRequestModel request,
  );

  @POST(AppEndPoint.verifyResetCode)
  Future<VerifyCodeResponseModel> verifyCode(
    @Body() VerifyCodeRequestModel request,
  );

  @PUT(AppEndPoint.resetPassword)
  Future<ResetPasswordResponseModel> resetPassword(
    @Body() ResetPasswordRequestModel request,
  );
}
