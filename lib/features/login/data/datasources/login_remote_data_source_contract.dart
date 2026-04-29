import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/login/data/models/login_response_model.dart';

abstract class LoginRemoteDataSourceContract {
  Future<BaseResponse<LoginResponseModel>> login(String email, String password);
}
