import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/login/domain/entities/user_entity.dart';

abstract class LoginRepository {
  Future<BaseResponse<UserEntity>> login(String email, String password);
}
