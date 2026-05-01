import 'package:fitness_app/features/auth/forget_password/domain/repo/forget_password_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../data/models/request/forget_password_request_model.dart';

@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepo _repository;

  ForgetPasswordUseCase(this._repository);
  Future<BaseResponse<void>> call(ForgetPasswordRequestModel request) =>
      _repository.forgetPassword(request);
}
