import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/register/domain/entities/register_model.dart';
import 'package:fitness_app/features/auth/register/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUsecase {
  final RegisterRepository _registerRepository;
  RegisterUsecase(this._registerRepository);
  Future<BaseResponse<RegisterModel>> invoke(Map<String, dynamic> body)async {
    return await _registerRepository.register(body);
  }
}