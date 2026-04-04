// TODO: domain RegisterRepository
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/register/domain/entities/register_model.dart';

abstract class RegisterRepository {

  Future<BaseResponse<RegisterModel>> register(Map<String, dynamic> body);
}