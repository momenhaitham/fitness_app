import 'package:fitness_app/features/auth/forget_password/domain/repo/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../data/models/request/reset_password_request_model.dart';

@injectable
class ResetPasswordUseCase {
  final ForgetPasswordRepo _repository;

  ResetPasswordUseCase(this._repository);
  Future<BaseResponse<void>> call(ResetPasswordRequestModel request) =>
      _repository.resetCode(request);
}
