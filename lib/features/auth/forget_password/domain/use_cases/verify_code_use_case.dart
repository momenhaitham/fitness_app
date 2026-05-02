import 'package:fitness_app/features/auth/forget_password/domain/repo/forget_password_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../data/models/request/verify_code_request_model.dart';

@injectable
class VerifyCodeUseCase {
  final ForgetPasswordRepo _repository;

  VerifyCodeUseCase(this._repository);
  Future<BaseResponse<void>> call(VerifyCodeRequestModel request) =>
      _repository.verifyCode(request);
}
