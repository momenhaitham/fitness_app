import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/login/domain/entities/user_entity.dart';
import 'package:fitness_app/features/login/domain/repositories/login_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final LoginRepository _repository;

  LoginUseCase(this._repository);

  Future<BaseResponse<UserEntity>> call(String email, String password) {
    return _repository.login(email, password);
  }
}
