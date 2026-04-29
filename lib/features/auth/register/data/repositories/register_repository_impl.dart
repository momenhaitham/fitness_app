// TODO: data RegisterRepositoryImpl
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/register/data/datasources/register_local_data_source_contract.dart';
import 'package:fitness_app/features/auth/register/data/models/register_dto.dart';
import 'package:fitness_app/features/auth/register/domain/entities/register_model.dart';
import 'package:fitness_app/features/auth/register/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {

  RegisterLocalDataSourceContract _registerLocalDataSourceContract;
  RegisterRepositoryImpl(this._registerLocalDataSourceContract);
  @override
  Future<BaseResponse<RegisterModel>> register(Map<String, dynamic> body)async {
    final response = await _registerLocalDataSourceContract.register(body);
    switch(response){
      
      case SuccessResponse<RegisterDto>():
        return SuccessResponse<RegisterModel>(data: response.data.toModel());
      case ErrorResponse<RegisterDto>():
        return ErrorResponse<RegisterModel>(error: response.error);
    }
  }
  
}