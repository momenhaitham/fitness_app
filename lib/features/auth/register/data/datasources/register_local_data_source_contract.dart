// TODO: data RegisterLocalDataSourceContract
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/register/data/models/register_dto.dart';

abstract class RegisterLocalDataSourceContract {
  Future<BaseResponse<RegisterDto>> register(Map<String, dynamic> body);
}