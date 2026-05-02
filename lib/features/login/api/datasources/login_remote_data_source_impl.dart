import 'package:fitness_app/config/api_utils/api_utils.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/login/api/api_client/login_api_client.dart';
import 'package:fitness_app/features/login/data/datasources/login_remote_data_source_contract.dart';
import 'package:fitness_app/features/login/data/models/login_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRemoteDataSourceContract)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSourceContract {
  final LoginApiClient _apiClient;

  LoginRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<LoginResponseModel>> login(
    String email,
    String password,
  ) async {
    return executeApi(
      () => _apiClient.login({'email': email, 'password': password}),
    );
  }
}
