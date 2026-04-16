import 'package:fitness_app/config/api_utils/api_utils.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/forget_password/data/data_sources/forget_password_data_source.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/domain/repo/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordRepo)
class ForgetPasswordRepoImpl implements ForgetPasswordRepo {
  final ForgetPasswordDataSource _dataSource;

  ForgetPasswordRepoImpl(this._dataSource);
  @override
  Future<BaseResponse<void>> forgetPassword(
    ForgetPasswordRequestModel request,
  ) async {
    return executeApi<void>(() async {
      await _dataSource.forgetPassword(request);
    });
  }

  @override
  Future<BaseResponse<void>> verifyCode(VerifyCodeRequestModel request) async {
    return executeApi<void>(() async {
      await _dataSource.verifyCode(request);
    });
  }

  @override
  Future<BaseResponse<void>> resetCode(ResetPasswordRequestModel request) {
    return executeApi<void>(() async {
      await _dataSource.resetPassword(request);
    });
  }
}
