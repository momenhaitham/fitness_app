// TODO: api RegisterLocalDataSourceImpl
import 'package:fitness_app/config/api_utils/api_utils.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/register/api/api_client/register_api_client.dart';
import 'package:fitness_app/features/auth/register/data/datasources/register_local_data_source_contract.dart';
import 'package:fitness_app/features/auth/register/data/models/register_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterLocalDataSourceContract)
class RegisterLocalDataSourceImpl implements RegisterLocalDataSourceContract{
  final RegisterApiClient _apiClient;
  RegisterLocalDataSourceImpl(this._apiClient);
  @override
  Future<BaseResponse<RegisterDto>> register(Map<String, dynamic> body)async {
    return await executeApi(() =>  _apiClient.register(body),);
  }
}