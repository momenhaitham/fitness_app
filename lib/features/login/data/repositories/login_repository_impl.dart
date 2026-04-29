import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/login/domain/entities/user_entity.dart';
import 'package:fitness_app/features/login/domain/repositories/login_repository.dart';
import 'package:fitness_app/features/login/data/datasources/login_remote_data_source_contract.dart';
import 'package:fitness_app/features/login/data/models/login_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSourceContract _remoteDataSource;

  LoginRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<UserEntity>> login(String email, String password) async {
    final response = await _remoteDataSource.login(email, password);
    switch (response) {
      case SuccessResponse<LoginResponseModel>():
        if (response.data.user != null) {
          // TODO: Save the token using TokenRepoContract if needed
          return SuccessResponse(data: response.data.user!.toEntity());
        } else {
          return ErrorResponse(error: Exception(response.data.message ?? "Unknown error"));
        }
      case ErrorResponse<LoginResponseModel>():
        return ErrorResponse(error: response.error);
    }
  }
}
