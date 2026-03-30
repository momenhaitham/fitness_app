import 'package:fitness_app/config/local_storage_processes/domain/storage_data_source_contract.dart';
import 'package:injectable/injectable.dart';


@injectable
class GetFirstTimeLaunchedUseCase {
  final StorageDataSourceContract _storageDataSourceContract;
  GetFirstTimeLaunchedUseCase(this._storageDataSourceContract);

  Future<bool?> invokeGetFirstTimeLaunched()async => _storageDataSourceContract.getFirstTimeLaunched();
}